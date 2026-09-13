# Experiment 21: Tri-Stated Buffer Controlled 4-Channel Multiplexer

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

When `en=0`, output bus is high impedance. When enabled, exactly one channel is driven.
