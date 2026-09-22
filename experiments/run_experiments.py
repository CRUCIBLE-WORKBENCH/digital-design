"""Verilog Experiments -- RTL Simulation Runner.

Compiles and simulates every experiment in this directory with
iverilog/vvp. Synthesis is NOT run by default -- pass --synth to also run
each experiment's yosys_synthesis.tcl after its simulation passes.

Pure Python + subprocess, no shell scripting -- runs identically on
Windows, macOS, and Linux, and under the igny CLI's own shell via:

    igny run script run_experiments.py
    igny run script run_experiments.py -- --synth

Usage:
    python run_experiments.py                # RTL simulation only (default)
    python run_experiments.py --synth         # also run yosys synthesis checks
    python run_experiments.py --keep          # keep generated files
    python run_experiments.py 01_half_adder   # run just one experiment

Prerequisites:
    - iverilog + vvp on PATH (yosys too, if you pass --synth)
    - Under Crucible: run this from inside `igny env shell` so those tools
      resolve, or via `igny run script` directly.
"""
from __future__ import annotations

import argparse
import re
import shutil
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent
# Per-command ceiling so a hung tool can never stall the whole run.
TIMEOUT_S = 300
FAIL_RE = re.compile(r"^FAIL:|TESTS? FAILED|MISMATCH", re.MULTILINE)


def find_experiments(only: str | None) -> list[Path]:
    exps = sorted(
        p for p in SCRIPT_DIR.iterdir()
        if p.is_dir() and re.match(r"^\d+_", p.name)
    )
    if only:
        exps = [p for p in exps if p.name == only]
    return exps


def detect_layout(exp: Path) -> tuple[Path, Path] | None:
    """Return (source, testbench) paths for the three known layouts, or None."""
    design_v = exp / "design.v"
    tb_design_v = exp / "tb_design.v"
    if design_v.is_file() and tb_design_v.is_file():
        return design_v, tb_design_v

    makefile = exp / "Makefile"
    src_sv = exp / "src" / "design.sv"
    tb_sv = exp / "tb" / "tb.sv"
    if makefile.is_file() and src_sv.is_file() and tb_sv.is_file():
        return src_sv, tb_sv

    tbs = sorted(exp.glob("*_tb.v"))
    if tbs:
        tb = tbs[0]
        src = exp / (tb.name[: -len("_tb.v")] + ".v")
        if src.is_file():
            return src, tb

    return None


def run(cmd: list[str], cwd: Path) -> tuple[int, str]:
    # Resolve the executable to a full path first. On Windows, subprocess only
    # appends ".exe" to a bare name, so tool shims installed as ".cmd"/".bat"
    # (as Crucible installs them) are only launchable by their full path.
    exe = shutil.which(cmd[0]) or cmd[0]
    try:
        proc = subprocess.run(
            [exe, *cmd[1:]],
            cwd=cwd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
            errors="replace",
            timeout=TIMEOUT_S,
        )
        return proc.returncode, proc.stdout
    except subprocess.TimeoutExpired:
        return 124, f"timed out after {TIMEOUT_S}s: {' '.join(cmd)}"
    except (FileNotFoundError, OSError) as exc:
        return 127, str(exc)


def simulate(exp: Path, keep: bool) -> tuple[str, str]:
    """Returns (status, log) where status is PASS / FAIL / SKIP."""
    layout = detect_layout(exp)
    if layout is None:
        return "SKIP", ""

    src, tb = layout
    vvp_out = exp / "_run.vvp"
    rc, log = run(
        ["iverilog", "-g2012", "-o", str(vvp_out), str(src), str(tb)], cwd=exp
    )
    if rc == 0:
        rc2, log2 = run(["vvp", str(vvp_out)], cwd=exp)
        log = log + log2
        rc = rc2

    ok = rc == 0 and not FAIL_RE.search(log)

    if not keep:
        vvp_out.unlink(missing_ok=True)
        for vcd in exp.glob("*.vcd"):
            vcd.unlink(missing_ok=True)

    return ("PASS" if ok else "FAIL"), log


def synthesize(exp: Path, keep: bool) -> tuple[bool, str] | None:
    tcl = exp / "yosys_synthesis.tcl"
    if not tcl.is_file():
        return None

    gen_files = [
        line.strip().split()[-1]
        for line in tcl.read_text(encoding="utf-8").splitlines()
        if line.startswith("write_verilog")
    ]

    rc, log = run(["yosys", "-s", "yosys_synthesis.tcl"], cwd=exp)

    if not keep:
        for name in gen_files:
            (exp / name).unlink(missing_ok=True)

    return rc == 0, log


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("only", nargs="?", default=None, help="run just this experiment")
    parser.add_argument("--synth", action="store_true", help="also run yosys_synthesis.tcl")
    parser.add_argument("--keep", action="store_true", help="keep generated files")
    args = parser.parse_args()

    print("\nStep 1/2  Checking tools...")
    iverilog = shutil.which("iverilog")
    if not iverilog:
        print("ERROR: iverilog not found on PATH.", file=sys.stderr)
        print(
            "       Install it, or run this from inside 'igny env shell' "
            "after 'igny tool install iverilog'.",
            file=sys.stderr,
        )
        return 1
    print(f"          iverilog: {iverilog}")

    if args.synth:
        yosys = shutil.which("yosys")
        if not yosys:
            print("ERROR: --synth requested but yosys not found on PATH.", file=sys.stderr)
            return 1
        print(f"          yosys:    {yosys}")

    exps = find_experiments(args.only)
    if not exps:
        print(f"ERROR: no experiment matching '{args.only}' found.", file=sys.stderr)
        return 1

    print(
        f"\nStep 2/2  Running experiment: {args.only}\n"
        if args.only
        else "\nStep 2/2  Running all experiments...\n"
    )

    sim_pass = sim_fail = synth_pass = synth_fail = 0
    failed: list[str] = []
    synth_failed: list[str] = []

    for exp in exps:
        status, log = simulate(exp, args.keep)
        if status == "PASS":
            sim_pass += 1
            print(f"PASS  {exp.name}")
        elif status == "FAIL":
            sim_fail += 1
            failed.append(exp.name)
            print(f"FAIL  {exp.name}")
            for line in log.splitlines():
                print(f"      {line}")
        else:
            print(
                f"SKIP  {exp.name} (no runnable design/testbench pair -- "
                "e.g. a synthesis/STA flow experiment)"
            )

        if args.synth:
            result = synthesize(exp, args.keep)
            if result is not None:
                ok, slog = result
                if ok:
                    synth_pass += 1
                    print(f"  synth OK  {exp.name}")
                else:
                    synth_fail += 1
                    synth_failed.append(exp.name)
                    print(f"  synth FAIL {exp.name}")
                    for line in slog.splitlines()[-5:]:
                        print(f"      {line}")

    print("\n==================== SUMMARY ====================")
    print(f"Simulation: {sim_pass} passed, {sim_fail} failed")
    if failed:
        print(f"  failed: {' '.join(failed)}")
    if args.synth:
        print(f"Synthesis:  {synth_pass} passed, {synth_fail} failed")
        if synth_failed:
            print(f"  failed: {' '.join(synth_failed)}")

    return 0 if sim_fail == 0 and synth_fail == 0 else 1


if __name__ == "__main__":
    sys.exit(main())
