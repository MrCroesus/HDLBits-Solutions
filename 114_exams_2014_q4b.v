module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    wire [3:0] R;
    wire clk, E, L, w;
    assign R = SW;
    assign {w, L, E, clk} = KEY;
    MUXDFF dff1(clk, LEDR[3], w, E, R[3], L, LEDR[3]);
    MUXDFF dff2(clk, LEDR[2], LEDR[3], E, R[2], L, LEDR[2]);
    MUXDFF dff3(clk, LEDR[1], LEDR[2], E, R[1], L, LEDR[1]);
    MUXDFF dff4(clk, LEDR[0], LEDR[1], E, R[0], L, LEDR[0]);
endmodule

module MUXDFF (
	input clk,
    input D1, D2, sel1,
    input D3, sel2,
    output Q
);
    wire D;
    assign D = sel2 ? D3 : sel1 ? D2 : D1;
    
    always @(posedge clk) begin
        Q <= D;
    end
endmodule
