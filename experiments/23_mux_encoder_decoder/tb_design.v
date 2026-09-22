`timescale 1ns/1ps

module tb_design;
    reg  [3:0] in;
    reg  [1:0] sel;
    wire       y;

    reg  [3:0] enc_in;
    wire [1:0] enc_out;

    reg  [1:0] dec_in;
    reg        dec_en;
    wire [3:0] dec_out;

    integer errors;
    integer i;

    mux4to1 u_mux(.in(in), .sel(sel), .y(y));
    encoder_4to2 u_enc(.in(enc_in), .out(enc_out));
    decoder_2to4 u_dec(.in(dec_in), .en(dec_en), .out(dec_out));

    task check_mux;
        input [3:0] t_in;
        input [1:0] t_sel;
        input       exp;
        begin
            in = t_in; sel = t_sel;
            #1;
            if (y !== exp) begin
                $display("FAIL: mux4to1 in=%b sel=%b y=%b exp=%b", t_in, t_sel, y, exp);
                errors = errors + 1;
            end else begin
                $display("PASS: mux4to1 in=%b sel=%b y=%b", t_in, t_sel, y);
            end
        end
    endtask

    task check_enc;
        input [3:0] t_in;
        input [1:0] exp;
        begin
            enc_in = t_in;
            #1;
            if (enc_out !== exp) begin
                $display("FAIL: encoder in=%b out=%b exp=%b", t_in, enc_out, exp);
                errors = errors + 1;
            end else begin
                $display("PASS: encoder in=%b out=%b", t_in, enc_out);
            end
        end
    endtask

    task check_dec;
        input [1:0] t_in;
        input       t_en;
        input [3:0] exp;
        begin
            dec_in = t_in; dec_en = t_en;
            #1;
            if (dec_out !== exp) begin
                $display("FAIL: decoder in=%b en=%b out=%b exp=%b", t_in, t_en, dec_out, exp);
                errors = errors + 1;
            end else begin
                $display("PASS: decoder in=%b en=%b out=%b", t_in, t_en, dec_out);
            end
        end
    endtask

    initial begin
        $dumpfile("23_mux_encoder_decoder.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        // mux4to1: all sel values, in pattern selects bit
        for (i = 0; i < 4; i = i + 1) begin
            check_mux(4'b0001 << i, i[1:0], 1'b1);
            check_mux(~(4'b0001 << i), i[1:0], 1'b0);
        end

        // encoder_4to2 priority cases
        check_enc(4'b0000, 2'b00);
        check_enc(4'b0001, 2'b00);
        check_enc(4'b0010, 2'b01);
        check_enc(4'b0100, 2'b10);
        check_enc(4'b1000, 2'b11);
        check_enc(4'b1010, 2'b11);
        check_enc(4'b0110, 2'b10);
        check_enc(4'b1111, 2'b11);

        // decoder_2to4 all inputs, enabled and disabled
        check_dec(2'b00, 1'b1, 4'b0001);
        check_dec(2'b01, 1'b1, 4'b0010);
        check_dec(2'b10, 1'b1, 4'b0100);
        check_dec(2'b11, 1'b1, 4'b1000);
        check_dec(2'b00, 1'b0, 4'b0000);
        check_dec(2'b11, 1'b0, 4'b0000);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
