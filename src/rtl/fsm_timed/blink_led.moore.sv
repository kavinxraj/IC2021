/*********************************************************/
// MODULE: 
//
// FILE NAME: blink_led.moore.sv 
// VERSION: 0.1
// DATE: 2022-Apr-27 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module blink_led
(
	input clk, rst_n,
	input enable,
	output logic led
);

typedef enum logic [1:0] {
	STOP,
	ON,
	OFF	
} state_t;

state_t pr_state, nx_state;

const logic [7:0] T1 = 4;
const logic [7:0] T2 = 8;
const logic [7:0] tmax = 100;
logic [7:0] t;

//timer logic strategy #1
always_ff @ ( posedge clk, negedge rst_n ) begin
	if( ~rst_n ) begin
		t <= 'b0;
	end
	else if( pr_state != nx_state ) begin
		t <= 'b0;
	end
	else if( t != tmax ) begin
		t <= t+1;
	end
end

//fsm state reg
always_ff @ ( posedge clk, negedge rst_n ) begin
	if( ~rst_n ) begin
		pr_state <= STOP;
	end
	else begin
		pr_state <= nx_state;
	end
end


//output and nx_state logic
always_comb begin
	case( pr_state ) 
		STOP: begin
			led = 'b0;
			if( enable ) begin
				nx_state = ON;
			end
			else begin
				nx_state = STOP;
			end
		end
		ON: begin
			led = 'b1;
			if( enable && t >= T1-1 ) begin
				nx_state = OFF;
			end
			else if( ~enable ) begin
				nx_state = STOP;
			end
			else begin
				nx_state = ON;
			end
		end
		OFF: begin
			led = 'b0;
			if( enable && t >= T2-1 ) begin
				nx_state = ON;
			end
			else if( ~enable ) begin
				nx_state = STOP;
			end
			else begin
				nx_state = OFF;
			end
		end
		default: begin
			led = 'b0;
			nx_state = STOP;
		end
	endcase
end
				
endmodule
