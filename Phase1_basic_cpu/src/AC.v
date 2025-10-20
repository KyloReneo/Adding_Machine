// Accumulator implementation
module AC(
    input      clk, 
    input      rst,    
    input      ld_ac,  
    input      [7:0] data_bus_in,   
    output reg [7:0] a_side
);

    always @(posedge clk) begin
        if (rst) begin
            a_side <= 8'b00000000;
        end else if (ld_ac) begin
            a_side <= data_bus_in;
        end
    end
endmodule
