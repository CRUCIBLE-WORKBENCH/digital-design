// Self-checking testbench for behavioral_traffic_fsm

module tb_design;
    reg clk, rst;
    wire red, yellow, green;
    integer errors, i;
    integer seen_state, prev_state;
    integer transitions;

    // 0=RED 1=GREEN 2=YELLOW
    behavioral_traffic_fsm dut(.clk(clk), .rst(rst), .red(red), .yellow(yellow), .green(green));

    always #5 clk = ~clk;

    function integer decode_state(input dummy);
        begin
            if (red)         decode_state = 0;
            else if (green)  decode_state = 1;
            else if (yellow) decode_state = 2;
            else             decode_state = -1;
        end
    endfunction

    task check_one_hot;
        begin
            if (red + green + yellow == 1)
                $display("PASS: one-hot outputs red=%b green=%b yellow=%b", red, green, yellow);
            else begin
                $display("FAIL: not one-hot red=%b green=%b yellow=%b", red, green, yellow);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        errors = 0;
        transitions = 0;
        clk = 0; rst = 1;
        @(posedge clk); #1;
        check_one_hot;
        if (decode_state(0) !== 0) begin
            $display("FAIL: after reset expected RED, got state=%0d", decode_state(0));
            errors = errors + 1;
        end else
            $display("PASS: after reset state=RED");

        rst = 0;
        prev_state = decode_state(0);

        // Run enough cycles to observe at least two full RED->GREEN->YELLOW->RED cycles
        for (i = 0; i < 25; i = i + 1) begin
            @(posedge clk); #1;
            check_one_hot;
            seen_state = decode_state(0);
            if (seen_state !== prev_state) begin
                // valid transitions: RED->GREEN, GREEN->YELLOW, YELLOW->RED
                if ((prev_state == 0 && seen_state == 1) ||
                    (prev_state == 1 && seen_state == 2) ||
                    (prev_state == 2 && seen_state == 0)) begin
                    $display("PASS: transition %0d -> %0d", prev_state, seen_state);
                    transitions = transitions + 1;
                end else begin
                    $display("FAIL: illegal transition %0d -> %0d", prev_state, seen_state);
                    errors = errors + 1;
                end
                prev_state = seen_state;
            end
        end

        if (transitions >= 6)
            $display("PASS: observed %0d valid state transitions (full cycles covered)", transitions);
        else begin
            $display("FAIL: only observed %0d valid state transitions", transitions);
            errors = errors + 1;
        end

        if (errors == 0)
            $display("SUMMARY: ALL TESTS PASSED");
        else
            $display("SUMMARY: %0d TEST(S) FAILED", errors);

        $finish;
    end
endmodule
