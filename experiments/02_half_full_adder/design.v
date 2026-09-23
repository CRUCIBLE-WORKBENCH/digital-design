// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/02_half_full_adder/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module half_adder(
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);

    assign sum   = a ^ b;
    assign carry = a & b;

endmodule


module full_adder(
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire carry
);

    wire s1, c1, c2;

    half_adder ha1 (.a(a),  .b(b), .sum(s1), .carry(c1));
    half_adder ha2 (.a(s1), .b(cin), .sum(sum), .carry(c2));

    assign carry = c1 | c2;

endmodule
