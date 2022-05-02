/*********************************************************/
// MODULE: 
//
// FILE NAME: two_sided_debouncer.moore.sv 
// VERSION: 0.1
// DATE: 2022-May-02 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module two_sided_debouncer
(
	input clk, rst,
	input bounce_in,
	output logic bounce_out
);

//enum for states
typedef enum logic [1:0] {
	ZERO,
	STILL_ZERO,
	ONE,
	STILL_ONE
} state_t;

//timer defines
const logic [7:0] pulse_width = 2;
logic [7:0] timer;

//state reg defines
state_t pr_state, nx_state;

//timer
always_ff @ ( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		timer <= 'b0;
	end 
	else if( pr_state != nx_state ) begin
		timer <= 'b0;
	end
	else if( timer < pulse_width ) begin
		timer <= timer+1;
	end
	else begin
		timer <= timer;
	end
end

//state reg
always_ff @ ( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		pr_state <= ZERO;
	end
	else begin
		pr_state <= nx_state;
	end
end

//comb logic for nx_state and output
always_comb begin
	case( pr_state )
		ZERO: begin
			bounce_out = 1'b0;
			if( bounce_in == 1'b1 ) begin
				nx_state = STILL_ZERO;
			end
			else begin
				nx_state = ZERO;
			end
		end
		STILL_ZERO: begin
			bounce_out = 1'b0;
			if( bounce_in == 1'b1 && timer >= pulse_width-1 ) begin
				nx_state = ONE;
			end
			else if( bounce_in == 1'b0 ) begin
				nx_state = ZERO;
			end
			else begin
				nx_state = STILL_ZERO;
			end
		end
		ONE: begin
			bounce_out = 1'b1;
			if( bounce_in == 1'b0 ) begin
				nx_state = STILL_ONE;
			end
			else begin
				nx_state = ONE;
			end
		end
		STILL_ONE: begin
			bounce_out = 1'b1;
			if( bounce_in == 0 && timer >= pulse_width -1 ) begin
				nx_state = ZERO;
			end
			else if( bounce_in == 1'b1 ) begin
				nx_state = ONE;
			end
			else begin
				nx_state = STILL_ONE;
			end
		end
		default: begin
			bounce_out = 1'b0;
			nx_state = ZERO;
		end
	endcase
end

endmodule
