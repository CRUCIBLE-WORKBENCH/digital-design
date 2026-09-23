// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/09_pipelined_adder_8bit/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module pipelined_adder_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       cin,
    input  wire       clk,
    output reg  [7:0] sum,
    output reg        cout
);

    reg [7:0] partial_sum_stage;
    reg       partial_cout_stage;

    always @(posedge clk) begin
        {partial_cout_stage, partial_sum_stage} <= a + b + cin;
    end

    always @(posedge clk) begin
        sum  <= partial_sum_stage;
        cout <= partial_cout_stage;
    end

endmodule
