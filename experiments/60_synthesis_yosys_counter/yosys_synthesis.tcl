# Auto-generated Yosys synthesis check for 60_synthesis_yosys_counter
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl
#
# This is the lib-free generic-cell check. For the Nangate-mapped ASIC flow
# this experiment is actually about, use yosys_commands.tcl instead.

read_verilog Mycounter.v
hierarchy -check -top Mycounter
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_Mycounter.v
