// Behavioral inverter array, parametrizable width (default 8)
module inverter_array #(
    parameter WIDTH = 8
) (
    input  [WIDTH-1:0] in,
    output [WIDTH-1:0] out
);
    assign out = ~in;
endmodule
