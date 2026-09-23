// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/54_synthesis_yosys_counter/Mycounter.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module Mycounter(CLK,RST,OUT);	
	input CLK, RST;
	output [3:0]OUT;
	reg [3:0]OUT;
 	
	always @(posedge CLK)
	begin
		if (RST==1'b1)                                                               
			OUT<=4'b0000;
		else
			OUT<=OUT+1;
	end
endmodule  