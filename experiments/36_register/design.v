// 8-bit parallel-load register with clock enable and async reset
module register_8bit(
    input      [7:0] d,
    input            clk,
    input            rst,
    input            load,
    output reg [7:0] q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 8'b0;
        else if (load)
            q <= d;
    end
endmodule
