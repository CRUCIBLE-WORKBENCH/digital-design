// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/51_inverter_behavioral/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Behavioral inverter array, parametrizable width (default 8)
module inverter_array #(
    parameter WIDTH = 8
) (
    input  [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
    assign out = ~in;
endmodule
