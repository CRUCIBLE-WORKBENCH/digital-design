# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : experiments/41_up_down_counter/yosys_synthesis.tcl
# Created     : 2026-09-23
# Description : Digital design experiment source, configuration, or documentation file.
# ===============================================================================

# Auto-generated Yosys synthesis check for 41_up_down_counter
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog up_down_counter.v
hierarchy -check -top up_down_counter
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_up_down_counter.v
