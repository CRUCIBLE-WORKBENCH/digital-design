// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/28_seven_segment_decoder_rtl/seven_segment_decoder_tb.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

    `timescale 1ns/1ps

    module seven_segment_decoder_tb;

        reg  [3:0] hex_in;
        wire [6:0] seg_out;
        reg  [7:0] display_char;   // ASCII character that seg_out represents (view as ASCII in GTKWave)
        integer i;

        seven_segment_decoder DUT (
            .hex_in  (hex_in),
            .seg_out (seg_out)
        );

        // Reverse-decode the 7-segment pattern back to the printable character.
        // Set this signal's Data Format to ASCII in GTKWave to see 0-9, A-F on the wave.
        always @(*) begin
            case (seg_out)
                7'b1111110: display_char = "0";
                7'b0110000: display_char = "1";
                7'b1101101: display_char = "2";
                7'b1111001: display_char = "3";
                7'b0110011: display_char = "4";
                7'b1011011: display_char = "5";
                7'b1011111: display_char = "6";
                7'b1110000: display_char = "7";
                7'b1111111: display_char = "8";
                7'b1111011: display_char = "9";
                7'b1110111: display_char = "A";
                7'b0011111: display_char = "B";
                7'b1001110: display_char = "C";
                7'b0111101: display_char = "D";
                7'b1001111: display_char = "E";
                7'b1000111: display_char = "F";
                default:    display_char = "?";
            endcase
        end

        function [6:0] expected_seg;
            input [3:0] value;
            begin
                case (value)
                    4'h0: expected_seg = 7'b1111110;
                    4'h1: expected_seg = 7'b0110000;
                    4'h2: expected_seg = 7'b1101101;
                    4'h3: expected_seg = 7'b1111001;
                    4'h4: expected_seg = 7'b0110011;
                    4'h5: expected_seg = 7'b1011011;
                    4'h6: expected_seg = 7'b1011111;
                    4'h7: expected_seg = 7'b1110000;
                    4'h8: expected_seg = 7'b1111111;
                    4'h9: expected_seg = 7'b1111011;
                    4'hA: expected_seg = 7'b1110111;
                    4'hB: expected_seg = 7'b0011111;
                    4'hC: expected_seg = 7'b1001110;
                    4'hD: expected_seg = 7'b0111101;
                    4'hE: expected_seg = 7'b1001111;
                    4'hF: expected_seg = 7'b1000111;
                    default: expected_seg = 7'b0000000;
                endcase
            end
        endfunction

        initial begin
            $dumpfile("seven_segment_decoder_tb.vcd");
            $dumpvars(0, seven_segment_decoder_tb);

            $monitor("Time=%0t | hex_in=%h | seg_out=%b | char=%s", $time, hex_in, seg_out, display_char);

            for (i = 0; i < 16; i = i + 1) begin
                hex_in = i[3:0];
                #10;
                if (seg_out !== expected_seg(hex_in)) begin
                    $display("ERROR: hex_in=%h expected=%b got=%b",
                            hex_in, expected_seg(hex_in), seg_out);
                    $finish;
                end
            end

            $display("Seven-segment decoder test passed.");
            $finish;
        end

    endmodule
