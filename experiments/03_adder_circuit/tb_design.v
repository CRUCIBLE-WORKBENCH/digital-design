// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/03_adder_circuit/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for adder_8bit
`timescale 1ns/1ps
module tb_design;
    reg  [7:0] a, b;
    reg        cin;
    wire [7:0] sum;
    wire       cout;
    integer errors;
    reg [8:0] expected;

    adder_8bit dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    task check;
        begin
            expected = a + b + cin;
            if (sum === expected[7:0] && cout === expected[8]) begin
                $display("PASS: a=%d b=%d cin=%d -> sum=%d cout=%d", a, b, cin, sum, cout);
            end else begin
                $display("FAIL: a=%d b=%d cin=%d -> sum=%d cout=%d (expected sum=%d cout=%d)",
                          a, b, cin, sum, cout, expected[7:0], expected[8]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("03_adder_circuit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 8'd0;   b = 8'd0;   cin = 0; #10 check;
        a = 8'd1;   b = 8'd1;   cin = 0; #10 check;
        a = 8'd255; b = 8'd1;   cin = 0; #10 check; // overflow
        a = 8'd255; b = 8'd255; cin = 1; #10 check; // overflow with cin
        a = 8'd100; b = 8'd50;  cin = 1; #10 check;
        a = 8'd128; b = 8'd128; cin = 0; #10 check; // overflow
        a = 8'd15;  b = 8'd15;  cin = 0; #10 check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
