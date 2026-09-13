module mux2to1(
    input  wire a,
    input  wire b,
    input  wire sel,
    output wire y
);

    assign y = sel ? b : a;

endmodule


module decoder2to4(
    input  wire [1:0] in,
    input  wire       en,
    output reg  [3:0] out
);

    always @(*) begin
        if (en) begin
            case (in)
                2'b00: out = 4'b0001;
                2'b01: out = 4'b0010;
                2'b10: out = 4'b0100;
                2'b11: out = 4'b1000;
                default: out = 4'b0000;
            endcase
        end else begin
            out = 4'b0000;
        end
    end

endmodule


module tristate_buffer(
    input  wire a,
    input  wire en,
    output wire y
);

    assign y = en ? a : 1'bz;

endmodule
