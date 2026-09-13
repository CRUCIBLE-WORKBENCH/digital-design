module d_flipflop (
    input  wire d,
    input  wire clk,
    input  wire rst,
    output reg  q
);

    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule


module shift_register_8bit (
    input  wire       serial_in,
    input  wire       clk,
    input  wire       rst,
    output wire [7:0] parallel_out
);

    wire [7:0] q;

    d_flipflop ff0 (.d(serial_in), .clk(clk), .rst(rst), .q(q[0]));
    d_flipflop ff1 (.d(q[0]),      .clk(clk), .rst(rst), .q(q[1]));
    d_flipflop ff2 (.d(q[1]),      .clk(clk), .rst(rst), .q(q[2]));
    d_flipflop ff3 (.d(q[2]),      .clk(clk), .rst(rst), .q(q[3]));
    d_flipflop ff4 (.d(q[3]),      .clk(clk), .rst(rst), .q(q[4]));
    d_flipflop ff5 (.d(q[4]),      .clk(clk), .rst(rst), .q(q[5]));
    d_flipflop ff6 (.d(q[5]),      .clk(clk), .rst(rst), .q(q[6]));
    d_flipflop ff7 (.d(q[6]),      .clk(clk), .rst(rst), .q(q[7]));

    assign parallel_out = q;

endmodule
