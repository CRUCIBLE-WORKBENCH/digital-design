// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/32_flipflop_modeling/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for sr_flipflop, jk_flipflop, t_flipflop, d_flipflop

module tb_design;
    reg clk, rst;
    reg s, r, j, k, t, d;
    wire q_sr, q_jk, q_t, q_d;
    reg exp_sr, exp_jk, exp_t, exp_d;
    integer errors;

    sr_flipflop u_sr(.clk(clk), .rst(rst), .s(s), .r(r), .q(q_sr));
    jk_flipflop u_jk(.clk(clk), .rst(rst), .j(j), .k(k), .q(q_jk));
    t_flipflop  u_t (.clk(clk), .rst(rst), .t(t), .q(q_t));
    d_flipflop  u_d (.clk(clk), .rst(rst), .d(d), .q(q_d));

    always #5 clk = ~clk;

    task check_all;
        begin
            if (q_sr === exp_sr)
                $display("PASS: SR s=%b r=%b -> q=%b", s, r, q_sr);
            else begin
                $display("FAIL: SR s=%b r=%b -> q=%b (expected %b)", s, r, q_sr, exp_sr);
                errors = errors + 1;
            end

            if (q_jk === exp_jk)
                $display("PASS: JK j=%b k=%b -> q=%b", j, k, q_jk);
            else begin
                $display("FAIL: JK j=%b k=%b -> q=%b (expected %b)", j, k, q_jk, exp_jk);
                errors = errors + 1;
            end

            if (q_t === exp_t)
                $display("PASS: T  t=%b -> q=%b", t, q_t);
            else begin
                $display("FAIL: T  t=%b -> q=%b (expected %b)", t, q_t, exp_t);
                errors = errors + 1;
            end

            if (q_d === exp_d)
                $display("PASS: D  d=%b -> q=%b", d, q_d);
            else begin
                $display("FAIL: D  d=%b -> q=%b (expected %b)", d, q_d, exp_d);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("32_flipflop_modeling.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0; rst = 1;
        s = 0; r = 0; j = 0; k = 0; t = 0; d = 0;
        exp_sr = 0; exp_jk = 0; exp_t = 0; exp_d = 0;
        @(posedge clk); #1 check_all;

        rst = 0;

        // hold (00)
        s=0; r=0; j=0; k=0; t=0; d=0;
        exp_sr = exp_sr; exp_jk = exp_jk; exp_t = exp_t; exp_d = d;
        @(posedge clk); #1 check_all;

        // set (10)
        s=1; r=0; j=1; k=0; t=0; d=1;
        exp_sr = 1; exp_jk = 1; exp_t = exp_t; exp_d = d;
        @(posedge clk); #1 check_all;

        // reset (01)
        s=0; r=1; j=0; k=1; t=0; d=0;
        exp_sr = 0; exp_jk = 0; exp_t = exp_t; exp_d = d;
        @(posedge clk); #1 check_all;

        // toggle: JK (11), T=1
        s=0; r=0; j=1; k=1; t=1; d=1;
        exp_sr = exp_sr; exp_jk = ~exp_jk; exp_t = ~exp_t; exp_d = d;
        @(posedge clk); #1 check_all;

        s=0; r=0; j=1; k=1; t=1; d=0;
        exp_jk = ~exp_jk; exp_t = ~exp_t; exp_d = d;
        @(posedge clk); #1 check_all;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
