module top_module (
    input c,
    input d,
    output [3:0] mux_in
); 
    wire [3:0] mux1, mux2;
    assign mux1 = ~c ? 4'b0100 : 4'b0101;
    assign mux2 = ~c ? 4'b0001 : 4'b1001;
    assign mux_in = ~d ? mux1 : mux2;
endmodule
