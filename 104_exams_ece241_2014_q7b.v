module top_module (
    input clk,
    input reset,
    output OneHertz,
    output [2:0] c_enable
); //
    reg [3:0] HundredHertz = 0;
    reg [3:0] TenHertz = 0;
    reg [3:0] Hertz = 0;
    
    assign c_enable[0] = 1;
    assign c_enable[1] = (HundredHertz == 9);
    assign c_enable[2] = (TenHertz == 9 && HundredHertz == 9);
    
    assign OneHertz = (Hertz == 9 && TenHertz == 9 && HundredHertz == 9);
    
    bcdcount counter0 (clk, reset, c_enable[0], HundredHertz);
    bcdcount counter1 (clk, reset, c_enable[1], TenHertz);
    bcdcount counter2 (clk, reset, c_enable[2], Hertz);

endmodule
