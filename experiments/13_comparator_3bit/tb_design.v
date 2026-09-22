`timescale 1ns/1ps

module tb_design;

    reg  [2:0] a, b;
    wire gt, eq, lt;
    integer errors;

    comparator_3bit dut (
        .a(a),
        .b(b),
        .gt(gt),
        .eq(eq),
        .lt(lt)
    );

    task check;
        input [2:0] ta, tb;
        begin
            a = ta;
            b = tb;
            #5;
            if (gt === (ta > tb) && eq === (ta == tb) && lt === (ta < tb)) begin
                $display("PASS: a=%0d b=%0d -> gt=%b eq=%b lt=%b", ta, tb, gt, eq, lt);
            end else begin
                $display("FAIL: a=%0d b=%0d -> gt=%b eq=%b lt=%b (expected gt=%b eq=%b lt=%b)",
                          ta, tb, gt, eq, lt, (ta > tb), (ta == tb), (ta < tb));
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        $dumpfile("13_comparator_3bit.vcd");
        $dumpvars(0, tb_design);

        errors = 0;

        check(3'd5, 3'd2); // gt
        check(3'd2, 3'd5); // lt
        check(3'd4, 3'd4); // eq
        check(3'd0, 3'd0); // eq boundary
        check(3'd7, 3'd0); // gt max
        check(3'd0, 3'd7); // lt max
        check(3'd7, 3'd7); // eq max
        check(3'd3, 3'd6); // lt

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
