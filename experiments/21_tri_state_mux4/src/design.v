module tri_state_mux4_v #(parameter W=8)(
  input en,
  input [1:0] sel,
  input [W-1:0] d0,
  input [W-1:0] d1,
  input [W-1:0] d2,
  input [W-1:0] d3,
  output [W-1:0] y
);
  assign y = en ? (sel == 2'd0 ? d0 : sel == 2'd1 ? d1 : sel == 2'd2 ? d2 : d3) : {W{1'bz}};
endmodule
