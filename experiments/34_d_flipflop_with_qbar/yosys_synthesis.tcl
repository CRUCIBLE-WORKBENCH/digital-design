# Auto-generated Yosys synthesis check for 34_d_flipflop_with_qbar
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog dff.v
hierarchy -check -top dff
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_dff.v
