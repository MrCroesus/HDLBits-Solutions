module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    parameter A=0, B=1, C=2, D=3;
    
    reg [1:0] state;

    // State transition logic

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            case (state)
                A: state <= in ? B : A;
                B: state <= in ? B : C;
                C: state <= in ? D : A;
                D: state <= in ? B : C;
            endcase
        end
    end

    // Output logic
    assign out = (state == D);

endmodule
