`timescale 1ns/1ps

module tb_design;

    reg  a, b;
    wire sum, carry;
    integer errors;
    integer i;
    reg exp_sum, exp_carry;

    half_adder dut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        $dumpfile("01_half_adder.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        for (i = 0; i < 4; i = i + 1) begin
            {a, b} = i[1:0];
            #5;
            exp_sum   = a ^ b;
            exp_carry = a & b;
            if (sum === exp_sum && carry === exp_carry) begin
                $display("PASS: a=%b b=%b -> sum=%b carry=%b", a, b, sum, carry);
            end else begin
                $display("FAIL: a=%b b=%b -> sum=%b carry=%b (expected sum=%b carry=%b)",
                          a, b, sum, carry, exp_sum, exp_carry);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
