# Auto-generated Yosys synthesis check for 10_three_operand_adder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog -sv src/design.sv
hierarchy -check -top add3_8
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_add3_8.v
