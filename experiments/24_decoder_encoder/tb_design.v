// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/24_decoder_encoder/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for decoder_3to8 and encoder_8to3

module tb_design;
    reg  [2:0] dec_in;
    reg        en;
    wire [7:0] dec_out;

    reg  [7:0] enc_in;
    wire [2:0] enc_out;
    wire       enc_valid;

    integer errors, i;
    reg [7:0] exp_dec;

    decoder_3to8 d_dut(.in(dec_in), .en(en), .out(dec_out));
    encoder_8to3 e_dut(.in(enc_in), .out(enc_out), .valid(enc_valid));

    task check_decoder;
        begin
            exp_dec = en ? (8'b1 << dec_in) : 8'b0;
            if (dec_out === exp_dec)
                $display("PASS: decoder in=%b en=%b -> out=%b", dec_in, en, dec_out);
            else begin
                $display("FAIL: decoder in=%b en=%b -> out=%b (expected %b)", dec_in, en, dec_out, exp_dec);
                errors = errors + 1;
            end
        end
    endtask

    task check_encoder;
        reg [2:0] exp_out;
        reg exp_valid;
        integer j;
        begin
            exp_valid = |enc_in;
            exp_out = 3'd0;
            for (j = 0; j < 8; j = j + 1)
                if (enc_in[j]) exp_out = j[2:0];

            if (enc_out === exp_out && enc_valid === exp_valid)
                $display("PASS: encoder in=%b -> out=%d valid=%b", enc_in, enc_out, enc_valid);
            else begin
                $display("FAIL: encoder in=%b -> out=%d valid=%b (expected out=%d valid=%b)",
                          enc_in, enc_out, enc_valid, exp_out, exp_valid);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("24_decoder_encoder.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        en = 1;

        for (i = 0; i < 8; i = i + 1) begin
            dec_in = i[2:0];
            #10 check_decoder;
        end

        en = 0; dec_in = 3'd3; #10 check_decoder;

        enc_in = 8'b00000000; #10 check_encoder;
        enc_in = 8'b00000001; #10 check_encoder;
        enc_in = 8'b00000100; #10 check_encoder;
        enc_in = 8'b10000000; #10 check_encoder;
        enc_in = 8'b10100000; #10 check_encoder; // multi-hot, priority to MSB
        enc_in = 8'b00011000; #10 check_encoder; // multi-hot
        enc_in = 8'b11111111; #10 check_encoder;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
