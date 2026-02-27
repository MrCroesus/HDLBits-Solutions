module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input [3:1] r,   // request
    output [3:1] g   // grant
); 
    parameter A=0,B=1,C=2,D=3;
    
    reg [1:0] state;
    
    always @(posedge clk) begin
        if (~resetn) begin
            state <= A;
        end else begin
            case (state)
                A: begin
                    if (r[1]) begin
                        state <= B;
                    end else if (r[2]) begin
                        state <= C;
                    end else if (r[3]) begin
                        state <= D;
                    end
                end
                B: state <= r[1] ? B : A;
                C: state <= r[2] ? C : A;
                D: state <= r[3] ? D : A;
            endcase
        end
    end
    
    assign g = {state == D, state == C, state == B};
endmodule
