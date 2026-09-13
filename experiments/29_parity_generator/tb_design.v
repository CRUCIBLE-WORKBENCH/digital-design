// Self-checking testbench for parity_generator_8bit and parity_checker_8bit
`timescale 1ns/1ps
module tb_design;
    reg  [7:0] data;
    reg        parity_type;
    wire       parity_bit;
    integer errors;

    reg  [8:0] data_with_parity;
    wire       error;

    parity_generator_8bit gen(.data(data), .parity_type(parity_type), .parity_bit(parity_bit));
    parity_checker_8bit   chk(.data_with_parity(data_with_parity), .parity_type(parity_type), .error(error));

    task check_gen(input exp);
        begin
            #10;
            if (parity_bit === exp)
                $display("PASS: GEN data=%b type=%b -> parity_bit=%b", data, parity_type, parity_bit);
            else begin
                $display("FAIL: GEN data=%b type=%b -> parity_bit=%b (expected %b)", data, parity_type, parity_bit, exp);
                errors = errors + 1;
            end
        end
    endtask

    task check_chk(input exp);
        begin
            #10;
            if (error === exp)
                $display("PASS: CHK data_with_parity=%b type=%b -> error=%b", data_with_parity, parity_type, error);
            else begin
                $display("FAIL: CHK data_with_parity=%b type=%b -> error=%b (expected %b)", data_with_parity, parity_type, error, exp);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;

        // Even parity generation
        data = 8'b11000000; parity_type = 0; check_gen(1'b0); // two 1s -> even parity bit 0
        data = 8'b11100000; parity_type = 0; check_gen(1'b1); // three 1s -> parity bit 1

        // Odd parity generation
        data = 8'b11000000; parity_type = 1; check_gen(1'b1);
        data = 8'b11100000; parity_type = 1; check_gen(1'b0);

        // Checker: correct even parity, no error
        data_with_parity = {1'b0, 8'b11000000}; parity_type = 0; check_chk(1'b0);
        // Checker: corrupted data bit, error expected
        data_with_parity = {1'b0, 8'b11000001}; parity_type = 0; check_chk(1'b1);
        // Checker: correct odd parity, no error
        data_with_parity = {1'b1, 8'b11000000}; parity_type = 1; check_chk(1'b0);
        // Checker: corrupted parity bit, error expected
        data_with_parity = {1'b0, 8'b11000000}; parity_type = 1; check_chk(1'b1);

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
