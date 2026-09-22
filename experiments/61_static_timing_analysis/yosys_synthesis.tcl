# Auto-generated Yosys check for 61_static_timing_analysis
# top.v is already a gate-level netlist built from named library cells
# (INV, BUF, NAND2, DFFRNQ) that only toy.lib defines — there is no RTL here
# to re-synthesize, and yosys can't techmap these without a Liberty-aware
# flow. This script just confirms the netlist parses and reports cell counts.
#
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl
#
# For actual timing closure against these cells, use test.tcl / top.sdc with
# an STA tool (OpenSTA) instead.

read_verilog top.v
stat
