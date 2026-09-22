# Auto-generated Yosys synthesis check for 29_parity_generator
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top parity_generator_8bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_parity_generator_8bit.v

design -reset
read_verilog design.v
hierarchy -check -top parity_checker_8bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_parity_checker_8bit.v
