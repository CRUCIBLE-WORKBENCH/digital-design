// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/51_inverter_behavioral/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for inverter_array
`timescale 1ns/1ps
module tb_design;
    reg  [7:0] in;
    wire [7:0] out;
    integer errors;

    inverter_array #(.WIDTH(8)) dut(.in(in), .out(out));

    task check;
        begin
            #10;
            if (out === ~in)
                $display("PASS: in=%b -> out=%b", in, out);
            else begin
                $display("FAIL: in=%b -> out=%b (expected %b)", in, out, ~in);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("51_inverter_behavioral.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        in = 8'b00000000; check;
        in = 8'b11111111; check;
        in = 8'b10101010; check;
        in = 8'b01010101; check;
        in = 8'b00001111; check;
        in = 8'b11110000; check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
