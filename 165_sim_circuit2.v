module top_module (
    input a,
    input b,
    input c,
    input d,
    output q );//

    assign q = (a+b+c+d) % 2 == 0; // Fix me

endmodule
