// 4-bit ALU: opcode selects operation
// 000 ADD, 001 SUB, 010 AND, 011 OR, 100 XOR, 101 NOT(a), 110 SHL, 111 SHR
module alu_4bit(
    input      [3:0] a,
    input      [3:0] b,
    input      [2:0] opcode,
    output reg [3:0] result,
    output           zero
);
    always @(*) begin
        case (opcode)
            3'b000: result = a + b;
            3'b001: result = a - b;
            3'b010: result = a & b;
            3'b011: result = a | b;
            3'b100: result = a ^ b;
            3'b101: result = ~a;
            3'b110: result = a << 1;
            3'b111: result = a >> 1;
            default: result = 4'b0000;
        endcase
    end

    assign zero = (result == 4'b0000);
endmodule
