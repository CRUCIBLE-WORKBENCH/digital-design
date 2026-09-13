module fsm_updown_counter (
    input  wire       clk,
    input  wire       rst,
    input  wire       up_down,
    input  wire       en,
    output reg  [3:0] count
);

    localparam COUNT_UP   = 1'b0;
    localparam COUNT_DOWN = 1'b1;

    wire state;

    assign state = up_down;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 4'd0;
        end else if (en) begin
            case (state)
                COUNT_UP:   count <= count + 4'd1;
                COUNT_DOWN: count <= count - 4'd1;
                default:    count <= count;
            endcase
        end
    end

endmodule
