// DataPath implementation
module DataPath(
	input	clk, 
	input	rst, 
	input	ir_on_adr, 
	input	pc_on_adr, 
	input	ld_ir, 
	input	ld_ac, 
	input	ld_pc, 
	input	inc_pc, 
	input	clr_pc, 
	input	pass_add, 
	input  [7:0]data_bus_in,
	output [1:0]op_code,
	output [5:0]adr_bus,  
	output [7:0]data_bus_out
);

	wire [5:0] pc_out;
	wire [7:0] ir_out;
	wire [7:0] a_side;
	wire [7:0] alu_out;
	wire [7:0] ac_input;  

    	// Instantiate datapath modules
    	IR  ir (clk, rst,    ld_ir,  data_bus_in[7:0],   ir_out);                           // Instruction Register
    	PC  pc (clk, clr_pc, inc_pc, ld_pc,              ir_out[5:0], pc_out[5:0]);         // Program Counter
    	AC  ac (clk, rst,    ld_ac,  ac_input[7:0],      a_side[7:0]);                      // Accumulator
    	ALU alu(a_side,      {2'b00, ir_out[5:0]},       pass_add,    alu_out[7:0]);        // ALU

    	// Address bus multiplexer
    	assign adr_bus = ir_on_adr ? ir_out[5:0] : (pc_on_adr ? pc_out : 6'b000000);
    	// Extract opcode from instructions
    	assign op_code = ir_out[7:6];
    	
	    // MUX for AC input: LDA uses data_bus_in, ADD uses ALU output
    	assign ac_input = (pass_add) ? alu_out : data_bus_in;
    	// Data bus output: For STA output Accumulator, for others output ALU result
    	assign data_bus_out = (op_code == 2'b10) ? a_side : alu_out;

endmodule