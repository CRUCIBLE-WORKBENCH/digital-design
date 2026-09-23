// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/48_gate_modeling/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module gate_modeling(
    input  wire a,
    input  wire b,
    output wire y_nand,
    output wire y_or,
    output wire y_nor,
    output wire y_not,
    output wire y_xor,
    output wire y_xnor
);

    assign y_nand = ~(a & b);
    assign y_or   = (a | b);
    assign y_nor  = ~(a | b);
    assign y_not  = ~a;
    assign y_xor  = (a ^ b);
    assign y_xnor = ~(a ^ b);

endmodule
