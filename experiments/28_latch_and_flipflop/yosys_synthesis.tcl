# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : experiments/28_latch_and_flipflop/yosys_synthesis.tcl
# Created     : 2026-09-23
# Description : Digital design experiment source, configuration, or documentation file.
# ===============================================================================

# Auto-generated Yosys synthesis check for 28_latch_and_flipflop
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

# This experiment declares multiple independent top-level modules;
# each is synthesized separately below.
read_verilog design.v
hierarchy -check -top sr_latch
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_sr_latch.v

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
