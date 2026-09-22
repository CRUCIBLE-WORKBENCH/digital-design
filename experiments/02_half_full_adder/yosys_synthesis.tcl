# Auto-generated Yosys synthesis check for 02_half_full_adder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top full_adder
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_full_adder.v
