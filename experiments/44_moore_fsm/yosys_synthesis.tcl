# Auto-generated Yosys synthesis check for 44_moore_fsm
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog -sv src/design.sv
hierarchy -check -top moore_1011
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_moore_1011.v
