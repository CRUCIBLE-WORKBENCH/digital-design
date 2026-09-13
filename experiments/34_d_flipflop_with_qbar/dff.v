module dff (
    input  wire d_in,
    input  wire clock,
    input  wire reset,
    output reg  Q_out,
    output reg  Qb_out
);

    always @(posedge clock) begin
        if (reset) begin
            Q_out  <= 1'b0;
            Qb_out <= 1'b1;
        end
        else begin
            Q_out  <= d_in;
            Qb_out <= ~d_in;
        end
    end

endmodule
