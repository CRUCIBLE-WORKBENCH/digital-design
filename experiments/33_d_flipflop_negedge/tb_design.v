// Self-checking testbench for d_flipflop_negedge
`timescale 1ns/1ps
module tb_design;
    reg  d, clk, rst;
    wire q;
    integer errors;

    d_flipflop_negedge dut(.d(d), .clk(clk), .rst(rst), .q(q));

    always #5 clk = ~clk;

    task check(input exp);
        begin
            if (q === exp)
                $display("PASS: time=%0t d=%b rst=%b -> q=%b", $time, d, rst, q);
            else begin
                $display("FAIL: time=%0t d=%b rst=%b -> q=%b (expected %b)", $time, d, rst, q, exp);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        clk = 0; rst = 1; d = 0;

        @(negedge clk); #1; check(1'b0); // reset

        rst = 0; d = 1;
        @(negedge clk); #1; check(1'b1); // captures d on negedge

        d = 0;
        @(negedge clk); #1; check(1'b0);

        d = 1;
        // check no change on posedge
        @(posedge clk); #1; check(1'b0);
        @(negedge clk); #1; check(1'b1); // update happens on negedge

        rst = 1;
        @(negedge clk); #1; check(1'b0); // sync reset

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
