typedef enum logic [1:0] {S0, S1, S10, S101} state_t;
module mealy_1011(input logic clk, rst_n, din, output logic detected);
  state_t state, next_state;
  always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= S0; else state <= next_state;
  end
  always_comb begin
    detected = 1'b0;
    case (state)
      S0:   if (din) next_state = S1; else next_state = S0;
      S1:   if (din) next_state = S1; else next_state = S10;
      S10:  if (din) next_state = S101; else next_state = S0;
      S101: begin
        detected = din;
        if (din) next_state = S1; else next_state = S10;
      end
      default: next_state = S0;
    endcase
  end
endmodule
