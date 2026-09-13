// 4-bit adder/subtractor using XOR-based two's complement control

module parallel_adder_subtractor_4bit(a, b, sub, result, cout);
    input  [3:0] a, b;
    input        sub;
    output [3:0] result;
    output       cout;

    wire [3:0] b_xor;
    wire [4:0] sum;

    assign b_xor = b ^ {4{sub}};
    assign sum   = a + b_xor + sub;

    assign result = sum[3:0];
    assign cout   = sum[4];
endmodule
