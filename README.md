# Verilog Experiments

55 self-contained digital design experiments, from single gates to a full
synthesis-and-timing flow. Numbering is thematic: combinational arithmetic first,
then data routing, sequential logic, state machines, memory, modeling styles, and
finally the RTL-to-netlist flow.

Everything here is plain Verilog (`.v`) simulated with Icarus Verilog, plus a
Yosys `.tcl` synthesis check per experiment. Numbering has gaps where earlier
SystemVerilog/VHDL experiments were removed; remaining experiments keep their
original numbers.

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
cd experiments/34_d_flipflop_with_qbar
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
directory (`01_half_adder.vcd`, `56_inverter_behavioral.vcd`, ...).

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
`20_mux2to1_decoder2to4_tristate`); their script synthesizes each one in turn,
resetting the design in between. `60_synthesis_yosys_counter` and
`61_static_timing_analysis` are special cases — see
[The two flow experiments](#the-two-flow-experiments) below.

## Running everything at once

`run_experiments.py` walks all 55 experiments, auto-detecting each one's layout,
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

First-time setup — create the environment and workspace, then install the tools:

```bash
igny env create digital-experiments
igny workspace create --path . --env digital-experiments
```

```bash
igny tool install iverilog --version 12.0.0   # 14.0.0 has no windows-x64 build
igny tool install gtkwave  --version 3.3.120  # 3.4.0 has no windows-x64 build
igny tool install yosys    --version 0.47.0   # only needed for --synth
igny tool install openroad                    # only needed for STA (experiment 61)
```

**Pin these versions on Windows.** The catalog's newer defaults for `iverilog`,
`gtkwave`, and `yosys` have no `windows-x64` build, and a bare
`igny tool install <tool>` picks the newest version and fails with
`not available for windows-x64`. Run `igny cache sync` to see the versions your
machine can actually get. On Linux/macOS the bare form is fine.

Then, from this directory:

```bash
igny run script run_experiments.py                              # RTL simulation only
igny run script run_experiments.py -- --synth                   # simulation + synthesis
igny run script run_experiments.py -- --keep                    # keep .vcd/.vvp files
igny run script run_experiments.py -- --keep --synth            # keep files + synthesis
igny run script run_experiments.py -- 01_half_adder             # one experiment
igny run script run_experiments.py -- --keep 56_inverter_behavioral
```

Script arguments **must** come after `--`; without it igny treats them as its own
options and fails with `No such option`. `igny run script` launches the script
with the environment's bound tools on `PATH`, so this works even though the igny
shell hides your system `PATH`.

## Index

### Arithmetic — adders (01–09, 11)

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
| 11 | `11_three_number_adder` | named |

### Arithmetic — comparators, multipliers, ALU (12–17)

| # | Experiment | Layout |
|---|---|---|
| 12 | `12_comparator` | design |
| 13 | `13_comparator_3bit` | design |
| 14 | `14_multiplier` | design |
| 15 | `15_multiplier_comparator` | design |
| 16 | `16_alu` | design |
| 17 | `17_arithmetic_adder_subtractor_comparator` | design |

### Data routing — mux, demux, decoders, encoders (18–29, gaps at 21 and 27)

| # | Experiment | Layout |
|---|---|---|
| 18 | `18_mux_8to1` | design |
| 19 | `19_mux4to1` | design |
| 20 | `20_mux2to1_decoder2to4_tristate` | design |
| 22 | `22_pass_transistor_mux` | design |
| 23 | `23_mux_encoder_decoder` | design |
| 24 | `24_decoder_encoder` | design |
| 25 | `25_demux_rom` | design |
| 26 | `26_bcd_encoder_10bit` | design |
| 28 | `28_seven_segment_decoder_rtl` | named |
| 29 | `29_parity_generator` | design |

### Sequential — latches, flip-flops, registers (30–37)

| # | Experiment | Layout |
|---|---|---|
| 30 | `30_d_latch` | design |
| 31 | `31_latch_and_flipflop` | design |
| 32 | `32_d_flipflop_async_reset` | design |
| 33 | `33_d_flipflop_negedge` | design |
| 34 | `34_d_flipflop_with_qbar` | named |
| 35 | `35_flipflop_modeling` | design |
| 36 | `36_register` | design |
| 37 | `37_dflipflop_shiftreg8bit` | design |

### Counters (38–43)

| # | Experiment | Layout |
|---|---|---|
| 38 | `38_counter_4bit_sync_up` | design |
| 39 | `39_counter_8bit_enable` | design |
| 40 | `40_counter_4bit_up_down` | design |
| 41 | `41_up_down_counter` | named |
| 42 | `42_controlled_counter` | named |
| 43 | `43_fsm_updown_counter` | design |

### State machines and sequence detection (46–51)

| # | Experiment | Layout |
|---|---|---|
| 46 | `46_mealy_sequence_detector` | named |
| 47 | `47_fsm_calling_bell` | design |
| 48 | `48_fsm_state_machine` | design |
| 49 | `49_edge_detector_moore` | design |
| 50 | `50_edge_detector_mealy` | design |
| 51 | `51_debouncer` | design |

### Memory (52)

| # | Experiment | Layout |
|---|---|---|
| 52 | `52_fifo` | design |

### Modeling styles and CMOS-level description (53–57)

| # | Experiment | Layout |
|---|---|---|
| 53 | `53_gate_modeling` | design |
| 54 | `54_dataflow_modeling` | design |
| 55 | `55_behavioral_modeling` | design |
| 56 | `56_inverter_behavioral` | design |
| 57 | `57_cmos_gate_model` | design |

### RTL design and the synthesis flow (59–61)

| # | Experiment | Layout |
|---|---|---|
| 59 | `59_rtl_design_example` | design |
| 60 | `60_synthesis_yosys_counter` | yosys flow |
| 61 | `61_static_timing_analysis` | STA flow |

## The two flow experiments

**`60_synthesis_yosys_counter`** maps `top.v` to the Nangate open cell library and writes
a gate-level netlist:

```bash
cd experiments/60_synthesis_yosys_counter
igny run yosys -s yosys_commands.tcl        # writes synth_example.v
```

`NangateOpenCellLibrary_typical.lib` (6.7 MB) is committed so the flow runs out of the box;
`toy.lib` is a small hand-written library for quicker experiments. A previously generated
`synth_example.v` is included for reference and will be overwritten by the run.

This experiment also has a `yosys_synthesis.tcl` alongside `yosys_commands.tcl` —
that one is the plain lib-free generic-cell check (against `Mycounter.v`), separate
from the Nangate-mapped ASIC flow above.

**`61_static_timing_analysis`** runs timing analysis over `top.v` against `top.sdc` using OpenROAD:

```bash
cd experiments/61_static_timing_analysis
igny run openroad -exit test.tcl
```

`top.v` here is already a gate-level netlist built from named library cells (`INV`,
`BUF`, `NAND2`, `DFFRNQ`) that only `toy.lib` defines — there's no RTL to
re-synthesize. Its `yosys_synthesis.tcl` just parses the netlist and reports cell
counts rather than running a full synth pass.

**Required tool for STA:** Install OpenROAD with:

```bash
igny tool install openroad
```

## Documents

Whitepapers and the Crucible user guide are in [`crucible_docs/`](crucible_docs/):

- `Verilog_Experiments_Whitepaper.pdf`
- `Counter_experiment_whitepaper.pdf` (with the source `.pptx`)
- `Day2_Whitepaper.pdf` — the synthesis flow behind experiment 60
- `Ignytion_Crucible_User_Guide_1.pdf`

