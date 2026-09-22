# Auto-generated Yosys synthesis check for 09_pipelined_adder_8bit
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top pipelined_adder_8bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_pipelined_adder_8bit.v
