// Controller implementation
// 4 States contoller state definition
`define Reset     2'b00
`define Fetch     2'b01
`define WaitState 2'b10
`define Execute   2'b11

module Controller (
	input      clk, 
	input      rst, 
	input [1:0]op_code, 
	output reg rd_mem, 
	output reg wr_mem, 
	output reg ir_on_adr, 
	output reg pc_on_adr, 
	output reg ld_ir, 
	output reg ld_ac, 
	output reg ld_pc, 
	output reg inc_pc, 
	output reg clr_pc, 
	output reg pass_add );

	reg [1:0] present_state, next_state;

    	always @(posedge clk) begin
        	if (rst)
            		present_state <= `Reset;
       		else
           		present_state <= next_state;
    		end

    	always @(present_state, op_code) begin
        	// Default values
        	rd_mem = 1'b0; wr_mem   = 1'b0; ir_on_adr = 1'b0; pc_on_adr = 1'b0; 
        	ld_ir  = 1'b0; ld_ac    = 1'b0; ld_pc     = 1'b0; inc_pc = 1'b0; 
        	clr_pc = 1'b0; pass_add = 1'b0;
        
        	case(present_state)
            	`Reset: begin
                	next_state = `Fetch; 
                	clr_pc     = 1'b1;
            	end
            	`Fetch: begin
                	next_state = `WaitState; 
                	pc_on_adr  = 1'b1; 
                	rd_mem     = 1'b1; 
                	ld_ir      = 1'b1; 
                	inc_pc     = 1'b1;
            	end
            	`WaitState: begin
                	next_state = `Execute;
            	end
            	`Execute: begin
                	next_state = `Fetch;
                 case(op_code)
                    	2'b01: begin  // LDA
                        	ir_on_adr = 1'b1; 
                        	rd_mem    = 1'b1; 
                        	ld_ac     = 1'b1;
                    end
                    	2'b10: begin  // STA
                        	ir_on_adr = 1'b1; 
                        	pass_add  = 1'b0; 
                        	wr_mem    = 1'b1;
                    end
                    	2'b11: begin  // JMP
                        	ld_pc     = 1'b1;
                    end
                    	2'b00: begin  // ADD
                        	pass_add  = 1'b1; 
                        	ld_ac     = 1'b1;
                    end
                endcase
            end
        endcase
    end

endmodule