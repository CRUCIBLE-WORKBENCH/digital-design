// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/21_mux_encoder_decoder/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 4-to-1 multiplexer
module mux4to1(
    input  [3:0] in,
    input  [1:0] sel,
    output       y
);
    assign y = in[sel];
endmodule

// 4-to-2 priority encoder (one-hot / priority, MSB has highest priority)
module encoder_4to2(
    input  [3:0] in,
    output reg [1:0] out
);
    always @(*) begin
        if (in[3])      out = 2'b11;
        else if (in[2]) out = 2'b10;
        else if (in[1]) out = 2'b01;
        else if (in[0]) out = 2'b00;
        else            out = 2'b00;
    end
endmodule

// 2-to-4 decoder with enable
module decoder_2to4(
    input  [1:0] in,
    input        en,
    output reg [3:0] out
);
    always @(*) begin
        if (en) begin
            case (in)
                2'b00: out = 4'b0001;
                2'b01: out = 4'b0010;
                2'b10: out = 4'b0100;
                2'b11: out = 4'b1000;
                default: out = 4'b0000;
            endcase
        end else begin
            out = 4'b0000;
        end
    end
endmodule
