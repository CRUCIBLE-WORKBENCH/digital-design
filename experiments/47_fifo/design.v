// ===============================================================================
// Ignytion IO - CRUCIBLE CORE
// Copyright (c) 2026 Ignytion IO. All rights reserved.
// Author      : IGNYTION_TECH
// File        : experiments/47_fifo/design.v
// Created     : 2026-09-23
// Description : Digital design experiment source, configuration, or documentation file.
// ===============================================================================

module fifo #(
    parameter DEPTH = 8,
    parameter WIDTH = 8
) (
    input clk,
    input rst,
    input wr_en,
    input rd_en,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout,
    output full,
    output empty
);

localparam PTR_W = 3; // log2(DEPTH)

reg [WIDTH-1:0] mem [0:DEPTH-1];
reg [PTR_W-1:0] wr_ptr, rd_ptr;
reg [PTR_W:0] count;

assign full  = (count == DEPTH);
assign empty = (count == 0);

always @(posedge clk) begin
    if (rst) begin
        wr_ptr <= {PTR_W{1'b0}};
        rd_ptr <= {PTR_W{1'b0}};
        count  <= {(PTR_W+1){1'b0}};
        dout   <= {WIDTH{1'b0}};
    end else begin
        if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1'b1;
        end

        if (rd_en && !empty) begin
            dout <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1'b1;
        end

        case ({wr_en && !full, rd_en && !empty})
            2'b10: count <= count + 1'b1;
            2'b01: count <= count - 1'b1;
            default: count <= count;
        endcase
    end
end

endmodule
