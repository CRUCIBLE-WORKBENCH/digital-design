// Dataflow-style combinational arithmetic unit

module dataflow_arith_unit(a, b, sum, diff, prod);
    input  [3:0] a, b;
    output [4:0] sum;
    output [4:0] diff;
    output [7:0] prod;

    assign sum  = a + b;
    assign diff = a - b;
    assign prod = a * b;
endmodule
