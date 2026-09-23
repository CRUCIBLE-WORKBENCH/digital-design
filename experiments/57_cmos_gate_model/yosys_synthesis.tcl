# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : experiments/57_cmos_gate_model/yosys_synthesis.tcl
# Created     : 2026-09-23
# Description : Digital design experiment source, configuration, or documentation file.
# ===============================================================================

# Auto-generated Yosys synthesis check for 57_cmos_gate_model
# Reads the RTL, elaborates the hierarchy, maps to generic cells, and reports stats.
# Run from inside this experiment's directory:
#   yosys -s yosys_synthesis.tcl

read_verilog design.v
hierarchy -check -top cmos_gates_behavioral
proc
opt
techmap
opt
clean
stat
write_verilog -noattr synth_cmos_gates_behavioral.v
