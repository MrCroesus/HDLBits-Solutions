module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    wire [5:1] enable;
    assign enable[1] = ena && ss[3:0] == 9;
    assign enable[2] = enable[1] && ss[7:4] == 5;
    assign enable[3] = enable[2] && mm[3:0] == 9;
    assign enable[4] = enable[3] && mm[7:4] == 5;
    assign enable[5] = enable[4] && hour[3:0] == 9;
    
    wire [7:0] hour;
    wire hour_reset;
    assign hour_reset = hour[7:4] == 1 && hour[3:0] == 1 && enable[4];
    
    BCD_counter seconds2(clk, reset, ena, 4'd0, 4'd9, ss[3:0]);
    BCD_counter seconds1(clk, reset, enable[1], 4'd0, 4'd5, ss[7:4]);
    BCD_counter minutes2(clk, reset, enable[2], 4'd0, 4'd9, mm[3:0]);
    BCD_counter minutes1(clk, reset, enable[3], 4'd0, 4'd5, mm[7:4]);
    BCD_counter hours2(clk, reset | hour_reset, enable[4], 4'd0, 4'd9, hour[3:0]);
    BCD_counter hours1(clk, reset | hour_reset, enable[5], 4'd0, 4'd1, hour[7:4]);
    
    reg pm_reg = 0;
    always @(posedge clk) begin
        if (hour_reset)
        	pm_reg <= ~pm_reg;
        else
            pm_reg <= pm_reg;
    end
    assign pm = pm_reg;
    assign hh[3:0] = hour == 0 ? 4'd2 : hour[3:0];
    assign hh[7:4] = hour == 0 ? 4'd1 : hour[7:4];
endmodule

module BCD_counter(
    input clk,
    input reset,
    input enable,
    input [3:0] reset_val,
    input [3:0] max_counter,
    output [3:0] counter
);
    always @(posedge clk) begin
        if (reset)
            counter <= reset_val;
        else if (enable)
            if (counter == max_counter)
                counter <= reset_val;
        	else
                counter <= counter + 1'b1;
        else
            counter <= counter; 
    end
endmodule