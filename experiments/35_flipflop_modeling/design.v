// Clocked SR, JK, T, D flip-flops with synchronous reset

module sr_flipflop(clk, rst, s, r, q);
    input clk, rst, s, r;
    output reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({s, r})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= 1'bx; // invalid state
            endcase
        end
    end
endmodule

module jk_flipflop(clk, rst, j, k, q);
    input clk, rst, j, k;
    output reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else begin
            case ({j, k})
                2'b00: q <= q;
                2'b01: q <= 1'b0;
                2'b10: q <= 1'b1;
                2'b11: q <= ~q;
            endcase
        end
    end
endmodule

module t_flipflop(clk, rst, t, q);
    input clk, rst, t;
    output reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else if (t)
            q <= ~q;
        else
            q <= q;
    end
endmodule

module d_flipflop(clk, rst, d, q);
    input clk, rst, d;
    output reg q;

    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
