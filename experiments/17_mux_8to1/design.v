// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/17_mux_8to1/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 8-to-1 multiplexer
module mux8to1(
    input  [7:0] in,
    input  [2:0] sel,
    output       y
);
    assign y = in[sel];
endmodule
