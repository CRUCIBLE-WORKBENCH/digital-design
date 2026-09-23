// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/25_demux_rom/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// Self-checking testbench for demux_1to8 and rom_8x4

module tb_design;
    reg        d_in;
    reg  [2:0] sel;
    wire [7:0] d_out;

    reg  [2:0] addr;
    wire [3:0] data;

    integer errors, i;
    reg [7:0] exp_out;
    reg [3:0] exp_data;
    reg [3:0] rom_pattern [0:7];

    demux_1to8 dmux_dut(.in(d_in), .sel(sel), .out(d_out));
    rom_8x4    rom_dut(.addr(addr), .data(data));

    task check_demux;
        begin
            exp_out = d_in ? (8'b1 << sel) : 8'b0;
            if (d_out === exp_out)
                $display("PASS: demux in=%b sel=%d -> out=%b", d_in, sel, d_out);
            else begin
                $display("FAIL: demux in=%b sel=%d -> out=%b (expected %b)", d_in, sel, d_out, exp_out);
                errors = errors + 1;
            end
        end
    endtask

    task check_rom;
        begin
            exp_data = rom_pattern[addr];
            if (data === exp_data)
                $display("PASS: rom addr=%d -> data=%h", addr, data);
            else begin
                $display("FAIL: rom addr=%d -> data=%h (expected %h)", addr, data, exp_data);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("25_demux_rom.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        rom_pattern[0] = 4'h1;
        rom_pattern[1] = 4'h3;
        rom_pattern[2] = 4'h5;
        rom_pattern[3] = 4'h7;
        rom_pattern[4] = 4'h9;
        rom_pattern[5] = 4'hB;
        rom_pattern[6] = 4'hD;
        rom_pattern[7] = 4'hF;

        d_in = 1;
        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            #10 check_demux;
        end
        d_in = 0; sel = 3'd2; #10 check_demux;

        for (i = 0; i < 8; i = i + 1) begin
            addr = i[2:0];
            #10 check_rom;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
