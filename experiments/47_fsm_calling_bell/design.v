// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/47_fsm_calling_bell/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module fsm_calling_bell (
    input  wire button,
    input  wire clk,
    input  wire rst,
    output reg  bell
);

    localparam IDLE  = 2'b00;
    localparam RING1 = 2'b01;
    localparam RING2 = 2'b10;
    localparam RING3 = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            IDLE:  next_state = button ? RING1 : IDLE;
            RING1: next_state = RING2;
            RING2: next_state = RING3;
            RING3: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(*) begin
        case (state)
            RING1: bell = 1'b1;
            RING2: bell = 1'b1;
            RING3: bell = 1'b1;
            default: bell = 1'b0;
        endcase
    end

endmodule
