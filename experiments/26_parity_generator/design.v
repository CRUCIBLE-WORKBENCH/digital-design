// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/26_parity_generator/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

// 8-bit parity generator (parity_type: 0=even, 1=odd) and checker
module parity_generator_8bit(
    input        [7:0] data,
    input              parity_type,
    output             parity_bit
);
    assign parity_bit = parity_type ? ~(^data) : (^data);
endmodule

// Checker: data_with_parity[8:0] = {parity_bit, data[7:0]}, error=1 if mismatch for given type
module parity_checker_8bit(
    input      [8:0] data_with_parity,
    input            parity_type,
    output           error
);
    wire computed = parity_type ? ~(^data_with_parity[7:0]) : (^data_with_parity[7:0]);
    assign error = (computed != data_with_parity[8]);
endmodule
