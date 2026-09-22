# Auto-generated Yosys synthesis check for 18_mux_8to1
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top mux8to1
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_mux8to1.v
