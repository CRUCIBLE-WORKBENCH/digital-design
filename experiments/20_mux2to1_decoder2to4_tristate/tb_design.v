`timescale 1ns/1ps

module tb_design;

    reg m_a, m_b, m_sel;
    wire m_y;

    reg [1:0] d_in;
    reg d_en;
    wire [3:0] d_out;

    reg t_a, t_en;
    wire t_y;

    integer i;
    integer errors;
    reg exp_y;
    reg [3:0] exp_out;

    mux2to1 mux_dut (.a(m_a), .b(m_b), .sel(m_sel), .y(m_y));
    decoder2to4 dec_dut (.in(d_in), .en(d_en), .out(d_out));
    tristate_buffer tri_dut (.a(t_a), .en(t_en), .y(t_y));

    initial begin
        errors = 0;

        $display("---- mux2to1 ----");
        for (i = 0; i < 8; i = i + 1) begin
            {m_a, m_b, m_sel} = i[2:0];
            #5;
            exp_y = m_sel ? m_b : m_a;
            if (m_y === exp_y)
                $display("PASS: a=%b b=%b sel=%b -> y=%b (expected %b)", m_a, m_b, m_sel, m_y, exp_y);
            else begin
                $display("FAIL: a=%b b=%b sel=%b -> y=%b (expected %b)", m_a, m_b, m_sel, m_y, exp_y);
                errors = errors + 1;
            end
        end

        $display("---- decoder2to4 ----");
        for (i = 0; i < 8; i = i + 1) begin
            {d_in, d_en} = i[2:0];
            #5;
            if (d_en) begin
                case (d_in)
                    2'b00: exp_out = 4'b0001;
                    2'b01: exp_out = 4'b0010;
                    2'b10: exp_out = 4'b0100;
                    2'b11: exp_out = 4'b1000;
                endcase
            end else begin
                exp_out = 4'b0000;
            end

            if (d_out === exp_out)
                $display("PASS: in=%b en=%b -> out=%b (expected %b)", d_in, d_en, d_out, exp_out);
            else begin
                $display("FAIL: in=%b en=%b -> out=%b (expected %b)", d_in, d_en, d_out, exp_out);
                errors = errors + 1;
            end
        end

        $display("---- tristate_buffer ----");
        t_a = 0; t_en = 1; #5;
        if (t_y === 1'b0)
            $display("PASS: a=%b en=%b -> y=%b (expected 0)", t_a, t_en, t_y);
        else begin
            $display("FAIL: a=%b en=%b -> y=%b (expected 0)", t_a, t_en, t_y);
            errors = errors + 1;
        end

        t_a = 1; t_en = 1; #5;
        if (t_y === 1'b1)
            $display("PASS: a=%b en=%b -> y=%b (expected 1)", t_a, t_en, t_y);
        else begin
            $display("FAIL: a=%b en=%b -> y=%b (expected 1)", t_a, t_en, t_y);
            errors = errors + 1;
        end

        t_a = 0; t_en = 0; #5;
        if (t_y === 1'bz)
            $display("PASS: a=%b en=%b -> y=%b (expected z)", t_a, t_en, t_y);
        else begin
            $display("FAIL: a=%b en=%b -> y=%b (expected z)", t_a, t_en, t_y);
            errors = errors + 1;
        end

        t_a = 1; t_en = 0; #5;
        if (t_y === 1'bz)
            $display("PASS: a=%b en=%b -> y=%b (expected z)", t_a, t_en, t_y);
        else begin
            $display("FAIL: a=%b en=%b -> y=%b (expected z)", t_a, t_en, t_y);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
