/*********************************************************/
// MODULE: 
//
// FILE NAME: cpu_tb.sv 
// VERSION: 0.1
// DATE: 2021-Jun-09 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module cpu_tb;

parameter DATA_WIDTH = 16;
parameter ADDRESS_WIDTH = 16;
parameter INST_WIDTH = DATA_WIDTH;
parameter SIZE = 6 /*** ADDRESS_WIDTH*/;

logic clk;
logic rst;
logic [DATA_WIDTH-1:0] data_in;
logic [INST_WIDTH-1:0] instruction_in;
logic write_out;
logic [ADDRESS_WIDTH-1:0] pc_out;
logic [ADDRESS_WIDTH-1:0] address_out;
logic [DATA_WIDTH-1:0] data_out;

logic [DATA_WIDTH-1:0] rom [0:SIZE-1];

cpu
#(
	.DATA_WIDTH( DATA_WIDTH ),
	.ADDRESS_WIDTH( ADDRESS_WIDTH ),
	.INST_WIDTH( INST_WIDTH )
)
dut
(
	.clk( clk ),
	.rst( rst ),
	.data_in( data_in ),
	.instruction_in( instruction_in ),
	.write_out( write_out ),
	.pc_out( pc_out ),
	.address_out( address_out ),
	.data_out( data_out )
);

initial begin
	$monitor($time,"\nRST = %b\nDATA_IN = %h\nINST_IN = %h\nWRITE = %b\nPC = %h\nADDR = %h\nDATA_OUT = %h",rst, data_in, instruction_in, write_out, pc_out, address_out, data_out); 
	$dumpfile("cpu.vcd");
	$dumpvars(1,dut);
	//$fsdbDumpfile( "cpu.fsdb" ); // vcs fsdm dump
	//$fsdbDumpvars( 0, dut );
	#200 $finish;
end

initial begin
	rom = '{
		16'b0000000000000010,
		16'b1110110000001000,
		16'b0000000000000011,
		16'b1110000010001000,
		16'b0000000000000000,
		16'b1110001100010000
	};
end

initial begin
	rst = 1'b1; #20

	rst = 1'b0;
	data_in = 16'hffff;
end

always @ (pc_out) begin
	instruction_in = rom[pc_out];
end

initial begin
	clk = 1'b0;
	forever #5 clk = ~clk;
end

endmodule: cpu_tb
