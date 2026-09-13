`timescale 1ns/1ps

module three_num_adder_tb;

    reg  [7:0] a;
    reg  [7:0] b;
    reg  [7:0] c;
    wire [9:0] sum;

    integer i;
    integer expected_sum;

    three_num_adder DUT (
        .a   (a),
        .b   (b),
        .c   (c),
        .sum (sum)
    );

    task check_sum;
        input [7:0] a_value;
        input [7:0] b_value;
        input [7:0] c_value;
        begin
            a = a_value;
            b = b_value;
            c = c_value;
            #10;
            expected_sum = a_value + b_value + c_value;
            if (sum !== expected_sum[9:0]) begin
                $display("ERROR: a=%0d b=%0d c=%0d expected=%0d got=%0d",
                         a_value, b_value, c_value, expected_sum, sum);
                $finish;
            end
        end
    endtask

    initial begin
        $dumpfile("three_num_adder_tb.vcd");
        $dumpvars(0, three_num_adder_tb);

        $monitor("Time=%0t | a=%0d | b=%0d | c=%0d | sum=%0d",
                 $time, a, b, c, sum);

        check_sum(8'd0,   8'd0,   8'd0);
        check_sum(8'd1,   8'd2,   8'd3);
        check_sum(8'd15,  8'd16,  8'd17);
        check_sum(8'd85,  8'd42,  8'd21);
        check_sum(8'd255, 8'd255, 8'd255);

        for (i = 0; i < 8; i = i + 1)
            check_sum(i, i * 3, i * 5);

        $display("Three-number adder test passed.");
        $finish;
    end

endmodule
