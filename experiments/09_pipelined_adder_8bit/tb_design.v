`timescale 1ns/1ps

module tb_design;

    reg  [7:0] a, b;
    reg        cin, clk;
    wire [7:0] sum;
    wire       cout;
    integer errors;
    integer i;

    reg [7:0] a_q1, b_q1;
    reg       cin_q1;
    reg [7:0] a_q2, b_q2;
    reg       cin_q2;
    reg [8:0] expected;

    pipelined_adder_8bit dut (
        .a(a),
        .b(b),
        .cin(cin),
        .clk(clk),
        .sum(sum),
        .cout(cout)
    );

    always #5 clk = ~clk;

    // shadow pipeline of inputs to know what result corresponds to which cycle
    always @(posedge clk) begin
        a_q1 <= a; b_q1 <= b; cin_q1 <= cin;
        a_q2 <= a_q1; b_q2 <= b_q1; cin_q2 <= cin_q1;
    end

    initial begin
        $dumpfile("09_pipelined_adder_8bit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;
        clk = 0;
        a = 0; b = 0; cin = 0;

        // apply a sequence of test vectors, one per cycle
        apply(8'd10, 8'd20, 1'b0);
        apply(8'd200, 8'd100, 1'b0);
        apply(8'd255, 8'd1, 1'b0);
        apply(8'd128, 8'd127, 1'b1);
        apply(8'd0, 8'd0, 1'b0);

        // hold inputs steady to flush pipeline and check last results
        repeat (3) begin
            @(posedge clk); #1;
            expected = a_q2 + b_q2 + cin_q2;
            if ({cout, sum} === expected) begin
                $display("PASS: a=%0d b=%0d cin=%b -> sum=%0d cout=%b",
                          a_q2, b_q2, cin_q2, sum, cout);
            end else begin
                $display("FAIL: a=%0d b=%0d cin=%b -> sum=%0d cout=%b (expected %0d)",
                          a_q2, b_q2, cin_q2, sum, cout, expected);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

    task apply;
        input [7:0] ta, tb;
        input       tcin;
        begin
            @(posedge clk); #1;
            a = ta; b = tb; cin = tcin;
        end
    endtask

endmodule
