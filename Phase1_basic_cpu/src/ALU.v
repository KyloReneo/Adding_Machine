// ALU implementation
module ALU(
    input [7:0] a_side,
    input [7:0] b_side,
    input pass_add,
    output reg [7:0] data_bus_out
);
    always @(*) begin
        case (pass_add)
            1'b0: data_bus_out = a_side;           // For LDA: pass through memory data
            1'b1: data_bus_out = a_side + b_side;  // For ADD: add AC with immediate
            default: data_bus_out = 8'b00000000;
        endcase
    end
endmodule
