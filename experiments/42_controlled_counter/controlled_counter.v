// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/42_controlled_counter/controlled_counter.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module controlled_counter (
    input  wire       clock,
    input  wire       reset,
    input  wire       w,
    output reg  [3:0] count
);

    always @(posedge clock) begin
        if (reset)
            count <= 4'd0;
        else if (w) begin
            if (count >= 4'd8)
                count <= count - 4'd8;
            else
                count <= count + 4'd2;
        end
        else begin
            count <= count - 4'd1;
        end
    end

endmodule
