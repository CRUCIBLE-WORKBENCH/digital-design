// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/04_full_adder_2bit/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module full_adder_1bit (
    input  wire a,
    input  wire b,
    input  wire cin,
    output wire sum,
    output wire cout
);

    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);

endmodule


module full_adder_2bit (
    input  wire [1:0] a,
    input  wire [1:0] b,
    input  wire       cin,
    output wire [1:0] sum,
    output wire        cout
);

    wire c0;

    full_adder_1bit fa0 (
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .cout(c0)
    );

    full_adder_1bit fa1 (
        .a(a[1]),
        .b(b[1]),
        .cin(c0),
        .sum(sum[1]),
        .cout(cout)
    );

endmodule
