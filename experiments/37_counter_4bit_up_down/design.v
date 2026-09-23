// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/37_counter_4bit_up_down/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 4-bit synchronous up/down counter with synchronous reset
module counter_updown_4bit(
    input clk, rst,
    input updown, // 1=up, 0=down
    input en,
    output reg [3:0] count
);
    always @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        else if (en) begin
            if (updown)
                count <= count + 4'd1;
            else
                count <= count - 4'd1;
        end
        else
            count <= count;
    end
endmodule
