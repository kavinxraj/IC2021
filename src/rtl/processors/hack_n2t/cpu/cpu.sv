/*********************************************************/
// MODULE: 
//
// FILE NAME: cpu.sv 
// VERSION: 0.1
// DATE: 2021-Jun-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module cpu
#(
	parameter DATA_WIDTH = 16,
	parameter ADDRESS_WIDTH = 16,
	parameter INST_WIDTH = 16
)
(
	input clk,
	input rst,
	input [DATA_WIDTH-1:0] data_in,
	input [INST_WIDTH-1:0] instruction_in,
	output logic write_out,
	output logic [ADDRESS_WIDTH-1:0] pc_out,
	output logic [ADDRESS_WIDTH-1:0] address_out,
	output logic [DATA_WIDTH-1:0] data_out
);

//Wires Section
logic fetch2ctrl, execute2ctrl, zr, ng;
logic [DATA_WIDTH-1:0] inst2mux_1, mux_1_to_addr_reg, addr_reg_to_all, d_reg_to_alu, mux_2_to_alu, alu_to_all;
logic jumpctrl;

//Ctrl Wires from Instruction Register
logic op_code;
logic a_ctrl; 
logic c1,c2,c3,c4,c5,c6;
logic d1A, d2M, d3D;
logic j1,j2,j3; 

always_comb begin
	op_code = inst2mux_1[15];
	a_ctrl = inst2mux_1[12];
	{c1,c2,c3,c4,c5,c6} = inst2mux_1[11:6];
	{d1A, d2M, d3D} = inst2mux_1[5:3];
	{j1,j2,j3} = inst2mux_1[2:0];
end

//Instruction or DataOut to A Register : Mux
mux_2x1_16bits mux_1
(
	.a_in(alu_to_all),
	.b_in(inst2mux_1),
	.sel_in( ~op_code&execute2ctrl ),
	.y_out(mux_1_to_addr_reg)
);


//A Register
register
#(
	.DATA_WIDTH(DATA_WIDTH)
)
address_reg
(
	.clk(clk),
	.rst(rst),
	.load( /*(d1A|~op_code)&execute2ctrl*/ (execute2ctrl&d1A&op_code) | (~op_code&execute2ctrl) ),
	.data_in(mux_1_to_addr_reg),
	.data_out(addr_reg_to_all)
);


//D Register
register
#(
	.DATA_WIDTH(DATA_WIDTH)
)
data_reg
(
	.clk(clk),
	.rst(rst),
	.load( d3D&execute2ctrl&op_code ),
	.data_in(alu_to_all),
	.data_out(d_reg_to_alu)
);


//Memory or A Register to ALU input : Mux
mux_2x1_16bits mux_2
(
	.a_in(addr_reg_to_all),
	.b_in(data_in),
	.sel_in( a_ctrl&execute2ctrl&op_code ),
	.y_out(mux_2_to_alu)
);


//ALU
alu
#(
	.DATA_WIDTH(DATA_WIDTH)
)
alu_1
(
	.dataX_in(d_reg_to_alu),
	.dataY_in(mux_2_to_alu),
	.zx( c1&execute2ctrl&op_code ),
	.nx( c2&execute2ctrl&op_code),
	.zy( c3&execute2ctrl&op_code ),
	.ny( c4&execute2ctrl&op_code ),
	.f( c5&execute2ctrl&op_code ),
	.no( c6&execute2ctrl&op_code ),
	.dataZ_out(alu_to_all),
	.zr(zr),
	.ng(ng)
);

//Jump Logic
//always_comb begin
//	case({j1,j2,j3}) 
//		3'b000: jumpctrl = 1'b0;
//		3'b001: jumpctrl = ~ng & ~zr;
//		3'b010: jumpctrl = zr;
//		3'b011: jumpctrl = ~ng & zr;
//		3'b100: jumpctrl = ng;
//		3'b101: jumpctrl = ~zr;
//		3'b110: jumpctrl = ng | zr;
//		3'b111: jumpctrl = 1'b1;
//	endcase
//end
jump_logic jmp_lgc
(
	.ng(ng),
	.zr(zr),
	.j1(j1),
	.j2(j2),
	.j3(j3),
	.jumpctrl(jumpctrl)
);

//Program Counter
program_counter
#(
	.DATA_WIDTH(DATA_WIDTH)
)
pc_reg
(
	.clk(clk),
	.rst(rst),
	.load(jumpctrl&execute2ctrl&op_code),
	.incr( /*~rst&*/execute2ctrl ),//Bug Fix Not a Standard Design
	.pc_in(addr_reg_to_all),
	.pc_out(pc_out)
);


//Missing Component - 1
//Instruction Register
register
#(
	.DATA_WIDTH(DATA_WIDTH)
)
insturction_reg 
(
	.clk(clk),
	.rst(rst),
	.load(fetch2ctrl),
	.data_in(instruction_in),
	.data_out(inst2mux_1)
);

//Missing Component - 2
//Control FSM
control_fsm ctrl_fsm
(
	.clk(clk),
	.rst(rst),
	.fetch(fetch2ctrl),
	.execute(execute2ctrl)
);

//Output Data and Address Logic
always_comb begin
	data_out = alu_to_all;
	address_out = addr_reg_to_all;
	write_out = d2M & execute2ctrl & op_code ;
end

endmodule: cpu
