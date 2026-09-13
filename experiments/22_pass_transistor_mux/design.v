// 2-to-1 mux, behavioral model (RTL abstraction of pass-transistor mux)
module mux2to1_behavioral(
    input  a,
    input  b,
    input  sel,
    output reg y
);
    always @(*) begin
        if (sel)
            y = b;
        else
            y = a;
    end
endmodule
