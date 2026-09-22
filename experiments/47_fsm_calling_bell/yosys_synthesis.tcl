# Auto-generated Yosys synthesis check for 47_fsm_calling_bell
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top fsm_calling_bell
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_fsm_calling_bell.v
