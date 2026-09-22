# Auto-generated Yosys synthesis check for 23_mux_encoder_decoder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top mux4to1
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_mux4to1.v

design -reset
read_verilog design.v
hierarchy -check -top encoder_4to2
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_encoder_4to2.v

design -reset
read_verilog design.v
hierarchy -check -top decoder_2to4
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_decoder_2to4.v
