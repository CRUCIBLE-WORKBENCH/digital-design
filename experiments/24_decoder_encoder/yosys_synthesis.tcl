# Auto-generated Yosys synthesis check for 24_decoder_encoder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top decoder_3to8
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_decoder_3to8.v

design -reset
read_verilog design.v
hierarchy -check -top encoder_8to3
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_encoder_8to3.v
