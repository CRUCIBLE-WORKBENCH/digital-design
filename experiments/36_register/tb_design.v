// Self-checking testbench for register_8bit
`timescale 1ns/1ps
module tb_design;
    reg  [7:0] d;
    reg        clk, rst, load;
    wire [7:0] q;
    integer errors;

    register_8bit dut(.d(d), .clk(clk), .rst(rst), .load(load), .q(q));

    always #5 clk = ~clk;

    task check(input [7:0] exp);
        begin
            if (q === exp)
                $display("PASS: time=%0t d=%h load=%b rst=%b -> q=%h", $time, d, load, rst, q);
            else begin
                $display("FAIL: time=%0t d=%h load=%b rst=%b -> q=%h (expected %h)", $time, d, load, rst, q, exp);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        clk = 0; rst = 1; load = 0; d = 8'h00;
        #1; check(8'h00); // async reset

        rst = 0; d = 8'hA5; load = 1;
        @(posedge clk); #1; check(8'hA5); // load

        d = 8'h3C; load = 0;
        @(posedge clk); #1; check(8'hA5); // hold

        d = 8'hFF; load = 1;
        @(posedge clk); #1; check(8'hFF); // load new value

        rst = 1;
        #1; check(8'h00); // async reset mid-cycle

        rst = 0; load = 0;
        @(posedge clk); #1; check(8'h00); // still held after reset release

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
