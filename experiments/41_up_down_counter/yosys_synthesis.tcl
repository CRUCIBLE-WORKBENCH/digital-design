# Auto-generated Yosys synthesis check for 41_up_down_counter
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog up_down_counter.v
hierarchy -check -top up_down_counter
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_up_down_counter.v
