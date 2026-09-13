// Self-checking testbench for counter_4bit
`timescale 1ns/1ps
module tb_design;
    reg        clk, rst, en;
    wire [3:0] count;
    integer errors;
    reg [3:0] expected;

    counter_4bit dut(.clk(clk), .rst(rst), .en(en), .count(count));

    always #5 clk = ~clk;

    task check;
        begin
            if (count === expected)
                $display("PASS: time=%0t count=%d (expected %d)", $time, count, expected);
            else begin
                $display("FAIL: time=%0t count=%d (expected %d)", $time, count, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        clk = 0; rst = 1; en = 0;
        expected = 4'd0;

        @(posedge clk); #1; check; // reset applied

        rst = 0; en = 1;
        @(posedge clk); #1; expected = 4'd1; check;
        @(posedge clk); #1; expected = 4'd2; check;
        @(posedge clk); #1; expected = 4'd3; check;

        en = 0;
        @(posedge clk); #1; expected = 4'd3; check; // hold
        @(posedge clk); #1; expected = 4'd3; check; // hold

        en = 1;
        @(posedge clk); #1; expected = 4'd4; check;
        @(posedge clk); #1; expected = 4'd5; check;

        rst = 1;
        @(posedge clk); #1; expected = 4'd0; check; // sync reset

        rst = 0;
        @(posedge clk); #1; expected = 4'd1; check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
