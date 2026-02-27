module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    reg [1:0] state;
    
    always @(posedge clk, posedge ~aresetn) begin
        if (~aresetn) begin
            state <= 0;
        end else begin
            case (state)
                0: state <= x ? 1 : 0;
                1: state <= ~x ? 2 : 1;
                2: state <= x ? 1 : 0;
            endcase
        end
    end
                
    assign z = (state == 2) && x;
endmodule
