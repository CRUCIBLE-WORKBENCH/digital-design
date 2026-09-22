# Auto-generated Yosys synthesis check for 43_fsm_updown_counter
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top fsm_updown_counter
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_fsm_updown_counter.v
