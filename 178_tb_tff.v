module top_module ();
    reg clk = 0;
    always begin
        #5;
        clk = ~clk;
    end
    
    reg reset = 0;
    reg t = 0;
    wire q;
    tff dut(clk, reset, t, q);
    
    initial begin
        #10;
        reset = 1;
        #10;
        reset = 0;
        t = 1;
    end
endmodule
