# Auto-generated Yosys synthesis check for 46_mealy_sequence_detector
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog mealy_seq_det.v
hierarchy -check -top mealy_seq_det
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_mealy_seq_det.v
