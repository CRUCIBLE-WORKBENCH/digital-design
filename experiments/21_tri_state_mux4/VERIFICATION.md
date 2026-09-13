# Verification Methodology

- Directed testing covers disabled high-impedance behavior and all four enabled select values.
- Assertions use four-state equality so `Z` behavior is checked explicitly.
- `make test` runs the self-checking SystemVerilog testbench with Icarus Verilog.
- Optional VHDL analysis runs automatically when `ghdl` is installed.
