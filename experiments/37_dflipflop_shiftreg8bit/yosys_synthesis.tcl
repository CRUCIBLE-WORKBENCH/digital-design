# Auto-generated Yosys synthesis check for 37_dflipflop_shiftreg8bit
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top shift_register_8bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_shift_register_8bit.v
