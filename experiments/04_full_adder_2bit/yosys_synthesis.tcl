# Auto-generated Yosys synthesis check for 04_full_adder_2bit
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top full_adder_2bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_full_adder_2bit.v
