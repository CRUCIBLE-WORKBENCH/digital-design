# Experiment 27: Seven-Segment Decoder for HEX Digits

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

The segment convention is active-high `{a,b,c,d,e,f,g}`.
