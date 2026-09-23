// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/26_bcd_encoder_10bit/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module bcd_encoder_10bit (
    input  wire [9:0] in,
    output reg  [3:0] bcd,
    output reg        valid
);

    always @(*) begin
        casez (in)
            10'b1zzzzzzzzz: begin bcd = 4'd9; valid = 1'b1; end
            10'b01zzzzzzzz: begin bcd = 4'd8; valid = 1'b1; end
            10'b001zzzzzzz: begin bcd = 4'd7; valid = 1'b1; end
            10'b0001zzzzzz: begin bcd = 4'd6; valid = 1'b1; end
            10'b00001zzzzz: begin bcd = 4'd5; valid = 1'b1; end
            10'b000001zzzz: begin bcd = 4'd4; valid = 1'b1; end
            10'b0000001zzz: begin bcd = 4'd3; valid = 1'b1; end
            10'b00000001zz: begin bcd = 4'd2; valid = 1'b1; end
            10'b000000001z: begin bcd = 4'd1; valid = 1'b1; end
            10'b0000000001: begin bcd = 4'd0; valid = 1'b1; end
            default:        begin bcd = 4'd0; valid = 1'b0; end
        endcase
    end

endmodule
