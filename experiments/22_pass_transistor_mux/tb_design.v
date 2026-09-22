// Self-checking testbench for mux2to1_behavioral
`timescale 1ns/1ps
module tb_design;
    reg  a, b, sel;
    wire y;
    integer errors;

    mux2to1_behavioral dut(.a(a), .b(b), .sel(sel), .y(y));

    task check(input exp);
        begin
            #10;
            if (y === exp)
                $display("PASS: a=%b b=%b sel=%b -> y=%b", a, b, sel, y);
            else begin
                $display("FAIL: a=%b b=%b sel=%b -> y=%b (expected %b)", a, b, sel, y, exp);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("22_pass_transistor_mux.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        a = 0; b = 1; sel = 0; check(1'b0); // y=a
        a = 0; b = 1; sel = 1; check(1'b1); // y=b
        a = 1; b = 0; sel = 0; check(1'b1); // y=a
        a = 1; b = 0; sel = 1; check(1'b0); // y=b
        a = 1; b = 1; sel = 0; check(1'b1);
        a = 0; b = 0; sel = 1; check(1'b0);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
