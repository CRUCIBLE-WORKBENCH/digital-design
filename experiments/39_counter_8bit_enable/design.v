// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/39_counter_8bit_enable/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module cnt (
    input clk,
    input rst,
    input en,
    output reg [7:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 8'd0;
    else if (en)
        count <= count + 8'd1;
    else
        count <= count;
end

endmodule
