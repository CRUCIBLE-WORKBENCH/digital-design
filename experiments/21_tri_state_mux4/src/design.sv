module tri_state_mux4 #(parameter int W=8)(
  input logic en,
  input logic [1:0] sel,
  input logic [W-1:0] d0, d1, d2, d3,
  output tri [W-1:0] y
);
  assign y = en ? (sel == 2'd0 ? d0 : sel == 2'd1 ? d1 : sel == 2'd2 ? d2 : d3) : {W{1'bz}};
endmodule
