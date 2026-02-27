module top_module (
    input clock,
    input a,
    output p,
    output q );
    
    reg after_negedge;
    always @(negedge clock) begin
        after_negedge <= a;
    end
    assign p = clock ? a : after_negedge;
    assign q = after_negedge;
endmodule
