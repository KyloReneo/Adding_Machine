// Instruction Register implementation
module IR(
    input            clk,
    input            rst,
    input            ld_ir,
    input      [7:0] data_bus_in,
    output reg [7:0] ir_out
);

    always @(posedge clk) begin
        if (rst) begin
            ir_out <= 8'b00000000;
        end else if (ld_ir) begin
            ir_out <= data_bus_in;
        end
    end
endmodule