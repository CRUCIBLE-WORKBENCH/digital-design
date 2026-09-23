// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/49_dataflow_modeling/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for dataflow_arith_unit

module tb_design;
    reg  [3:0] a, b;
    wire [4:0] sum, diff;
    wire [7:0] prod;
    integer errors;
    reg [4:0] exp_sum, exp_diff;
    reg [7:0] exp_prod;

    dataflow_arith_unit dut(.a(a), .b(b), .sum(sum), .diff(diff), .prod(prod));

    task check;
        begin
            exp_sum  = a + b;
            exp_diff = a - b;
            exp_prod = a * b;

            if (sum === exp_sum && diff === exp_diff && prod === exp_prod)
                $display("PASS: a=%d b=%d -> sum=%d diff=%d prod=%d", a, b, sum, diff, prod);
            else begin
                $display("FAIL: a=%d b=%d -> sum=%d diff=%d prod=%d (expected sum=%d diff=%d prod=%d)",
                          a, b, sum, diff, prod, exp_sum, exp_diff, exp_prod);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("49_dataflow_modeling.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 4'd5;  b = 4'd3;  #10 check;
        a = 4'd2;  b = 4'd9;  #10 check; // negative diff
        a = 4'd15; b = 4'd15; #10 check; // max sum/prod
        a = 4'd0;  b = 4'd0;  #10 check;
        a = 4'd7;  b = 4'd6;  #10 check;
        a = 4'd12; b = 4'd4;  #10 check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
