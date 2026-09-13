`timescale 1ns/1ps

module tb_design;

    reg clk, rst, up_down, en;
    wire [3:0] count;
    integer errors;
    integer i;
    reg [3:0] model;

    fsm_updown_counter dut (
        .clk(clk),
        .rst(rst),
        .up_down(up_down),
        .en(en),
        .count(count)
    );

    always #5 clk = ~clk;

    initial begin
        errors = 0;
        clk = 0;
        rst = 1;
        up_down = 0;
        en = 0;
        @(posedge clk); #1;
        rst = 0;

        if (count === 4'd0)
            $display("PASS: counter reset to 0");
        else begin
            $display("FAIL: counter after reset = %0d (expected 0)", count);
            errors = errors + 1;
        end

        // count up for 5 cycles
        en = 1;
        up_down = 0;
        model = 4'd0;
        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk); #1;
            model = model + 1;
            if (count === model)
                $display("PASS: count up -> %0d", count);
            else begin
                $display("FAIL: count up -> %0d (expected %0d)", count, model);
                errors = errors + 1;
            end
        end

        // switch direction, count down for 5 cycles
        up_down = 1;
        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk); #1;
            model = model - 1;
            if (count === model)
                $display("PASS: count down -> %0d", count);
            else begin
                $display("FAIL: count down -> %0d (expected %0d)", count, model);
                errors = errors + 1;
            end
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
