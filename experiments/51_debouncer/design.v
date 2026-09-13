module debouncing #(
    parameter N = 4
) (
    input clk,
    input rst,
    input btn_in,
    output reg btn_out
);

reg [N-1:0] count;
reg btn_sync;

always @(posedge clk) begin
    if (rst) begin
        count   <= {N{1'b0}};
        btn_sync <= 1'b0;
        btn_out <= 1'b0;
    end else begin
        btn_sync <= btn_in;

        if (btn_sync == btn_out) begin
            count <= {N{1'b0}};
        end else begin
            count <= count + 1'b1;
            if (count == {N{1'b1}})
                btn_out <= btn_sync;
        end
    end
end

endmodule
