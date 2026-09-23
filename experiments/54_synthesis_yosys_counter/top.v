// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/54_synthesis_yosys_counter/top.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module top(a, b, clk, select, out);
	input a, b, clk, select;
	output out;
	reg out;
	wire y;
	assign y=(select) ? b:a;
	always @(posedge clk)
	begin
		out<=y;
	end
endmodule