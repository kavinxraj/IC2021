/*********************************************************/
// MODULE: 
//
// FILE NAME: garage_door_controller.moore.sv 
// VERSION: 0.1
// DATE: 2022-Feb-18 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

//Module Header : .........................................

module garage_door_controller
(
	input logic remote, sensor1, sensor2, clk, rst,
	output logic [1:0] control
);

//Declarations : ..........................................

//FSM State Type : 
typedef enum logic [2:0] {
	closed1,
	closed2,
	opening1,
	opening2,
	open1,
	open2,
	closing1,
	closing2
} state_t;

state_t pr_state, nx_state;

//Statements : ............................................

//FSM State Register
always_ff @ ( posedge clk, posedge rst ) begin
	if( rst ) begin
		pr_state <= closed1;
	end
	else begin
		pr_state <= nx_state;
	end
end

//FSM Combinational Logic 
always_comb begin
	case ( pr_state )
		closed1: begin
			control <= 2'b0x;
			if( ~remote ) begin
				nx_state <= closed2;
			end
			else begin
				nx_state <= closed1;
			end
		end
		closed2: begin
			control <= 2'b0x;
			if( remote ) begin
				nx_state <= opening1;
			end
			else begin
				nx_state <= closed2;
			end
		end
		opening1: begin
			control <= 2'b10;
			if( sensor1 ) begin
				nx_state <= open1;
			end
			else if ( ~remote ) begin
				nx_state <= opening2;
			end
			else begin
				nx_state <= opening1;
			end
		end
		opening2: begin
			control <= 2'b10;
			if( remote|sensor1 ) begin
				nx_state <= open1;
			end
			else begin
				nx_state <= opening2;
			end
		end
		open1: begin
			control <= 2'b0x;
			if( remote ) begin
				nx_state <= open1;
			end
			else begin
				nx_state <= open1;
			end
		end
		open2: begin
			control <= 2'b0x;
			if( remote ) begin
				nx_state <= closing1;
			end
			else begin
				nx_state <= open2;
			end
		end
		closing1: begin
			control <= 2'b11;
			if( sensor2 ) begin
				nx_state <= closed1;
			end
			else if ( ~remote ) begin
				nx_state <= closing2;
			end
			else begin
				nx_state <= closing1;
			end
		end
		closing2: begin
			control <= 2'b11;
			if( remote|sensor2 ) begin
				nx_state <= closed1;
			end
			else begin
				nx_state <= closing2;
			end
		end
	endcase

endmodule
//.........................................................
