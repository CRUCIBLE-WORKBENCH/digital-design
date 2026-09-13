`timescale 1ns/1ps

module tb_design;

    reg  [9:0] in;
    wire [3:0] bcd;
    wire       valid;
    integer errors;
    integer i;

    bcd_encoder_10bit dut (
        .in(in),
        .bcd(bcd),
        .valid(valid)
    );

    initial begin
        errors = 0;

        for (i = 0; i < 10; i = i + 1) begin
            in = (10'b1 << i);
            #5;
            if (bcd === i[3:0] && valid === 1'b1) begin
                $display("PASS: in=%b -> bcd=%0d valid=%b", in, bcd, valid);
            end else begin
                $display("FAIL: in=%b -> bcd=%0d valid=%b (expected bcd=%0d valid=1)",
                          in, bcd, valid, i);
                errors = errors + 1;
            end
        end

        in = 10'b0000000000;
        #5;
        if (valid === 1'b0) begin
            $display("PASS: in=%b -> valid=%b (all-zero invalid case)", in, valid);
        end else begin
            $display("FAIL: in=%b -> valid=%b (expected valid=0)", in, valid);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end

endmodule
