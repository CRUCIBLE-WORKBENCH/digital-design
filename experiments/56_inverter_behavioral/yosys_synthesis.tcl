# Auto-generated Yosys synthesis check for 56_inverter_behavioral
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top inverter_array
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_inverter_array.v
