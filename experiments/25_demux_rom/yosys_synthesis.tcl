# Auto-generated Yosys synthesis check for 25_demux_rom
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top demux_1to8
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_demux_1to8.v

design -reset
read_verilog design.v
hierarchy -check -top rom_8x4
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_rom_8x4.v
