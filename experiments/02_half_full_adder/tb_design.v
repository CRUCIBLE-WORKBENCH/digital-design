// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/02_half_full_adder/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

    reg a, b, cin;
    wire sum, carry;
    reg exp_sum, exp_carry;

    integer i;
    integer errors;
    reg [1:0] total;

    full_adder dut (.a(a), .b(b), .cin(cin), .sum(sum), .carry(carry));

    initial begin
        $dumpfile("02_half_full_adder.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i[2:0];
            #5;
            total     = a + b + cin;
            exp_sum   = total[0];
            exp_carry = total[1];

            if (sum === exp_sum && carry === exp_carry) begin
                $display("PASS: a=%b b=%b cin=%b -> sum=%b carry=%b (expected sum=%b carry=%b)",
                          a, b, cin, sum, carry, exp_sum, exp_carry);
            end else begin
                $display("FAIL: a=%b b=%b cin=%b -> sum=%b carry=%b (expected sum=%b carry=%b)",
                          a, b, cin, sum, carry, exp_sum, exp_carry);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
