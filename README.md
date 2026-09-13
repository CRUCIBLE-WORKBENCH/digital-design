# Digital Design Experiments

This repository contains Verilog/SystemVerilog digital-design experiments and learning
resources created using **Crucible by Ignytion IO**.

It is intended for students, educators, researchers, and engineers exploring digital
logic, RTL design, simulation, verification, synthesis, and timing-analysis workflows.

## Repository Structure

```text
experiments/                    Verilog/SystemVerilog experiments
  01_half_adder/                individual experiment directories
  ...
  61_static_timing_analysis/
  crucible_docs/                whitepapers and Crucible learning resources
LICENSE                         repository license
README.md                       repository overview
```

Generated simulator outputs, waveforms, reports, and local run logs are intentionally
not tracked. Recreate them locally from the source files when needed.

## Experiment Index

| No. | Experiment |
|---:|---|
| 01 | Half adder |
| 02 | Half and full adder |
| 03 | Adder circuit |
| 04 | 2-bit full adder |
| 05 | Ripple carry adder |
| 06 | 4-bit parallel adder |
| 07 | Parallel adder/subtractor |
| 08 | 4-bit adder/subtractor |
| 09 | 8-bit pipelined adder |
| 10 | Three-operand adder |
| 11 | Three-number adder |
| 12 | Comparator |
| 13 | 3-bit comparator |
| 14 | Multiplier |
| 15 | Multiplier and comparator |
| 16 | ALU |
| 17 | Arithmetic adder/subtractor/comparator |
| 18 | 8-to-1 mux |
| 19 | 4-to-1 mux |
| 20 | 2-to-1 mux, 2-to-4 decoder, and tri-state logic |
| 21 | Tri-state mux4 |
| 22 | Pass-transistor mux |
| 23 | Mux, encoder, and decoder |
| 24 | Decoder and encoder |
| 25 | Demux and ROM |
| 26 | 10-bit BCD encoder |
| 27 | Seven-segment decoder |
| 28 | Seven-segment decoder RTL |
| 29 | Parity generator |
| 30 | D latch |
| 31 | Latch and flip-flop |
| 32 | D flip-flop with asynchronous reset |
| 33 | Negative-edge D flip-flop |
| 34 | D flip-flop with Q-bar |
| 35 | Flip-flop modeling |
| 36 | Register |
| 37 | D flip-flop 8-bit shift register |
| 38 | 4-bit synchronous up counter |
| 39 | 8-bit counter with enable |
| 40 | 4-bit up/down counter |
| 41 | Up/down counter |
| 42 | Controlled counter |
| 43 | FSM up/down counter |
| 44 | Moore FSM |
| 45 | Mealy FSM |
| 46 | Mealy sequence detector |
| 47 | FSM calling bell |
| 48 | FSM state machine |
| 49 | Moore edge detector |
| 50 | Mealy edge detector |
| 51 | Debouncer |
| 52 | FIFO |
| 53 | Gate-level modeling |
| 54 | Dataflow modeling |
| 55 | Behavioral modeling |
| 56 | Behavioral inverter |
| 57 | CMOS gate model |
| 58 | CMOS NAND/NOR |
| 59 | RTL design example |
| 60 | Yosys counter synthesis |
| 61 | Static timing analysis |

## Running Experiments

Most experiments use one of these layouts:

```bash
# design.v + tb_design.v experiments
iverilog -o experiments/01_half_adder/sim.vvp \
  experiments/01_half_adder/design.v \
  experiments/01_half_adder/tb_design.v
vvp experiments/01_half_adder/sim.vvp

# named-module walkthrough experiments
iverilog -o experiments/34_d_flipflop_with_qbar/sim.vvp \
  experiments/34_d_flipflop_with_qbar/dff.v \
  experiments/34_d_flipflop_with_qbar/dff_tb.v
vvp experiments/34_d_flipflop_with_qbar/sim.vvp

# SystemVerilog experiments with src/ and tb/ folders
iverilog -g2012 -o experiments/27_seven_segment_decoder/sim.vvp \
  experiments/27_seven_segment_decoder/src/design.sv \
  experiments/27_seven_segment_decoder/tb/tb.sv
vvp experiments/27_seven_segment_decoder/sim.vvp
```

The synthesis and timing-analysis experiments include their own supporting scripts,
constraints, and libraries inside their experiment directories.

## Prerequisites

| Workflow | Tools |
|---|---|
| Verilog/SystemVerilog simulation | `iverilog`, `vvp` |
| Synthesis | `yosys` |
| Waveform viewing | `gtkwave` |

With Crucible / Igny CLI, install tools into a workspace and run the same tool
commands through `igny run`:

```bash
igny env create digital-design
igny workspace create --env digital-design
igny tool install iverilog
igny tool install yosys
igny tool install gtkwave
```

## License

Unless otherwise stated, original materials developed by Ignytion IO in this repository
are licensed under the [Apache License 2.0](./LICENSE).

Third-party tools, IP, designs, libraries, and generated outputs remain subject to
their respective licences.

Copyright 2026 Ignytion IO Private Limited.
