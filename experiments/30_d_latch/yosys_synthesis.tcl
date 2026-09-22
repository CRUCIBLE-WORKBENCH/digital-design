# Auto-generated Yosys synthesis check for 30_d_latch
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top d_latch
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_d_latch.v
