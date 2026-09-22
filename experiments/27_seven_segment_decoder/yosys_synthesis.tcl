# Auto-generated Yosys synthesis check for 27_seven_segment_decoder
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog -sv src/design.sv
hierarchy -check -top seven_segment_decoder
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_seven_segment_decoder.v
