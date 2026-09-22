# Auto-generated Yosys synthesis check for 35_flipflop_modeling
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top sr_flipflop
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_sr_flipflop.v

design -reset
read_verilog design.v
hierarchy -check -top jk_flipflop
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_jk_flipflop.v

design -reset
read_verilog design.v
hierarchy -check -top t_flipflop
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_t_flipflop.v

design -reset
read_verilog design.v
hierarchy -check -top d_flipflop
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_d_flipflop.v
