# ===============================================================================
# Ignytion IO - CRUCIBLE CORE
# Copyright (c) 2026 Ignytion IO. All rights reserved.
# Author      : IGNYTION_TECH
# File        : experiments/60_synthesis_yosys_counter/yosys_commands.tcl
# Created     : 2026-09-23
# Description : Digital design experiment source, configuration, or documentation file.
# ===============================================================================

# read modules from Verilog file
read_verilog top.v

# elaborate design hierarchy
hierarchy -check -top top

# translate processes to netlists
proc

# mapping to internal cell library
techmap

# mapping flip-flops to NangateOpenCellLibrary_typical.lib 
# for eg. always block
dfflibmap -liberty NangateOpenCellLibrary_typical.lib 

# mapping logic to NangateOpenCellLibrary_typical.lib 
# for eg. assign block
abc -liberty NangateOpenCellLibrary_typical.lib
 
# remove unused cells and wires
clean

# Write the current design to a Verilog file
write_verilog -noattr  synth_example.v 