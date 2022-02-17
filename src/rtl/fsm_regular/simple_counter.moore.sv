/*********************************************************/
// MODULE: 
//
// FILE NAME: simple_counter.moore.sv 
// VERSION: 0.1
// DATE: 2022-Feb-17 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: a counter using the moore template
//		not a useful way to code a counter
//		but helps to understand the moore template
//
/*********************************************************/

//Module Header : .........................................
module counter
(
	input up, ena, clk, rst,
	output logic [2:0] outp
);

//Declarations : ..........................................

//FSM State Type : 
typedef enum logic [2:0] {
	one,
	two,
	three,
	four,
	five
} state_t;

state_t pr_state, nx_state;

//Statements : ............................................

//FSM State Register : 
always_ff @ ( posedge clk, posedge rst ) begin
	if ( rst ) begin
		pr_state <= one;
	end
	else begin
		pr_state <= nx_state;
	end
end

//FSM Combitional Logic : 
always_comb begin
	case ( pr_state )
		one: begin
			outp <= 1;
			if ( ena ) begin
				if ( up ) begin
					nx_state <= two;
				end
				else begin
					nx_state <= five;
				end
			end
		end
		two: begin
			outp <= 2;
			if ( ena ) begin
				if ( up ) begin
					nx_state <= three;
				end
				else begin
					nx_state <= one;
				end
			end
		end
		three: begin
			outp <= 3;
			if ( ena ) begin
				if ( up ) begin
					nx_state <= four;
				end
				else begin
					nx_state <= two;
				end
			end
		end
		four: begin
			outp <= 4;
			if ( ena ) begin
				if ( up ) begin
					nx_state <= five;
				end
				else begin
					nx_state <= three;
				end
			end
		end
		five: begin
			outp <= 5;
			if ( ena ) begin
				if ( up ) begin
					nx_state <= one;
				end
				else begin
					nx_state <= four;
				end
			end
		end
	endcase
end

endmodule
//.........................................................
