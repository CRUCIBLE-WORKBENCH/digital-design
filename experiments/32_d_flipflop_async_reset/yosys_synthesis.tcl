# Auto-generated Yosys synthesis check for 32_d_flipflop_async_reset
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top d_flipflop
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_d_flipflop.v
