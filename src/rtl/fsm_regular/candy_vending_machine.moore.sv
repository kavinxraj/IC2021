/*********************************************************/
// MODULE: 
//
// FILE NAME: candy_vending_machine.moore.sv 
// VERSION: 0.1
// DATE: 2022-Apr-25 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module candy_vending_machine
(
	input clk, rst,
	input rs_10_in,
	input rs_05_in,
	input rs_02_in,
	input rs_01_in,
	//input rs_10_out, // will not happen
	input rs_05_out,
	input rs_02_out,
	input rs_01_out,

	output logic give_rs_05,
	output logic give_rs_02,
	output logic give_rs_01,
	output logic give_candy
);

typedef enum logic [3:0] {
	ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE,
	TEN, ELEVEN, TWELEVE, THIRTEEN, FOURTEEN
} state_t;

state_t pr_state, nx_state;

//local to combine
logic [3:0] rs_in;
logic [2:0] rs_out;
logic [3:0] give;

always_comb begin
	rs_in = { rs_01_in, rs_02_in, rs_05_in, rs_10_in };		//rs_in  1 2 5 10
	rs_out = { rs_01_out, rs_02_out, rs_05_out };			//rs_out 1 2 5
	{ give_rs_01, give_rs_02, give_rs_05, give_candy } = give;	//give	 1 2 5 candy
end

//state reg logic
always_ff @ ( posedge clk, negedge rst ) begin : STATE_REG
	if( ~rst ) begin
		pr_state <= ZERO;
	end
	else begin
		pr_state <= nx_state;
	end
end

//output & nx_state logic
always_comb begin
	case(pr_state)
		ZERO: begin
			give = 4'b0;
			case(rs_in)
				4'b0000 : begin nx_state = ZERO; end
				4'b1000 : begin nx_state = ONE; end
				4'b0100 : begin nx_state = TWO; end
				4'b0010 : begin nx_state = FIVE; end
				4'b0001 : begin nx_state = TEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		ONE: begin
			give = 4'b0;
			case(rs_in)
				4'b0000 : begin nx_state = ONE; end
				4'b1000 : begin nx_state = TWO; end
				4'b0100 : begin nx_state = THREE; end
				4'b0010 : begin nx_state = SIX; end
				4'b0001 : begin nx_state = ELEVEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		TWO: begin
			give = 4'b0;
			case(rs_in)
				4'b0000 : begin nx_state = TWO; end
				4'b1000 : begin nx_state = THREE; end
				4'b0100 : begin nx_state = FOUR; end
				4'b0010 : begin nx_state = SEVEN; end
				4'b0001 : begin nx_state = TWELEVE; end
				default : begin nx_state = ZERO; end
			endcase
		end
		THREE: begin
			give = 4'b0;
			case(rs_in)
				4'b0000 : begin nx_state = THREE; end
				4'b1000 : begin nx_state = FOUR; end
				4'b0100 : begin nx_state = FIVE; end
				4'b0010 : begin nx_state = EIGHT; end
				4'b0001 : begin nx_state = THIRTEEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		FOUR: begin
			give = 4'b0;
			case(rs_in)
				4'b0000 : begin nx_state = FOUR; end
				4'b1000 : begin nx_state = FIVE; end
				4'b0100 : begin nx_state = SIX; end
				4'b0010 : begin nx_state = NINE; end
				4'b0001 : begin nx_state = FOURTEEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		FIVE: begin
			give = 4'b0001;
			nx_state = ZERO;
			//case(rs_in)
			//	4'b0000 : begin nx_state = FIVE; end
			//	4'b1000 : begin nx_state = FOUR; end
			//	4'b0100 : begin nx_state = FIVE; end
			//	4'b0010 : begin nx_state = EIGHT; end
			//	4'b0001 : begin nx_state = THIRTEEN; end
			//	default : begin nx_state = ZERO; end
			//endcase
		end
		SIX: begin
			give = 4'b1000;
			case(rs_out)
				3'b000 : begin nx_state = SIX; end
				3'b100 : begin nx_state = FIVE; end
				default : begin nx_state = ZERO; end
			endcase
		end
		SEVEN: begin
			give = 4'b0100;
			case(rs_out)
				3'b000 : begin nx_state = SEVEN; end
				3'b010 : begin nx_state = FIVE; end
				default : begin nx_state = ZERO; end
			endcase
		end
		EIGHT: begin
			give = 4'b1000;
			case(rs_out)
				3'b000 : begin nx_state = EIGHT; end
				3'b100 : begin nx_state = SEVEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		NINE: begin
			give = 4'b0100;
			case(rs_out)
				3'b000 : begin nx_state = NINE; end
				3'b010 : begin nx_state = SEVEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		TEN: begin
			give = 4'b0010;
			case(rs_out)
				3'b000 : begin nx_state = TEN; end
				3'b001 : begin nx_state = FIVE; end
				default : begin nx_state = ZERO; end
			endcase
		end
		ELEVEN: begin
			give = 4'b0010;
			case(rs_out)
				3'b000 : begin nx_state = ELEVEN; end
				3'b001 : begin nx_state = SIX; end
				default : begin nx_state = ZERO; end
			endcase
		end
		TWELEVE: begin
			give = 4'b0010;
			case(rs_out)
				3'b000 : begin nx_state = TWELEVE; end
				3'b001 : begin nx_state = SEVEN; end
				default : begin nx_state = ZERO; end
			endcase
		end
		THIRTEEN: begin
			give = 4'b0010;
			case(rs_out)
				3'b000 : begin nx_state = THIRTEEN; end
				3'b001 : begin nx_state = EIGHT; end
				default : begin nx_state = ZERO; end
			endcase
		end
		FOURTEEN: begin
			give = 4'b0010;
			case(rs_out)
				3'b000 : begin nx_state = FOURTEEN; end
				3'b001 : begin nx_state = NINE; end
				default : begin nx_state = ZERO; end
			endcase
		end
		default: begin
			give = 4'b0;
		end
	endcase
end

endmodule : candy_vending_machine
