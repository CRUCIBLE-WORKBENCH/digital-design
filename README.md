# Verilog Experiments

54 self-contained digital design experiments, numbered `01`–`54`, from single
gates to a full RTL-to-netlist synthesis flow. Numbering is thematic:
combinational arithmetic first, then data routing, sequential logic, state
machines, memory, modeling styles, and finally the synthesis flow.

Everything here is plain Verilog (`.v`) simulated with Icarus Verilog, plus a
Yosys `.tcl` synthesis check per experiment.

## Two layouts, two ways to run

Experiments come in two shapes. Check which one you have with `ls`.

**1. `design.v` + `tb_design.v`** — the majority.

```bash
cd experiments/01_half_adder
igny run iverilog -o sim.vvp design.v tb_design.v
igny run vvp sim.vvp
```

**2. `<name>.v` + `<name>_tb.v`** — named-module walkthrough experiments.

```bash
cd experiments/31_d_flipflop_with_qbar
igny run iverilog -o sim.vvp dff.v dff_tb.v
igny run vvp sim.vvp
```

Under Crucible, prefix with `igny run` (`igny run iverilog ...`, `igny run vvp ...`) or
work inside `igny env shell`.

**`cd` into the experiment first.** You *can* pass paths from the repo root
(`igny run iverilog -o experiments/01_half_adder/sim experiments/01_half_adder/design.v ...`),
but each testbench calls `$dumpfile("<name>.vcd")` with a relative path, so the
waveform lands in whatever directory you launched from rather than beside the
design. `igny run` launches the tool in your current directory.

## Waveforms

Every testbench already calls `$dumpfile`/`$dumpvars`, so each simulation
generates a `.vcd` (Value Change Dump) waveform file in that experiment's
directory (`01_half_adder.vcd`, `51_inverter_behavioral.vcd`, ...).

**By default, these files are cleaned up after each test passes** to save disk
space — they're easy to regenerate. To **keep** them for inspection:

```bash
python run_experiments.py --keep           # standard python
igny run script run_experiments.py -- --keep   # via igny
```

Then open a waveform:

```bash
cd experiments/01_half_adder
igny run gtkwave 01_half_adder.vcd
```

GTKWave prints a stream of `GdkPixbuf ... assertion failed` warnings on Windows.
They're cosmetic icon-loading complaints from the GTK build — the viewer opens
and works normally. Ignore them.

`.vcd` files are gitignored — they're reproducible output, not source.

## Synthesis check

Every experiment also ships a `yosys_synthesis.tcl` that reads its RTL, elaborates
the hierarchy, maps it to generic cells, and reports gate/wire stats — a quick
"does this actually synthesize" check independent of simulation:

```bash
cd experiments/01_half_adder
igny run yosys -s yosys_synthesis.tcl
```

Both details matter:

- **`-s` is required.** Without it, yosys sees the `.tcl` extension, routes the
  file to its TCL interpreter, and fails with
  `invalid command name "read_verilog"`. These are yosys scripts, not TCL
  scripts — the extension is historical.
- **Run from inside the experiment directory.** The scripts use relative paths
  (`read_verilog design.v`), so running from the repo root fails with
  ``File `design.v' not found``.

This writes a `synth_<top_module>.v` netlist alongside the source. A few
experiments declare more than one independent top-level module (e.g.
`19_mux2to1_decoder2to4_tristate`); their script synthesizes each one in turn,
resetting the design in between. `54_synthesis_yosys_counter` is a special
case — see [The synthesis flow experiment](#the-synthesis-flow-experiment)
below.

## Running everything at once

`run_experiments.py` walks all 54 experiments, auto-detecting each one's layout,
and prints a pass/fail summary. **RTL simulation only by default — synthesis is
opt-in.** It's plain Python (stdlib only, no third-party packages) — no shell
scripting, so it runs identically on Windows, macOS, and Linux:

```bash
python run_experiments.py                # RTL simulation only (default)
python run_experiments.py --synth         # also run each yosys_synthesis.tcl
python run_experiments.py --keep          # keep generated .vvp/.vcd/synth_*.v
python run_experiments.py 01_half_adder   # run just one experiment
```

It needs `iverilog`/`vvp` on `PATH` (`yosys` too, for `--synth`). Exit code is
non-zero if anything failed.

### Running with Crucible (`igny`)

**The fast path — reproduce the exact toolchain in one command.** This repo
commits both `crucible.toml` (workspace identity and bound environment) and
`crucible.lock` (pinned tool versions with checksums), so you don't have to
install anything by hand:

```bash
git clone <this-repo>
cd digital-design
igny workspace sync
```

`sync` reads `crucible.lock`, installs any missing tools into your machine
inventory, and binds them to the `digital-experiments` environment — creating
that environment if it doesn't exist. Re-running it is idempotent. Then go
straight to running experiments:

```bash
igny run script run_experiments.py
```

The lock currently pins `iverilog@12.0.0`, `gtkwave@3.3.120`, and
`yosys@0.47.0`, all `windows-x86_64` artifacts. On Linux or macOS `sync` will
resolve the same tools for your platform, but regenerate the lock with
`igny workspace lock` afterwards if you want it to reflect your platform's
artifacts.

<details>
<summary>Manual setup (if you'd rather not use the lock)</summary>

```bash
igny env create digital-experiments
igny workspace create --path . --env digital-experiments
```

```bash
igny tool install iverilog --version 12.0.0   # 14.0.0 has no windows-x64 build
igny tool install gtkwave  --version 3.3.120  # 3.4.0 has no windows-x64 build
igny tool install yosys    --version 0.47.0   # only needed for --synth
```

**Pin these versions on Windows.** The catalog's newer defaults for `iverilog`,
`gtkwave`, and `yosys` have no `windows-x64` build, and a bare
`igny tool install <tool>` picks the newest version and fails with
`not available for windows-x64`. Run `igny cache sync` to see the versions your
machine can actually get. On Linux/macOS the bare form is fine.

</details>

Then, from this directory:

```bash
igny run script run_experiments.py                              # RTL simulation only
igny run script run_experiments.py -- --synth                   # simulation + synthesis
igny run script run_experiments.py -- --keep                    # keep .vcd/.vvp files
igny run script run_experiments.py -- --keep --synth            # keep files + synthesis
igny run script run_experiments.py -- 01_half_adder             # one experiment
igny run script run_experiments.py -- --keep 51_inverter_behavioral
```

Script arguments **must** come after `--`; without it igny treats them as its own
options and fails with `No such option`. `igny run script` launches the script
with the environment's bound tools on `PATH`, so this works even though the igny
shell hides your system `PATH`.

## Index

### Arithmetic — adders (01–10)

| # | Experiment | Layout |
|---|---|---|
| 01 | `01_half_adder` | design |
| 02 | `02_half_full_adder` | design |
| 03 | `03_adder_circuit` | design |
| 04 | `04_full_adder_2bit` | design |
| 05 | `05_ripple_carry_adder` | design |
| 06 | `06_parallel_adder_4bit` | design |
| 07 | `07_parallel_adder_subtractor` | design |
| 08 | `08_adder_subtractor_4bit` | design |
| 09 | `09_pipelined_adder_8bit` | design |
| 10 | `10_three_number_adder` | named |

### Arithmetic — comparators, multipliers, ALU (11–16)

| # | Experiment | Layout |
|---|---|---|
| 11 | `11_comparator` | design |
| 12 | `12_comparator_3bit` | design |
| 13 | `13_multiplier` | design |
| 14 | `14_multiplier_comparator` | design |
| 15 | `15_alu` | design |
| 16 | `16_arithmetic_adder_subtractor_comparator` | design |

### Data routing — mux, demux, decoders, encoders (17–26)

| # | Experiment | Layout |
|---|---|---|
| 17 | `17_mux_8to1` | design |
| 18 | `18_mux4to1` | design |
| 19 | `19_mux2to1_decoder2to4_tristate` | design |
| 20 | `20_pass_transistor_mux` | design |
| 21 | `21_mux_encoder_decoder` | design |
| 22 | `22_decoder_encoder` | design |
| 23 | `23_demux_rom` | design |
| 24 | `24_bcd_encoder_10bit` | design |
| 25 | `25_seven_segment_decoder_rtl` | named |
| 26 | `26_parity_generator` | design |

### Sequential — latches, flip-flops, registers (27–34)

| # | Experiment | Layout |
|---|---|---|
| 27 | `27_d_latch` | design |
| 28 | `28_latch_and_flipflop` | design |
| 29 | `29_d_flipflop_async_reset` | design |
| 30 | `30_d_flipflop_negedge` | design |
| 31 | `31_d_flipflop_with_qbar` | named |
| 32 | `32_flipflop_modeling` | design |
| 33 | `33_register` | design |
| 34 | `34_dflipflop_shiftreg8bit` | design |

### Counters (35–40)

| # | Experiment | Layout |
|---|---|---|
| 35 | `35_counter_4bit_sync_up` | design |
| 36 | `36_counter_8bit_enable` | design |
| 37 | `37_counter_4bit_up_down` | design |
| 38 | `38_up_down_counter` | named |
| 39 | `39_controlled_counter` | named |
| 40 | `40_fsm_updown_counter` | design |

### State machines and sequence detection (41–46)

| # | Experiment | Layout |
|---|---|---|
| 41 | `41_mealy_sequence_detector` | named |
| 42 | `42_fsm_calling_bell` | design |
| 43 | `43_fsm_state_machine` | design |
| 44 | `44_edge_detector_moore` | design |
| 45 | `45_edge_detector_mealy` | design |
| 46 | `46_debouncer` | design |

### Memory (47)

| # | Experiment | Layout |
|---|---|---|
| 47 | `47_fifo` | design |

### Modeling styles and CMOS-level description (48–52)

| # | Experiment | Layout |
|---|---|---|
| 48 | `48_gate_modeling` | design |
| 49 | `49_dataflow_modeling` | design |
| 50 | `50_behavioral_modeling` | design |
| 51 | `51_inverter_behavioral` | design |
| 52 | `52_cmos_gate_model` | design |

### RTL design and the synthesis flow (53–54)

| # | Experiment | Layout |
|---|---|---|
| 53 | `53_rtl_design_example` | design |
| 54 | `54_synthesis_yosys_counter` | yosys flow |

## The synthesis flow experiment

**`54_synthesis_yosys_counter`** maps `top.v` to the Nangate open cell library
and writes a gate-level netlist:

```bash
cd experiments/54_synthesis_yosys_counter
igny run yosys -s yosys_commands.tcl        # writes synth_example.v
```

`NangateOpenCellLibrary_typical.lib` (6.4 MB) is committed so the flow runs out of
the box; `toy.lib` is a small hand-written library for quicker experiments. Both are
third-party teaching/reference libraries and keep their own upstream copyright.

This experiment also has a `yosys_synthesis.tcl` alongside `yosys_commands.tcl` —
that one is the plain lib-free generic-cell check (against `Mycounter.v`), separate
from the Nangate-mapped ASIC flow above.

## Documents

Whitepapers and the Crucible user guide are in [`crucible_docs/`](crucible_docs/):

- `Verilog_Experiments_Whitepaper.pdf`
- `Counter_experiment_whitepaper.pdf` (with the source `.pptx`)
- `Day2_Whitepaper.pdf` — the synthesis flow behind experiment 60
- `Ignytion_Crucible_User_Guide_1.pdf`

