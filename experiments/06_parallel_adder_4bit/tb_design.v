`timescale 1ns/1ps

module tb_design;

    reg  [3:0] a, b;
    reg        cin;
    wire [3:0] sum;
    wire       cout;

    reg [4:0] total;
    integer errors;

    parallel_adder_4bit dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

    task run_case;
        input [3:0] ta, tb;
        input tc;
        begin
            a = ta; b = tb; cin = tc;
            #5;
            total = ta + tb + tc;
            if (sum === total[3:0] && cout === total[4]) begin
                $display("PASS: a=%b b=%b cin=%b -> sum=%b cout=%b (expected sum=%b cout=%b)",
                          a, b, cin, sum, cout, total[3:0], total[4]);
            end else begin
                $display("FAIL: a=%b b=%b cin=%b -> sum=%b cout=%b (expected sum=%b cout=%b)",
                          a, b, cin, sum, cout, total[3:0], total[4]);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("06_parallel_adder_4bit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        run_case(4'b0000, 4'b0000, 1'b0);
        run_case(4'b0001, 4'b0001, 1'b0);
        run_case(4'b0011, 4'b0101, 1'b0);
        run_case(4'b0111, 4'b0001, 1'b0);
        run_case(4'b1111, 4'b0001, 1'b0);
        run_case(4'b1111, 4'b1111, 1'b1);
        run_case(4'b1010, 4'b0101, 1'b1);
        run_case(4'b1000, 4'b1000, 1'b0);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
