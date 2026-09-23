// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/27_d_latch/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module d_latch(
    input  wire d,
    input  wire en,
    output reg  q
);

    always @(*) begin
        if (en)
            q = d;
    end

endmodule
