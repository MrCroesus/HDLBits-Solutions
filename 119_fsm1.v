module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=0, B=1; 
    reg state, next_state;

    always @(*) begin    // This is a combinational always block
        // State transition logic
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
        if (areset) begin
            state <= B;
        end else begin
            case(state)
                A: begin
                    if (in) begin
                        state <= A;
                    end else begin
                        state <= B;
                    end
                end
                B: begin
                    if (in) begin
                        state <= B;
                    end else begin
                        state <= A;
                    end
                end
            endcase
        end
    end

    // Output logic
    assign out = (state == B);

endmodule
