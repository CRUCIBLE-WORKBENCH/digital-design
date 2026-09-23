// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/08_adder_subtractor_4bit/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module adder_subtractor_4bit(
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       sub,
    output wire [3:0] result,
    output wire       cout
);

    wire [3:0] b_xor;
    wire [4:0] full_result;

    assign b_xor = b ^ {4{sub}};
    assign full_result = a + b_xor + sub;

    assign result = full_result[3:0];
    assign cout   = full_result[4];

endmodule
