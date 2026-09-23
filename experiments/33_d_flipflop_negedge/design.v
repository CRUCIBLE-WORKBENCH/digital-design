// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/33_d_flipflop_negedge/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Negedge-triggered D flip-flop with synchronous reset
module d_flipflop_negedge(
    input      d,
    input      clk,
    input      rst,
    output reg q
);
    always @(negedge clk) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
