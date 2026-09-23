// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/28_latch_and_flipflop/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// SR latch (level sensitive, active-high s/r)
module sr_latch(
    input      s,
    input      r,
    output reg q,
    output     qbar
);
    always @(*) begin
        if (r && !s)
            q = 1'b0;
        else if (s && !r)
            q = 1'b1;
        else if (!s && !r)
            q = q; // hold
        // s=1,r=1 treated as invalid: hold previous value
    end

    assign qbar = ~q;
endmodule

// JK flip-flop, posedge triggered, sync active-high reset
module jk_flipflop(
    input      j,
    input      k,
    input      clk,
    input      rst,
    output reg q
);
    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
        end
    end
endmodule
