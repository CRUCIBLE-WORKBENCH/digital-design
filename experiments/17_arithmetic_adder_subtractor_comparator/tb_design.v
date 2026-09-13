`timescale 1ns/1ps

module tb_design;
    reg  [3:0] a, b;
    reg  [1:0] mode;
    wire [3:0] result;
    wire       cout, gt, eq, lt;

    integer errors;

    arithmetic_unit_4bit u_dut(
        .a(a), .b(b), .mode(mode),
        .result(result), .cout(cout),
        .gt(gt), .eq(eq), .lt(lt)
    );

    task check;
        input [3:0] t_a, t_b;
        input [1:0] t_mode;
        input [3:0] exp_result;
        input       exp_cout;
        input       exp_gt, exp_eq, exp_lt;
        begin
            a = t_a; b = t_b; mode = t_mode;
            #1;
            if (result !== exp_result || cout !== exp_cout ||
                gt !== exp_gt || eq !== exp_eq || lt !== exp_lt) begin
                $display("FAIL: a=%d b=%d mode=%b result=%d(exp %d) cout=%b(exp %b) gt=%b eq=%b lt=%b (exp %b %b %b)",
                          t_a, t_b, t_mode, result, exp_result, cout, exp_cout, gt, eq, lt, exp_gt, exp_eq, exp_lt);
                errors = errors + 1;
            end else begin
                $display("PASS: a=%d b=%d mode=%b result=%d cout=%b gt=%b eq=%b lt=%b",
                          t_a, t_b, t_mode, result, cout, gt, eq, lt);
            end
        end
    endtask

    initial begin
        errors = 0;

        // Addition tests (mode=00)
        check(4'd3, 4'd4, 2'b00, 4'd7, 1'b0, 1'b0, 1'b0, 1'b1);
        check(4'd8, 4'd9, 2'b00, 4'd1, 1'b1, 1'b0, 1'b0, 1'b1); // 17 -> carry
        check(4'd0, 4'd0, 2'b00, 4'd0, 1'b0, 1'b0, 1'b1, 1'b0);
        check(4'd15, 4'd1, 2'b00, 4'd0, 1'b1, 1'b1, 1'b0, 1'b0);

        // Subtraction tests (mode=01)
        check(4'd9, 4'd4, 2'b01, 4'd5, 1'b0, 1'b1, 1'b0, 1'b0);
        check(4'd4, 4'd9, 2'b01, 4'd11, 1'b1, 1'b0, 1'b0, 1'b1); // borrow, 4-9=-5 -> 11 with borrow
        check(4'd5, 4'd5, 2'b01, 4'd0, 1'b0, 1'b0, 1'b1, 1'b0);

        // Comparator standalone checks (across modes, comparator always active)
        check(4'd10, 4'd3, 2'b00, 4'd13, 1'b0, 1'b1, 1'b0, 1'b0);
        check(4'd3, 4'd10, 2'b01, 4'd9, 1'b1, 1'b0, 1'b0, 1'b1);
        check(4'd7, 4'd7, 2'b01, 4'd0, 1'b0, 1'b0, 1'b1, 1'b0);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
