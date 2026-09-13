// Negedge-triggered D flip-flop with synchronous reset
module d_flipflop_negedge(
    input      d,
    input      clk,
    input      rst,
    output reg q
);
    always @(negedge clk) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
