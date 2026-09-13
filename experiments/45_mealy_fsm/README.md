# Experiment 45: Mealy Machine RTL

## Contents

- `src/design.sv`: SystemVerilog implementation used by the runnable testbench.
- `src/design.v`: Verilog reference implementation.
- `src/design.vhd`: VHDL reference implementation.
- `tb/tb.sv`: self-checking SystemVerilog testbench.
- `Makefile`: local simulation and optional VHDL analysis targets.
- `VERIFICATION.md`: verification plan and coverage notes.

## Run

```sh
make test
```

Implements an overlapping `1011` sequence detector. Output asserts in the transition that completes the sequence.
