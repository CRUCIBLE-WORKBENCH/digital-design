// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/53_gate_modeling/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

    reg a, b;
    wire y_nand, y_or, y_nor, y_not, y_xor, y_xnor;

    integer i;
    integer errors;

    gate_modeling dut (
        .a(a), .b(b),
        .y_nand(y_nand), .y_or(y_or), .y_nor(y_nor),
        .y_not(y_not), .y_xor(y_xor), .y_xnor(y_xnor)
    );

    task check;
        input [0:0] actual;
        input [0:0] expected;
        input [127:0] name;
        begin
            if (actual === expected) begin
                $display("PASS: %s a=%b b=%b -> %b (expected %b)", name, a, b, actual, expected);
            end else begin
                $display("FAIL: %s a=%b b=%b -> %b (expected %b)", name, a, b, actual, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("53_gate_modeling.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i[1:0];
            #5;
            check(y_nand, ~(a & b), "NAND");
            check(y_or,   (a | b),  "OR  ");
            check(y_nor,  ~(a | b), "NOR ");
            check(y_not,  ~a,       "NOT ");
            check(y_xor,  (a ^ b),  "XOR ");
            check(y_xnor, ~(a ^ b), "XNOR");
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
