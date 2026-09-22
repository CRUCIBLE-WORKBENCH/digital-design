# Auto-generated Yosys synthesis check for 28_seven_segment_decoder_rtl
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog seven_segment_decoder.v
hierarchy -check -top seven_segment_decoder
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_seven_segment_decoder.v
