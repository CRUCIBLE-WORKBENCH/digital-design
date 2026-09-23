// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/41_mealy_sequence_detector/mealy_seq_det_tb.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

`timescale 1ns/1ps

module mealy_seq_det_tb;

    parameter CYCLE = 10;

    reg  clock;
    reg  reset;
    reg  seq_in;
    wire det_o;

    integer i;
    reg [15:0] stream;
    reg [2:0] history;
    reg expected_det;

    mealy_seq_det DUT (
        .clock  (clock),
        .reset  (reset),
        .seq_in (seq_in),
        .det_o  (det_o)
    );

    initial clock = 1'b0;
    always #(CYCLE/2) clock = ~clock;

    task apply_reset;
        begin
            reset = 1'b1;
            seq_in = 1'b0;
            history = 3'b000;
            @(posedge clock);
            @(posedge clock);
            reset = 1'b0;
        end
    endtask

    task drive_bit;
        input bit_value;
        begin
            @(negedge clock);
            seq_in = bit_value;
            history = {history[1:0], bit_value};
            expected_det = (history == 3'b101);
            #1;
            if (det_o !== expected_det) begin
                $display("ERROR: bit=%b history=%b expected=%b got=%b",
                         bit_value, history, expected_det, det_o);
                $finish;
            end
        end
    endtask

    initial begin
        $dumpfile("mealy_seq_det_tb.vcd");
        $dumpvars(0, mealy_seq_det_tb);

        $monitor("Time=%0t | seq_in=%b | state=%b | det_o=%b",
                 $time, seq_in, DUT.present_state, det_o);

        stream = 16'b1011010110010101;
        expected_det = 1'b0;
        apply_reset;

        for (i = 15; i >= 0; i = i - 1)
            drive_bit(stream[i]);

        @(posedge clock);
        $display("Mealy sequence detector test passed.");
        $finish;
    end

endmodule
