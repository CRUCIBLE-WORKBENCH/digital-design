// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/28_seven_segment_decoder_rtl/seven_segment_decoder.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module seven_segment_decoder (
    input  wire [3:0] hex_in,
    output reg  [6:0] seg_out
);

    always @(*) begin
        case (hex_in)
            4'h0: seg_out = 7'b1111110;
            4'h1: seg_out = 7'b0110000;
            4'h2: seg_out = 7'b1101101;
            4'h3: seg_out = 7'b1111001;
            4'h4: seg_out = 7'b0110011;
            4'h5: seg_out = 7'b1011011;
            4'h6: seg_out = 7'b1011111;
            4'h7: seg_out = 7'b1110000;
            4'h8: seg_out = 7'b1111111;
            4'h9: seg_out = 7'b1111011;
            4'hA: seg_out = 7'b1110111;
            4'hB: seg_out = 7'b0011111;
            4'hC: seg_out = 7'b1001110;
            4'hD: seg_out = 7'b0111101;
            4'hE: seg_out = 7'b1001111;
            4'hF: seg_out = 7'b1000111;
            default: seg_out = 7'b0000000;
        endcase
    end

endmodule
