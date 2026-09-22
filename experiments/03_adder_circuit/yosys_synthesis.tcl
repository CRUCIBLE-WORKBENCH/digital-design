# Auto-generated Yosys synthesis check for 03_adder_circuit
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top adder_8bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_adder_8bit.v
