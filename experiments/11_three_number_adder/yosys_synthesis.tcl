# Auto-generated Yosys synthesis check for 11_three_number_adder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog three_num_adder.v
hierarchy -check -top three_num_adder
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_three_num_adder.v
