/*********************************************************/
// MODULE: 
//
// FILE NAME: timer_control_strategy_1.melay.sv 
// VERSION: 0.1
// DATE: 2022-Apr-27 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

//Timed Melay machine with Timer Control Strategy #1
//Part 1: Module Header:----------------------------------

//Part 2: Declarations:-----------------------------------

	//FSM related declarations


	//Timer related declarations


//Part 3: Statements:-------------------------------------
	//Timer using Control Strategy #1

	//FSM state register

//FSM Combinational Logic
always_comb begin
	case( pr_state )
		A: begin
			if( ... and t >= T1-1 ) begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = B;
			end
			else if( ... and t >= T1-1 ) begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = ...;
			end
			else begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = A;
			end
		end
		B: begin
			if( ... and t >= T3-1 ) begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = B;
			end
			else if( condition ) begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = ...;
			end
			else begin
				outp1 = <value>;
				outp2 = <value>;
				...
				nx_state = B;
			end
		end
		C: begin
			...
		end
	endcase
end

//Optional Output Register

endmodule
//--------------------------------------------------------
