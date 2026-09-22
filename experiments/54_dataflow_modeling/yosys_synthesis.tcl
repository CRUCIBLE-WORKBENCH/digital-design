# Auto-generated Yosys synthesis check for 54_dataflow_modeling
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top dataflow_arith_unit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_dataflow_arith_unit.v
