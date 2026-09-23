// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/52_cmos_gate_model/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Behavioral model of CMOS-realized gates: NAND, NOR, XOR, XNOR

module cmos_gates_behavioral(a, b, y_nand, y_nor, y_xor, y_xnor);
    input  a, b;
    output y_nand, y_nor, y_xor, y_xnor;

    assign y_nand = ~(a & b);
    assign y_nor  = ~(a | b);
    assign y_xor  = a ^ b;
    assign y_xnor = ~(a ^ b);
endmodule
