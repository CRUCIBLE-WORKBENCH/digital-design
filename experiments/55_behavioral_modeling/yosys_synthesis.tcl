# Auto-generated Yosys synthesis check for 55_behavioral_modeling
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top behavioral_traffic_fsm
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_behavioral_traffic_fsm.v
