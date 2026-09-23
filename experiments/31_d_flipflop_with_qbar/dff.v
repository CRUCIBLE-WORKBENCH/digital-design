// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/31_d_flipflop_with_qbar/dff.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module dff (
    input  wire d_in,
    input  wire clock,
    input  wire reset,
    output reg  Q_out,
    output reg  Qb_out
);

    always @(posedge clock) begin
        if (reset) begin
            Q_out  <= 1'b0;
            Qb_out <= 1'b1;
        end
        else begin
            Q_out  <= d_in;
            Qb_out <= ~d_in;
        end
    end

endmodule
