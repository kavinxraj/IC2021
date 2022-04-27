/*********************************************************/
// MODULE: 
//
// FILE NAME: timer_control_strategy_2.moore.sv 
// VERSION: 0.1
// DATE: 2022-Apr-27 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

//Timed Moore machine with timer control strategy #2
//Part 1: Module Header:----------------------------------

//Part 2: Declarations:-----------------------------------

//Timer related declarations
const logic [7:0] T1 = <value>;
const logic [7:0] T2 = <value>;
...
logic [7:0] t,tmax;

//Part 3: Statements:-------------------------------------

//Timer Strategy #2
always_ff @ ( posedge clk, posedge rst ) begin
	if( rst ) begin
		t <= 0;
	end
	else if ( t < tmax ) begin
		t <= t+1;
	end
	else begin
		t <= 0;
	end
end

//FSM State Register

//FSM Combinational Logic
always_comb begin
	case( pr_state )
		A: begin
			outp1 = <value>;
			outp2 = <value>;
			//...
			tmax = T1-1;
			if( ... and t = tmax ) begin
				nx_state = B;
			end
			else if( ... ) begin
				nx_state = ...;
			end
			else begin
				nx_state = A;
			end
		end
		B: begin
			outp1 = <value>;
			outp2 = <value>;
			//...
			tmax = T2-1;
			if( ... and t = tmax ) begin
				nx_state = C;
			end
			else if( ... ) begin
				nx_state = ...;
			end
			else begin
				nx_state = A;
			end
		end
		C: begin
			...
		end
		...
	endcase
end

//Optional Output register

endmodule
//--------------------------------------------------------
