# Auto-generated Yosys synthesis check for 15_multiplier_comparator
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top multiplier_4bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_multiplier_4bit.v

design -reset
read_verilog design.v
hierarchy -check -top comparator_4bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_comparator_4bit.v
