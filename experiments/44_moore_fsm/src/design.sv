typedef enum logic [2:0] {S0, S1, S10, S101, S1011} state_t;

module moore_1011(input logic clk, rst_n, din, output logic detected);
  state_t state, next_state;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= S0; else state <= next_state;
  end
  always_comb begin
    case (state)
      S0:    if (din) next_state = S1; else next_state = S0;
      S1:    if (din) next_state = S1; else next_state = S10;
      S10:   if (din) next_state = S101; else next_state = S0;
      S101:  if (din) next_state = S1011; else next_state = S10;
      S1011: if (din) next_state = S1; else next_state = S10;
      default: next_state = S0;
    endcase
  end
  assign detected = (state == S1011);
endmodule
