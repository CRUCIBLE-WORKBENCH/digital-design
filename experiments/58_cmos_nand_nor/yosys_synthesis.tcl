# Auto-generated Yosys synthesis check for 58_cmos_nand_nor
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl
#
# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.

read_verilog -sv src/design.sv
hierarchy -check -top cmos_nand2
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_cmos_nand2.v

design -reset
read_verilog -sv src/design.sv
hierarchy -check -top cmos_nor2
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_cmos_nor2.v
