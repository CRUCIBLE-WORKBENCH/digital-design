# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : experiments/60_synthesis_yosys_counter/yosys_synthesis.tcl
# Created     : 2026-09-23
# Description : Digital design experiment source, configuration, or documentation file.
# ===============================================================================

# Auto-generated Yosys synthesis check for 60_synthesis_yosys_counter
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl
#
# This is the lib-free generic-cell check. For the Nangate-mapped ASIC flow
# this experiment is actually about, use yosys_commands.tcl instead.

read_verilog Mycounter.v
hierarchy -check -top Mycounter
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_Mycounter.v
