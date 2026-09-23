// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/14_multiplier_comparator/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for multiplier_4bit and comparator_4bit

module tb_design;
    reg  [3:0] a, b;
    wire [7:0] product;
    wire       gt, eq, lt;
    integer    errors;

    multiplier_4bit  m_dut(.a(a), .b(b), .product(product));
    comparator_4bit  c_dut(.a(a), .b(b), .gt(gt), .eq(eq), .lt(lt));

    task check;
        reg [7:0] exp_prod;
        reg exp_gt, exp_eq, exp_lt;
        begin
            exp_prod = a * b;
            exp_gt = (a > b);
            exp_eq = (a == b);
            exp_lt = (a < b);

            if (product === exp_prod)
                $display("PASS: mult a=%d b=%d -> product=%d", a, b, product);
            else begin
                $display("FAIL: mult a=%d b=%d -> product=%d (expected %d)", a, b, product, exp_prod);
                errors = errors + 1;
            end

            if (gt === exp_gt && eq === exp_eq && lt === exp_lt)
                $display("PASS: cmp  a=%d b=%d -> gt=%b eq=%b lt=%b", a, b, gt, eq, lt);
            else begin
                $display("FAIL: cmp  a=%d b=%d -> gt=%b eq=%b lt=%b (expected gt=%b eq=%b lt=%b)",
                          a, b, gt, eq, lt, exp_gt, exp_eq, exp_lt);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("14_multiplier_comparator.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 4'd3;  b = 4'd4;  #10 check;
        a = 4'd7;  b = 4'd7;  #10 check;
        a = 4'd15; b = 4'd15; #10 check;
        a = 4'd0;  b = 4'd5;  #10 check;
        a = 4'd9;  b = 4'd2;  #10 check;
        a = 4'd5;  b = 4'd9;  #10 check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
