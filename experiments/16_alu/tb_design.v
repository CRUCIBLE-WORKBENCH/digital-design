// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/16_alu/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for alu_4bit
`timescale 1ns/1ps
module tb_design;
    reg  [3:0] a, b;
    reg  [2:0] opcode;
    wire [3:0] result;
    wire       zero;
    integer errors;
    reg [3:0] expected;

    alu_4bit dut(.a(a), .b(b), .opcode(opcode), .result(result), .zero(zero));

    task check;
        begin
            #10;
            if (result === expected && zero === (expected == 4'b0000)) begin
                $display("PASS: a=%d b=%d op=%b -> result=%d zero=%b", a, b, opcode, result, zero);
            end else begin
                $display("FAIL: a=%d b=%d op=%b -> result=%d zero=%b (expected result=%d)",
                          a, b, opcode, result, zero, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("16_alu.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 4'd3; b = 4'd4; opcode = 3'b000; expected = 4'd7;  check; // ADD
        a = 4'd5; b = 4'd5; opcode = 3'b001; expected = 4'd0;  check; // SUB -> zero
        a = 4'd2; b = 4'd7; opcode = 3'b001; expected = (4'd2 - 4'd7); check; // SUB underflow
        a = 4'b1100; b = 4'b1010; opcode = 3'b010; expected = 4'b1000; check; // AND
        a = 4'b1100; b = 4'b1010; opcode = 3'b011; expected = 4'b1110; check; // OR
        a = 4'b1100; b = 4'b1010; opcode = 3'b100; expected = 4'b0110; check; // XOR
        a = 4'b1010; b = 4'b0000; opcode = 3'b101; expected = 4'b0101; check; // NOT a
        a = 4'b0011; b = 4'b0000; opcode = 3'b110; expected = 4'b0110; check; // SHL
        a = 4'b0110; b = 4'b0000; opcode = 3'b111; expected = 4'b0011; check; // SHR
        a = 4'd0;  b = 4'd0; opcode = 3'b000; expected = 4'd0;  check; // ADD zero

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
