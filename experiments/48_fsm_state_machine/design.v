// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/48_fsm_state_machine/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Moore FSM: detects serial sequence "1101" on din, allows overlap
module fsm_sequence_detector(
    input clk, rst,
    input din,
    output detected
);
    localparam S0   = 3'd0; // no bits matched
    localparam S1   = 3'd1; // "1"
    localparam S11  = 3'd2; // "11"
    localparam S110 = 3'd3; // "110"
    localparam S1101= 3'd4; // "1101" matched

    reg [2:0] state, next_state;

    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0:    next_state = din ? S1   : S0;
            S1:    next_state = din ? S11  : S0;
            S11:   next_state = din ? S11  : S110;
            S110:  next_state = din ? S1101: S0;
            S1101: next_state = din ? S1   : S0; // overlap: after "1101", a new "1" starts fresh match at S1
            default: next_state = S0;
        endcase
    end

    assign detected = (state == S1101);
endmodule
