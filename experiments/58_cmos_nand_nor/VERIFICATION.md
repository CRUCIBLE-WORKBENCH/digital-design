# Verification Methodology

- Exhaustive truth-table testing over all 2-input combinations.
- Scoreboard checks NAND and NOR outputs against Boolean reference equations.
- `make test` runs the self-checking SystemVerilog testbench with Icarus Verilog.
- Optional VHDL analysis runs automatically when `ghdl` is installed.
