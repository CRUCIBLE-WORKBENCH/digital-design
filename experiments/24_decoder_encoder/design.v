// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/24_decoder_encoder/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 3-to-8 decoder and 8-to-3 priority encoder

module decoder_3to8(in, en, out);
    input  [2:0] in;
    input        en;
    output [7:0] out;

    assign out = en ? (8'b1 << in) : 8'b0;
endmodule

module encoder_8to3(in, out, valid);
    input  [7:0] in;
    output [2:0] out;
    output       valid;

    assign valid = |in;

    assign out = in[7] ? 3'd7 :
                 in[6] ? 3'd6 :
                 in[5] ? 3'd5 :
                 in[4] ? 3'd4 :
                 in[3] ? 3'd3 :
                 in[2] ? 3'd2 :
                 in[1] ? 3'd1 :
                 in[0] ? 3'd0 : 3'd0;
endmodule
