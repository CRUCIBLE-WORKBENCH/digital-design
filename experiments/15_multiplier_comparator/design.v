// 4-bit multiplier and 4-bit comparator

module multiplier_4bit(a, b, product);
    input  [3:0] a, b;
    output [7:0] product;

    assign product = a * b;
endmodule

module comparator_4bit(a, b, gt, eq, lt);
    input  [3:0] a, b;
    output       gt, eq, lt;

    assign gt = (a > b);
    assign eq = (a == b);
    assign lt = (a < b);
endmodule
