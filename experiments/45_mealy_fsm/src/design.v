module mealy_1011_v(input clk, input rst_n, input din, output reg detected);
  localparam S0=2'd0, S1=2'd1, S10=2'd2, S101=2'd3;
  reg [1:0] state, next_state;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) state <= S0; else state <= next_state;
  end
  always @* begin
    detected = 1'b0;
    case (state)
      S0:   next_state = din ? S1 : S0;
      S1:   next_state = din ? S1 : S10;
      S10:  next_state = din ? S101 : S0;
      S101: begin detected = din; next_state = din ? S1 : S10; end
      default: next_state = S0;
    endcase
  end
endmodule
