`timescale 1ns/1ps

module tb_design;

    reg [3:0] in;
    reg [1:0] sel;
    wire y;
    reg exp_y;

    integer i;
    integer errors;

    mux4to1 dut (.in(in), .sel(sel), .y(y));

    initial begin
        errors = 0;
        in = 4'b1010;

        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #5;
            exp_y = in[sel];
            if (y === exp_y)
                $display("PASS: in=%b sel=%b -> y=%b (expected %b)", in, sel, y, exp_y);
            else begin
                $display("FAIL: in=%b sel=%b -> y=%b (expected %b)", in, sel, y, exp_y);
                errors = errors + 1;
            end
        end

        in = 4'b0110;
        for (i = 0; i < 4; i = i + 1) begin
            sel = i[1:0];
            #5;
            exp_y = in[sel];
            if (y === exp_y)
                $display("PASS: in=%b sel=%b -> y=%b (expected %b)", in, sel, y, exp_y);
            else begin
                $display("FAIL: in=%b sel=%b -> y=%b (expected %b)", in, sel, y, exp_y);
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
