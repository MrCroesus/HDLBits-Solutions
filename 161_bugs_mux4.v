module top_module (
    input [1:0] sel,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input [7:0] d,
    output [7:0] out  ); //

    wire [7:0] muxout0, muxout1;
    mux2 mux0 ( sel[0],    a,    b, muxout0 );
    mux2 mux1 ( sel[0],    c,    d, muxout1 );
    mux2 mux ( sel[1], muxout0, muxout1,  out );

endmodule
