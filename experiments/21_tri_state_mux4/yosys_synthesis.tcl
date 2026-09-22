# Auto-generated Yosys synthesis check for 21_tri_state_mux4
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog -sv src/design.sv
hierarchy -check -top tri_state_mux4
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_tri_state_mux4.v
