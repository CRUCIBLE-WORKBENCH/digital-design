// Self-checking testbench for multiplier_4bit
`timescale 1ns/1ps
module tb_design;
    reg  [3:0] a, b;
    wire [7:0] product;
    integer errors;
    reg [7:0] expected;

    multiplier_4bit dut(.a(a), .b(b), .product(product));

    task check;
        begin
            #10;
            expected = a * b;
            if (product === expected)
                $display("PASS: a=%d b=%d -> product=%d", a, b, product);
            else begin
                $display("FAIL: a=%d b=%d -> product=%d (expected %d)", a, b, product, expected);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        a = 4'd0;  b = 4'd0;  check;
        a = 4'd1;  b = 4'd1;  check;
        a = 4'd3;  b = 4'd4;  check;
        a = 4'd7;  b = 4'd2;  check;
        a = 4'd9;  b = 4'd9;  check;
        a = 4'd15; b = 4'd15; check; // max values
        a = 4'd15; b = 4'd0;  check;
        a = 4'd10; b = 4'd10; check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
