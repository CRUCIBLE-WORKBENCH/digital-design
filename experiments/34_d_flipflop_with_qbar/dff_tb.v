`timescale 1ns/1ps

module dff_tb;

    parameter CYCLE = 10;

    reg  d_in;
    reg  clock;
    reg  reset;
    wire Q_out;
    wire Qb_out;

    task check_outputs(input expected_q, input expected_qb);
        begin
            @(posedge clock);
            #1;
            if (Q_out !== expected_q || Qb_out !== expected_qb) begin
                $display("ERROR: Time=%0t | expected Q_out=%b Qb_out=%b | got Q_out=%b Qb_out=%b",
                         $time, expected_q, expected_qb, Q_out, Qb_out);
                $finish;
            end
        end
    endtask

    dff DUT (
        .d_in   (d_in),
        .clock  (clock),
        .reset  (reset),
        .Q_out  (Q_out),
        .Qb_out (Qb_out)
    );

    initial clock = 1'b0;
    always #(CYCLE/2) clock = ~clock;

    initial begin
        reset = 1'b1;
        d_in  = 1'b0;

        $monitor("Time=%0t | reset=%b | d_in=%b | Q_out=%b | Qb_out=%b",
                 $time, reset, d_in, Q_out, Qb_out);

        check_outputs(1'b0, 1'b1);
        check_outputs(1'b0, 1'b1);
        reset = 1'b0;

        check_outputs(1'b0, 1'b1);

        @(negedge clock); d_in = 1'b1; check_outputs(1'b1, 1'b0);
        @(negedge clock); d_in = 1'b0; check_outputs(1'b0, 1'b1);
        @(negedge clock); d_in = 1'b1; check_outputs(1'b1, 1'b0);
        @(negedge clock); d_in = 1'b1; check_outputs(1'b1, 1'b0);
        @(negedge clock); d_in = 1'b0; check_outputs(1'b0, 1'b1);

        check_outputs(1'b0, 1'b1);

        $display("DFF test passed.");

        $finish;
    end

    initial begin
        $dumpfile("dff_tb.vcd");
        $dumpvars(0, dff_tb);
    end

endmodule
