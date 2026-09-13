module cnt (
    input clk,
    input rst,
    input en,
    output reg [7:0] count
);

always @(posedge clk) begin
    if (rst)
        count <= 8'd0;
    else if (en)
        count <= count + 8'd1;
    else
        count <= count;
end

endmodule
