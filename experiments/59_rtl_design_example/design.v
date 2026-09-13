// Simple 2-way traffic light controller FSM
// States: NS_GREEN (long), NS_YELLOW (short), EW_GREEN (long), EW_YELLOW (short)
module rtl_traffic_controller(
    input clk, rst,
    output ns_red, ns_green,
    output ew_red, ew_green
);
    localparam NS_GREEN  = 2'd0;
    localparam NS_YELLOW = 2'd1;
    localparam EW_GREEN  = 2'd2;
    localparam EW_YELLOW = 2'd3;

    localparam GREEN_TIME  = 4; // cycles
    localparam YELLOW_TIME = 2; // cycles

    reg [1:0] state;
    reg [3:0] timer;

    always @(posedge clk) begin
        if (rst) begin
            state <= NS_GREEN;
            timer <= 4'd0;
        end else begin
            case (state)
                NS_GREEN: begin
                    if (timer == GREEN_TIME-1) begin
                        state <= NS_YELLOW;
                        timer <= 4'd0;
                    end else
                        timer <= timer + 4'd1;
                end
                NS_YELLOW: begin
                    if (timer == YELLOW_TIME-1) begin
                        state <= EW_GREEN;
                        timer <= 4'd0;
                    end else
                        timer <= timer + 4'd1;
                end
                EW_GREEN: begin
                    if (timer == GREEN_TIME-1) begin
                        state <= EW_YELLOW;
                        timer <= 4'd0;
                    end else
                        timer <= timer + 4'd1;
                end
                EW_YELLOW: begin
                    if (timer == YELLOW_TIME-1) begin
                        state <= NS_GREEN;
                        timer <= 4'd0;
                    end else
                        timer <= timer + 4'd1;
                end
                default: begin
                    state <= NS_GREEN;
                    timer <= 4'd0;
                end
            endcase
        end
    end

    // ns_green only in NS_GREEN; ns_red otherwise (yellow treated as red for ns in this simple model except own yellow)
    assign ns_green = (state == NS_GREEN);
    assign ns_red   = ~(state == NS_GREEN) & ~(state == NS_YELLOW);
    assign ew_green = (state == EW_GREEN);
    assign ew_red   = ~(state == EW_GREEN) & ~(state == EW_YELLOW);
endmodule
