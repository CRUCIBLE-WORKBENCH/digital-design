// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/16_arithmetic_adder_subtractor_comparator/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Combined 4-bit adder/subtractor/comparator
// mode: 00=add, 01=subtract (a-b), comparator outputs always active
module arithmetic_unit_4bit(
    input  [3:0] a,
    input  [3:0] b,
    input  [1:0] mode,
    output reg [3:0] result,
    output reg       cout,
    output           gt,
    output           eq,
    output           lt
);
    wire [4:0] sum_ext = {1'b0, a} + {1'b0, b};
    wire [4:0] diff_ext = {1'b0, a} - {1'b0, b};

    always @(*) begin
        case (mode)
            2'b00: begin
                result = sum_ext[3:0];
                cout   = sum_ext[4];
            end
            2'b01: begin
                result = diff_ext[3:0];
                cout   = diff_ext[4];
            end
            default: begin
                result = sum_ext[3:0];
                cout   = sum_ext[4];
            end
        endcase
    end

    assign gt = (a > b);
    assign eq = (a == b);
    assign lt = (a < b);
endmodule
