# Auto-generated Yosys synthesis check for 40_counter_4bit_up_down
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top counter_updown_4bit
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_counter_updown_4bit.v
