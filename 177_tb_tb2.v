module top_module();
    reg clk = 0;
    always begin
        #5;
        clk = ~clk;
    end
    
    reg in = 0;
    reg[2:0] s = 2;
    wire out;
    q7 dut(clk, in, s, out);
    
    initial begin
        #10;
        s = 6;
        #10;
        in = 1;
        s = 2;
        #10;
        in = 0;
        s = 7;
        #10;
        in = 1;
        s = 0;
        #30;
        in = 0;
    end
endmodule
