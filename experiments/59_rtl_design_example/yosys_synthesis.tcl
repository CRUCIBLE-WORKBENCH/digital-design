# Auto-generated Yosys synthesis check for 59_rtl_design_example
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top rtl_traffic_controller
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_rtl_traffic_controller.v
