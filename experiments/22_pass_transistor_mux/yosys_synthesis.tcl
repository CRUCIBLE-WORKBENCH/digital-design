# Auto-generated Yosys synthesis check for 22_pass_transistor_mux
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top mux2to1_behavioral
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_mux2to1_behavioral.v
