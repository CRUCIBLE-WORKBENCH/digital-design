// Self-checking testbench for ripple_carry_adder_4bit

module tb_design;
    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;
    integer    errors;
    reg  [4:0] expected;

    ripple_carry_adder_4bit dut(.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    task check;
        begin
            expected = a + b + cin;
            if ({cout, sum} === expected)
                $display("PASS: a=%d b=%d cin=%b -> sum=%d cout=%b", a, b, cin, sum, cout);
            else begin
                $display("FAIL: a=%d b=%d cin=%b -> sum=%d cout=%b (expected sum=%d cout=%b)",
                          a, b, cin, sum, cout, expected[3:0], expected[4]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        a = 4'd3;  b = 4'd4;  cin = 0; #10 check;
        a = 4'd15; b = 4'd1;  cin = 0; #10 check; // overflow
        a = 4'd15; b = 4'd15; cin = 1; #10 check; // overflow with carry-in
        a = 4'd0;  b = 4'd0;  cin = 0; #10 check;
        a = 4'd7;  b = 4'd8;  cin = 1; #10 check;
        a = 4'd10; b = 4'd5;  cin = 0; #10 check;

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
