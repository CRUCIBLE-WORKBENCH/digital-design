// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/34_dflipflop_shiftreg8bit/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

    reg d_in, clk_ff, rst_ff;
    wire q_ff;

    reg serial_in, clk, rst;
    wire [7:0] parallel_out;

    integer errors;
    integer i;
    reg [7:0] pattern;
    reg [7:0] model;

    d_flipflop ff_dut (
        .d(d_in),
        .clk(clk_ff),
        .rst(rst_ff),
        .q(q_ff)
    );

    shift_register_8bit sr_dut (
        .serial_in(serial_in),
        .clk(clk),
        .rst(rst),
        .parallel_out(parallel_out)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("34_dflipflop_shiftreg8bit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        clk_ff = 0;
        d_in = 0;
        rst_ff = 1;
        #3 rst_ff = 0;

        d_in = 1; #2 clk_ff = 1; #5 clk_ff = 0;
        if (q_ff === 1'b1)
            $display("PASS: d_flipflop loads 1 on posedge clk");
        else begin
            $display("FAIL: d_flipflop expected q=1 got q=%b", q_ff);
            errors = errors + 1;
        end

        d_in = 0; #2 clk_ff = 1; #5 clk_ff = 0;
        if (q_ff === 1'b0)
            $display("PASS: d_flipflop loads 0 on posedge clk");
        else begin
            $display("FAIL: d_flipflop expected q=0 got q=%b", q_ff);
            errors = errors + 1;
        end

        rst_ff = 1; #2;
        if (q_ff === 1'b0)
            $display("PASS: d_flipflop async reset works");
        else begin
            $display("FAIL: d_flipflop async reset expected q=0 got q=%b", q_ff);
            errors = errors + 1;
        end

        clk = 0;
        serial_in = 0;
        rst = 1;
        #10 rst = 0;

        pattern = 8'b1011_0010;
        model   = 8'b0000_0000;

        for (i = 7; i >= 0; i = i - 1) begin
            serial_in = pattern[i];
            @(posedge clk);
            #1;
            model = {model[6:0], pattern[i]};
        end

        #1;
        if (parallel_out === model)
            $display("PASS: shift_register_8bit final output = %b (expected %b)", parallel_out, model);
        else begin
            $display("FAIL: shift_register_8bit final output = %b (expected %b)", parallel_out, model);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
