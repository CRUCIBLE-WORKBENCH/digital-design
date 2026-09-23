// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/38_up_down_counter/up_down_counter_tb.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module up_down_counter_tb;

    parameter CYCLE = 10;

    reg        clock;
    reg        reset;
    reg        up_down;
    wire [3:0] count;

    up_down_counter DUT (
        .clock   (clock),
        .reset   (reset),
        .up_down (up_down),
        .count   (count)
    );

    initial clock = 1'b0;
    always #(CYCLE/2) clock = ~clock;

    task check_count;
        input [3:0] expected;
        begin
            @(posedge clock);
            #1;
            if (count !== expected) begin
                $display("ERROR: up_down=%b expected=%0d got=%0d",
                         up_down, expected, count);
                $finish;
            end
        end
    endtask

    initial begin
        $dumpfile("up_down_counter_tb.vcd");
        $dumpvars(0, up_down_counter_tb);

        $monitor("Time=%0t | reset=%b | up_down=%b | count=%0d",
                 $time, reset, up_down, count);

        reset   = 1'b1;
        up_down = 1'b1;
        check_count(4'd0);
        reset = 1'b0;

        // Count up: 0 -> 1 -> 2 -> 3 -> 4
        up_down = 1'b1;
        check_count(4'd1);
        check_count(4'd2);
        check_count(4'd3);
        check_count(4'd4);

        // Switch to down: 4 -> 3 -> 2 -> 1 -> 0
        up_down = 1'b0;
        check_count(4'd3);
        check_count(4'd2);
        check_count(4'd1);
        check_count(4'd0);

        // Down wrap: 0 -> 15
        check_count(4'd15);

        // Continue down: 15 -> 14
        check_count(4'd14);

        // Switch to up: 14 -> 15
        up_down = 1'b1;
        check_count(4'd15);

        // Up wrap: 15 -> 0
        check_count(4'd0);

        // Continue up: 0 -> 1
        check_count(4'd1);

        // Mid-count reset
        reset = 1'b1;
        check_count(4'd0);

        // Resume after reset
        reset = 1'b0;
        up_down = 1'b1;
        check_count(4'd1);
        check_count(4'd2);

        up_down = 1'b0;
        check_count(4'd1);
        check_count(4'd0);

        $display("Up/down counter test passed.");
        $finish;
    end

endmodule
