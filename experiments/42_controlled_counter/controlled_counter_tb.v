// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/42_controlled_counter/controlled_counter_tb.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module controlled_counter_tb;

    parameter CYCLE = 10;

    reg        clock;
    reg        reset;
    reg        w;
    wire [3:0] count;

    controlled_counter DUT (
        .clock (clock),
        .reset (reset),
        .w     (w),
        .count (count)
    );

    initial clock = 1'b0;
    always #(CYCLE/2) clock = ~clock;

    task check_count;
        input [3:0] expected;
        begin
            @(posedge clock);
            #1;
            if (count !== expected) begin
                $display("ERROR: w=%b expected=%0d got=%0d", w, expected, count);
                $finish;
            end
        end
    endtask

    initial begin
        $dumpfile("controlled_counter_tb.vcd");
        $dumpvars(0, controlled_counter_tb);

        $monitor("Time=%0t | reset=%b | w=%b | count=%0d",
                 $time, reset, w, count);

        reset = 1'b1;
        w     = 1'b0;
        check_count(4'd0);
        reset = 1'b0;

        w = 1'b1;
        check_count(4'd2);
        check_count(4'd4);
        check_count(4'd6);
        check_count(4'd8);
        check_count(4'd0);

        w = 1'b0;
        check_count(4'd15);
        check_count(4'd14);
        check_count(4'd13);

        w = 1'b1;
        check_count(4'd5);
        check_count(4'd7);
        check_count(4'd9);
        check_count(4'd1);
        check_count(4'd3);

        reset = 1'b1;
        check_count(4'd0);

        $display("Controlled counter test passed.");
        $finish;
    end

endmodule
