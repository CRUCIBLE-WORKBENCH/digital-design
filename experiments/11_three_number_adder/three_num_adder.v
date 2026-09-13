module three_num_adder (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [7:0] c,
    output wire [9:0] sum
);

    assign sum = {2'b00, a} + {2'b00, b} + {2'b00, c};

endmodule
