// Self-checking testbench for comparator_4bit
`timescale 1ns/1ps
module tb_design;
    reg  [3:0] a, b;
    wire       gt, eq, lt;
    integer errors;

    comparator_4bit dut(.a(a), .b(b), .gt(gt), .eq(eq), .lt(lt));

    task check;
        begin
            #10;
            if (gt === (a > b) && eq === (a == b) && lt === (a < b)) begin
                $display("PASS: a=%d b=%d -> gt=%b eq=%b lt=%b", a, b, gt, eq, lt);
            end else begin
                $display("FAIL: a=%d b=%d -> gt=%b eq=%b lt=%b", a, b, gt, eq, lt);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("12_comparator.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 4'd5; b = 4'd3; check;  // a>b
        a = 4'd3; b = 4'd5; check;  // a<b
        a = 4'd7; b = 4'd7; check;  // a==b
        a = 4'd0; b = 4'd0; check;  // a==b
        a = 4'd15; b = 4'd0; check; // a>b
        a = 4'd0; b = 4'd15; check; // a<b

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
