/*********************************************************/
// MODULE: 
//
// FILE NAME: melay.template.sv 
// VERSION: 0.1
// DATE: 2022-Feb-15 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: template for melay type regular fsm
//		Referred from FSM in Hardware Book
//
/*********************************************************/

//Part-1 : Module Header : ................................
module module_name
#(parameter
	param1 = <value>,
	param2 = <value>
)
(
	input logic clk, rst, ...
	input logic [7:0] inp1, inp2, ...
	output logic [7:0] oup1, oup2, ...
);

//Part-2 : Declarations : .................................

//FSM state type
typedef enum logic [2:0] { A, B, C, ...} state_t;
state_t present_state, next_state;

//Part-3 : Statements : ...................................

//FSM state register
always_ff @( posedge clk, posedge rst ) begin
	if( rst ) begin
		present_state <= A;
	end
	else begin
		present_state <= next_state;
	end
end

//FSM Combinational Logic
always_comb begin
	case( present_state )
		A: begin
			if( condition ) begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= B;
			end
			else if ( condition ) begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= B;
			end
			else begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= B;
			end
		end
		B: begin
			if( condition ) begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= C;
			end
			else if ( condition ) begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= C;
			end
			else begin
				oup1 <= <value>;
				oup2 <= <value>;
				//...
				next_state <= C;
			end
		end
		C: begin
			//.....
		end
end

//Optional Output Register
always_ff @( posedge clk, posedge rst ) begin
	if( rst ) begin		//rst may be not required
		new_oup1 <= ...;
		new_oup2 <= ...;
	end
	else begin
		new_oup1 <= oup1;
		new_oup2 <= oup2;
	end
end

endmodule
//---------------------------------------------------------
