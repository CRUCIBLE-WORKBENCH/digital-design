// Self-checking testbench for parallel_adder_subtractor_4bit

module tb_design;
    reg  [3:0] a, b;
    reg        sub;
    wire [3:0] result;
    wire       cout;
    integer    errors;
    reg  [4:0] expected;
    reg  [3:0] b_xor;

    parallel_adder_subtractor_4bit dut(.a(a), .b(b), .sub(sub), .result(result), .cout(cout));

    task check;
        begin
            // matches DUT: result/cout come from a + (b^sub) + sub
            // for sub=0 this is plain addition; for sub=1, cout=1 means no borrow (a>=b)
            b_xor = b ^ {4{sub}};
            expected = a + b_xor + sub;
            if ({cout, result} === expected[4:0])
                $display("PASS: a=%d b=%d sub=%b -> result=%d cout=%b", a, b, sub, result, cout);
            else begin
                $display("FAIL: a=%d b=%d sub=%b -> result=%d cout=%b (expected result=%d cout=%b)",
                          a, b, sub, result, cout, expected[3:0], expected[4]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        a = 4'd5; b = 4'd3; sub = 0; #10 check; // add
        a = 4'd7; b = 4'd8; sub = 0; #10 check; // add
        a = 4'd9; b = 4'd4; sub = 1; #10 check; // subtract, no borrow
        a = 4'd3; b = 4'd5; sub = 1; #10 check; // subtract, borrow
        a = 4'd15; b = 4'd15; sub = 0; #10 check; // add overflow
        a = 4'd0; b = 4'd0; sub = 1; #10 check; // subtract zero

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
