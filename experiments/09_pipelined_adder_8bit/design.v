module pipelined_adder_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire       cin,
    input  wire       clk,
    output reg  [7:0] sum,
    output reg        cout
);

    reg [7:0] partial_sum_stage;
    reg       partial_cout_stage;

    always @(posedge clk) begin
        {partial_cout_stage, partial_sum_stage} <= a + b + cin;
    end

    always @(posedge clk) begin
        sum  <= partial_sum_stage;
        cout <= partial_cout_stage;
    end

endmodule
