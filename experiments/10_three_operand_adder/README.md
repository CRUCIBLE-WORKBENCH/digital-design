# Experiment 10: Adder for Three 8-Bit Binary Numbers

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

The sum width is 10 bits because the maximum value is `3 * 255 = 765`.
