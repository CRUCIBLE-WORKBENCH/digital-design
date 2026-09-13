`timescale 1ns/1ps

module tb_design;

    reg d, en;
    wire q;
    reg expected_q;
    integer errors;

    d_latch dut (.d(d), .en(en), .q(q));

    task check_q;
        input [127:0] name;
        begin
            if (q === expected_q) begin
                $display("PASS: %s d=%b en=%b -> q=%b (expected %b)", name, d, en, q, expected_q);
            end else begin
                $display("FAIL: %s d=%b en=%b -> q=%b (expected %b)", name, d, en, q, expected_q);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        en = 0; d = 0; #5;
        expected_q = 1'bx;

        en = 1; d = 1; #5;
        expected_q = 1'b1;
        check_q("transparent d=1");

        d = 0; #5;
        expected_q = 1'b0;
        check_q("transparent d=0");

        en = 0; #5;
        expected_q = 1'b0;
        check_q("hold after en=0 (d=0)");

        d = 1; #5;
        expected_q = 1'b0;
        check_q("hold ignores d change while en=0");

        en = 1; #5;
        expected_q = 1'b1;
        check_q("transparent again d=1");

        en = 0; #5;
        expected_q = 1'b1;
        check_q("hold latched value 1");

        d = 0; #5;
        expected_q = 1'b1;
        check_q("hold ignores d while en=0 (2)");

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
