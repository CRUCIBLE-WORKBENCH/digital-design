// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/41_up_down_counter/up_down_counter.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module up_down_counter (
    input  wire       clock,
    input  wire       reset,
    input  wire       up_down,
    output reg  [3:0] count
);

    always @(posedge clock) begin
        if (reset)
            count <= 4'd0;
        else if (up_down)
            count <= count + 4'd1;
        else
            count <= count - 4'd1;
    end

endmodule
