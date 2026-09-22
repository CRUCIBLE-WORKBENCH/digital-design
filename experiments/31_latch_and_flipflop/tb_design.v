// Self-checking testbench for sr_latch and jk_flipflop
`timescale 1ns/1ps
module tb_design;
    reg  s, r;
    wire q_sr, qbar_sr;
    integer errors;

    reg  j, k, clk, rst;
    wire q_jk;
    reg  expected;

    sr_latch    u_sr(.s(s), .r(r), .q(q_sr), .qbar(qbar_sr));
    jk_flipflop u_jk(.j(j), .k(k), .clk(clk), .rst(rst), .q(q_jk));

    always #5 clk = ~clk;

    task check_sr(input exp);
        begin
            if (q_sr === exp && qbar_sr === ~exp)
                $display("PASS: SR s=%b r=%b -> q=%b qbar=%b", s, r, q_sr, qbar_sr);
            else begin
                $display("FAIL: SR s=%b r=%b -> q=%b qbar=%b (expected q=%b)", s, r, q_sr, qbar_sr, exp);
                errors = errors + 1;
            end
        end
    endtask

    task check_jk(input exp);
        begin
            if (q_jk === exp)
                $display("PASS: JK j=%b k=%b -> q=%b", j, k, q_jk);
            else begin
                $display("FAIL: JK j=%b k=%b -> q=%b (expected %b)", j, k, q_jk, exp);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("31_latch_and_flipflop.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0; rst = 0; j = 0; k = 0;

        // SR latch tests
        s = 1; r = 0; #10; check_sr(1'b1); // set
        s = 0; r = 0; #10; check_sr(1'b1); // hold
        s = 0; r = 1; #10; check_sr(1'b0); // reset
        s = 0; r = 0; #10; check_sr(1'b0); // hold

        // JK flip-flop tests
        rst = 1; @(posedge clk); #1; check_jk(1'b0); // reset
        rst = 0;
        j = 1; k = 0; @(posedge clk); #1; check_jk(1'b1); // set
        j = 0; k = 0; @(posedge clk); #1; check_jk(1'b1); // hold
        j = 0; k = 1; @(posedge clk); #1; check_jk(1'b0); // reset via k
        j = 1; k = 1; @(posedge clk); #1; check_jk(1'b1); // toggle
        j = 1; k = 1; @(posedge clk); #1; check_jk(1'b0); // toggle

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
