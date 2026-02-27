module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    wire [2:0] R;
    wire L, clk;
    wire [2:0] Q;
    assign R = SW;
    assign clk = KEY[0];
    assign L = KEY[1];
    assign LEDR = Q;
    
    wire d0, d1, d2;
    assign d0 = L ? R[0] : Q[2];
    assign d1 = L ? R[1] : Q[0];
    assign d2 = L ? R[2] : Q[1] ^ Q[2];
    
    always @(posedge clk) begin
        Q[0] <= d0;
        Q[1] <= d1;
        Q[2] <= d2;
    end
endmodule
