// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/14_multiplier/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 4x4 unsigned combinational multiplier
module multiplier_4bit(
    input  [3:0] a,
    input  [3:0] b,
    output [7:0] product
);
    assign product = a * b;
endmodule
