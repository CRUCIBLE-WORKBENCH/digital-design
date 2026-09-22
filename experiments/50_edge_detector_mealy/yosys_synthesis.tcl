# Auto-generated Yosys synthesis check for 50_edge_detector_mealy
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top riseedge_mealy
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_riseedge_mealy.v
