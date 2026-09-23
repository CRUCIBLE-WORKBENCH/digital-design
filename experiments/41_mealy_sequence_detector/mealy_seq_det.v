// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/41_mealy_sequence_detector/mealy_seq_det.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module mealy_seq_det (
    input  wire clock,
    input  wire reset,
    input  wire seq_in,
    output wire det_o
);

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    reg [1:0] present_state, next_state;

    always @(posedge clock) begin
        if (reset)
            present_state <= S0;
        else
            present_state <= next_state;
    end

    always @(*) begin
        case (present_state)
            S0:      next_state = (seq_in) ? S1 : S0;
            S1:      next_state = (seq_in) ? S1 : S2;
            S2:      next_state = (seq_in) ? S1 : S0;
            default: next_state = S0;
        endcase
    end

    assign det_o = (present_state == S2) && seq_in;

endmodule
