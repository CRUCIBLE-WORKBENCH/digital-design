`timescale 1ns/1ps

module tb_design;

    reg  [1:0] a, b;
    reg        cin;
    wire [1:0] sum;
    wire       cout;
    integer errors;
    integer i;
    reg [2:0] expected;

    full_adder_2bit dut (
        .a(a),
        .b(b),
        .cin(cin),
        .sum(sum),
        .cout(cout)
    );

    initial begin
        errors = 0;
        for (i = 0; i < 16; i = i + 1) begin
            {a, b, cin} = i[4:0];
            #5;
            expected = a + b + cin;
            if ({cout, sum} === expected) begin
                $display("PASS: a=%b b=%b cin=%b -> sum=%b cout=%b", a, b, cin, sum, cout);
            end else begin
                $display("FAIL: a=%b b=%b cin=%b -> sum=%b cout=%b (expected %b)",
                          a, b, cin, sum, cout, expected);
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
