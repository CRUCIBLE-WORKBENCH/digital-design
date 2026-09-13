module riseedge_mealy (
    input clk,
    input rst,
    input sig_in,
    output edge_pulse
);

parameter S0 = 1'b0;
parameter S1 = 1'b1;

reg state, next_state;

always @(posedge clk) begin
    if (rst)
        state <= S0;
    else
        state <= next_state;
end

always @(*) begin
    case (state)
        S0: next_state = sig_in ? S1 : S0;
        S1: next_state = sig_in ? S1 : S0;
        default: next_state = S0;
    endcase
end

assign edge_pulse = (state == S0) && sig_in;

endmodule
