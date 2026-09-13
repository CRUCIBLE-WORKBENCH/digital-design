module up_down_counter (
    input  wire       clock,
    input  wire       reset,
    input  wire       up_down,
    output reg  [3:0] count
);

    always @(posedge clock) begin
        if (reset)
            count <= 4'd0;
        else if (up_down)
            count <= count + 4'd1;
        else
            count <= count - 4'd1;
    end

endmodule
