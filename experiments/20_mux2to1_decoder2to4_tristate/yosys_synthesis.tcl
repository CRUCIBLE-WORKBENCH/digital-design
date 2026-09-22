# Auto-generated Yosys synthesis check for 20_mux2to1_decoder2to4_tristate
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top mux2to1
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_mux2to1.v

design -reset
read_verilog design.v
hierarchy -check -top decoder2to4
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_decoder2to4.v

design -reset
read_verilog design.v
hierarchy -check -top tristate_buffer
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_tristate_buffer.v
