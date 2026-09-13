// Self-checking testbench for mux8to1
`timescale 1ns/1ps
module tb_design;
    reg  [7:0] in;
    reg  [2:0] sel;
    wire       y;
    integer errors, i;

    mux8to1 dut(.in(in), .sel(sel), .y(y));

    initial begin
        errors = 0;
        in = 8'b10110010;

        for (i = 0; i < 8; i = i + 1) begin
            sel = i[2:0];
            #10;
            if (y === in[i]) begin
                $display("PASS: sel=%0d in=%b -> y=%b", sel, in, y);
            end else begin
                $display("FAIL: sel=%0d in=%b -> y=%b (expected %b)", sel, in, y, in[i]);
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
