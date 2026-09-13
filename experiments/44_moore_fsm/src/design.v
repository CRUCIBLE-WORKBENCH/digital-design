module moore_1011_v(input clk, input rst_n, input din, output detected);
  localparam S0=3'd0, S1=3'd1, S10=3'd2, S101=3'd3, S1011=3'd4;
  reg [2:0] state, next_state;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= S0; else state <= next_state;
  end
  always @* begin
    case (state)
      S0:    next_state = din ? S1 : S0;
      S1:    next_state = din ? S1 : S10;
      S10:   next_state = din ? S101 : S0;
      S101:  next_state = din ? S1011 : S10;
      S1011: next_state = din ? S1 : S10;
      default: next_state = S0;
    endcase
  end
  assign detected = (state == S1011);
endmodule
