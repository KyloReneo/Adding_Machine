// Top Module (CPU)
module CPU(
    input   	clk,
    input   	rst,
    input  	[7:0]data_bus_in,
    output 	rd_mem,
    output 	wr_mem,
    output 	[5:0]adr_bus,
    output 	[7:0]data_bus_out
);

    wire  ir_on_adr, pc_on_adr, ld_ir, ld_ac, ld_pc, inc_pc, clr_pc, pass_add;
    wire [1:0] op_code;

    // Instantiate CPU modules
    Controller cu(
        clk, rst, op_code, rd_mem, wr_mem, ir_on_adr, pc_on_adr, ld_ir, ld_ac, ld_pc, inc_pc, clr_pc, pass_add);

    DataPath dp(
        clk, rst, ir_on_adr, pc_on_adr, ld_ir, ld_ac, ld_pc, inc_pc, clr_pc, pass_add, data_bus_in, op_code, adr_bus, data_bus_out);

endmodule