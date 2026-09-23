// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/07_parallel_adder_subtractor/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 4-bit adder/subtractor using XOR-based two's complement control

module parallel_adder_subtractor_4bit(a, b, sub, result, cout);
    input  [3:0] a, b;
    input        sub;
    output [3:0] result;
    output       cout;

    wire [3:0] b_xor;
    wire [4:0] sum;

    assign b_xor = b ^ {4{sub}};
    assign sum   = a + b_xor + sub;

    assign result = sum[3:0];
    assign cout   = sum[4];
endmodule
