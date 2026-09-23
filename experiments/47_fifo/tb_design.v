// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/47_fifo/tb_design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module tb_design;

reg clk;
reg rst;
reg wr_en;
reg rd_en;
reg [7:0] din;
wire [7:0] dout;
wire full;
wire empty;

integer errors;
integer i;

fifo #(.DEPTH(8), .WIDTH(8)) DUT (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
);

always #5 clk = ~clk;

task check_bit;
    input actual;
    input expected;
    input [127:0] label;
    begin
        if (actual === expected) begin
            $display("PASS: time=%0t %0s actual=%b expected=%b", $time, label, actual, expected);
        end else begin
            $display("FAIL: time=%0t %0s actual=%b expected=%b", $time, label, actual, expected);
            errors = errors + 1;
        end
    end
endtask

task check_byte;
    input [7:0] actual;
    input [7:0] expected;
    input [127:0] label;
    begin
        if (actual === expected) begin
            $display("PASS: time=%0t %0s actual=%0d expected=%0d", $time, label, actual, expected);
        end else begin
            $display("FAIL: time=%0t %0s actual=%0d expected=%0d", $time, label, actual, expected);
            errors = errors + 1;
        end
    end
endtask

initial begin
        $dumpfile("47_fifo.vcd");
        $dumpvars(0, tb_design);

    clk = 0;
    rst = 1;
    wr_en = 0;
    rd_en = 0;
    din = 8'd0;
    errors = 0;

    repeat (2) @(posedge clk);
    rst = 0;
    check_bit(empty, 1'b1, "empty after reset");
    check_bit(full, 1'b0, "not full after reset");

    // write until full (8 entries)
    for (i = 0; i < 8; i = i + 1) begin
        @(negedge clk);
        wr_en = 1;
        din = i[7:0];
        @(posedge clk);
    end
    @(negedge clk);
    wr_en = 0;
    check_bit(full, 1'b1, "full after 8 writes");
    check_bit(empty, 1'b0, "not empty after 8 writes");

    // attempt write while full, should be ignored
    @(negedge clk);
    wr_en = 1;
    din = 8'hFF;
    @(posedge clk);
    @(negedge clk);
    wr_en = 0;
    check_bit(full, 1'b1, "still full, overflow write ignored");

    // read until empty, verify FIFO order 0..7
    for (i = 0; i < 8; i = i + 1) begin
        @(negedge clk);
        rd_en = 1;
        @(posedge clk);
        @(negedge clk);
        rd_en = 0;
        check_byte(dout, i[7:0], "read order check");
    end
    check_bit(empty, 1'b1, "empty after 8 reads");
    check_bit(full, 1'b0, "not full after draining");

    // simultaneous read/write test
    @(negedge clk);
    wr_en = 1;
    din = 8'hAA;
    @(posedge clk);
    @(negedge clk);
    wr_en = 0;
    check_bit(empty, 1'b0, "one entry present before simul rw");

    @(negedge clk);
    wr_en = 1;
    rd_en = 1;
    din = 8'hBB;
    @(posedge clk);
    @(negedge clk);
    wr_en = 0;
    rd_en = 0;
    check_byte(dout, 8'hAA, "simultaneous rw returns oldest entry");
    check_bit(empty, 1'b0, "one entry remains after simul rw");

    @(negedge clk);
    rd_en = 1;
    @(posedge clk);
    @(negedge clk);
    rd_en = 0;
    check_byte(dout, 8'hBB, "final entry matches last write");
    check_bit(empty, 1'b1, "empty after draining simul rw entry");

    if (errors == 0)
        $display("SUMMARY: ALL TESTS PASSED");
    else
        $display("SUMMARY: %0d TEST(S) FAILED", errors);

    $finish;
end

endmodule
