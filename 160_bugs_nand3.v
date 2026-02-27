module top_module (input a, input b, input c, output out);//
    reg d = 1;
    reg e = 1;
    wire andout;
    andgate inst1 ( andout, a, b, c, d, e );
    assign out = ~andout;

endmodule
