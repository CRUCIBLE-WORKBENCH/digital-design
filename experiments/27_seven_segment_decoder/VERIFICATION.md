# Verification Methodology

- Exhaustive directed testing over all 16 hexadecimal input values.
- Scoreboard compares the active-high `{a,b,c,d,e,f,g}` segment vector against a golden lookup table.
- `make test` runs the self-checking SystemVerilog testbench with Icarus Verilog.
- Optional VHDL analysis runs automatically when `ghdl` is installed.
