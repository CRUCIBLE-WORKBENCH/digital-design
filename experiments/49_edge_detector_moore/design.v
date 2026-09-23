// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/49_edge_detector_moore/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module edg_detection_moore (
    input clk,
    input rst,
    input sig_in,
    output edge_pulse
);

parameter S0 = 2'b00;
parameter S1 = 2'b01;
parameter S2 = 2'b10;

reg [1:0] state, next_state;

always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: next_state = sig_in ? S2 : S0;
        S2: next_state = sig_in ? S1 : S0;
        S1: next_state = sig_in ? S1 : S0;
        default: next_state = S0;
    endcase
end

assign edge_pulse = (state == S2);

endmodule
