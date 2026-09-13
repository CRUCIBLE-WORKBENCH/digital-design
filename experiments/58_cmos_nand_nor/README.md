# Experiment 58: 2-Input CMOS NAND and NOR Gates

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

The SystemVerilog model is switch-level-style Boolean CMOS behavior suitable for RTL simulation.
