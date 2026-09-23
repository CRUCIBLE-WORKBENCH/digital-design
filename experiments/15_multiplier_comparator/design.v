// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/15_multiplier_comparator/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 4-bit multiplier and 4-bit comparator

module multiplier_4bit(a, b, product);
    input  [3:0] a, b;
    output [7:0] product;

    assign product = a * b;
endmodule

module comparator_4bit(a, b, gt, eq, lt);
    input  [3:0] a, b;
    output       gt, eq, lt;

    assign gt = (a > b);
    assign eq = (a == b);
    assign lt = (a < b);
endmodule
