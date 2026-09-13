// Behavioral traffic light FSM: RED -> GREEN -> YELLOW -> RED

module behavioral_traffic_fsm(clk, rst, red, yellow, green);
    input  clk, rst;
    output reg red, yellow, green;

    parameter S_RED    = 2'b00;
    parameter S_GREEN  = 2'b01;
    parameter S_YELLOW = 2'b10;

    parameter RED_TIME    = 4;
    parameter GREEN_TIME  = 3;
    parameter YELLOW_TIME = 2;

    reg [1:0] state;
    reg [3:0] count;

    always @(posedge clk) begin
        if (rst) begin
            state <= S_RED;
            count <= 0;
        end else begin
            case (state)
                S_RED: begin
                    if (count == RED_TIME - 1) begin
                        state <= S_GREEN;
                        count <= 0;
                    end else
                        count <= count + 1;
                end
                S_GREEN: begin
                    if (count == GREEN_TIME - 1) begin
                        state <= S_YELLOW;
                        count <= 0;
                    end else
                        count <= count + 1;
                end
                S_YELLOW: begin
                    if (count == YELLOW_TIME - 1) begin
                        state <= S_RED;
                        count <= 0;
                    end else
                        count <= count + 1;
                end
                default: begin
                    state <= S_RED;
                    count <= 0;
                end
            endcase
        end
    end

    always @(*) begin
        red    = (state == S_RED);
        green  = (state == S_GREEN);
        yellow = (state == S_YELLOW);
    end
endmodule
