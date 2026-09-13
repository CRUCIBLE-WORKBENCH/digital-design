// 1-to-8 demultiplexer and 8x4 ROM

module demux_1to8(in, sel, out);
    input        in;
    input  [2:0] sel;
    output [7:0] out;

    assign out = in ? (8'b1 << sel) : 8'b0;
endmodule

module rom_8x4(addr, data);
    input  [2:0] addr;
    output [3:0] data;

    reg [3:0] mem [0:7];

    initial begin
        mem[0] = 4'h1;
        mem[1] = 4'h3;
        mem[2] = 4'h5;
        mem[3] = 4'h7;
        mem[4] = 4'h9;
        mem[5] = 4'hB;
        mem[6] = 4'hD;
        mem[7] = 4'hF;
    end

    assign data = mem[addr];
endmodule
