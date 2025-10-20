// Program Counter implementation
module PC(
    input      clk,
    input      clr_pc,    
    input      inc_pc, 
    input      ld_pc, 
    input      [5:0] jump_addr, 
    output reg [5:0] pc_out
);

    always @(posedge clk) begin
        if (clr_pc) begin
            pc_out <= 6'b000000;
        end else if (ld_pc) begin
            pc_out <= jump_addr;
        end else if (inc_pc) begin
            pc_out <= pc_out + 1;
        end
    end
endmodule
