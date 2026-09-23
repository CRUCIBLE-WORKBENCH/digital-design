// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/08_adder_subtractor_4bit/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

    reg  [3:0] a, b;
    reg        sub;
    wire [3:0] result;
    wire       cout;

    reg [3:0] b_xor;
    reg [4:0] full_result;
    integer errors;

    adder_subtractor_4bit dut (.a(a), .b(b), .sub(sub), .result(result), .cout(cout));

    task run_case;
        input [3:0] ta, tb;
        input tsub;
        begin
            a = ta; b = tb; sub = tsub;
            #5;
            b_xor = tb ^ {4{tsub}};
            full_result = ta + b_xor + tsub;

            if (result === full_result[3:0] && cout === full_result[4]) begin
                $display("PASS: a=%b b=%b sub=%b -> result=%b cout=%b (expected result=%b cout=%b)",
                          a, b, sub, result, cout, full_result[3:0], full_result[4]);
            end else begin
                $display("FAIL: a=%b b=%b sub=%b -> result=%b cout=%b (expected result=%b cout=%b)",
                          a, b, sub, result, cout, full_result[3:0], full_result[4]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("08_adder_subtractor_4bit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        run_case(4'b0011, 4'b0001, 1'b0);
        run_case(4'b1111, 4'b0001, 1'b0);
        run_case(4'b1000, 4'b1000, 1'b0);

        run_case(4'b0101, 4'b0011, 1'b1);
        run_case(4'b0011, 4'b0101, 1'b1);
        run_case(4'b0000, 4'b0001, 1'b1);
        run_case(4'b1000, 4'b1000, 1'b1);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
