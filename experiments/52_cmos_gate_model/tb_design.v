// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/52_cmos_gate_model/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for cmos_gates_behavioral, exhaustive 4 combos

module tb_design;
    reg  a, b;
    wire y_nand, y_nor, y_xor, y_xnor;
    integer errors, i;
    reg exp_nand, exp_nor, exp_xor, exp_xnor;

    cmos_gates_behavioral dut(.a(a), .b(b), .y_nand(y_nand), .y_nor(y_nor), .y_xor(y_xor), .y_xnor(y_xnor));

    task check;
        begin
            exp_nand = ~(a & b);
            exp_nor  = ~(a | b);
            exp_xor  = a ^ b;
            exp_xnor = ~(a ^ b);

            if (y_nand === exp_nand && y_nor === exp_nor && y_xor === exp_xor && y_xnor === exp_xnor)
                $display("PASS: a=%b b=%b -> nand=%b nor=%b xor=%b xnor=%b", a, b, y_nand, y_nor, y_xor, y_xnor);
            else begin
                $display("FAIL: a=%b b=%b -> nand=%b nor=%b xor=%b xnor=%b (expected %b %b %b %b)",
                          a, b, y_nand, y_nor, y_xor, y_xnor, exp_nand, exp_nor, exp_xor, exp_xnor);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("52_cmos_gate_model.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i[1:0];
            #10 check;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
