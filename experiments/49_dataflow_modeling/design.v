// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/49_dataflow_modeling/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Dataflow-style combinational arithmetic unit

module dataflow_arith_unit(a, b, sum, diff, prod);
    input  [3:0] a, b;
    output [4:0] sum;
    output [4:0] diff;
    output [7:0] prod;

    assign sum  = a + b;
    assign diff = a - b;
    assign prod = a * b;
endmodule
