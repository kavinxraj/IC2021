/*********************************************************/
// MODULE: 
//
// FILE NAME: arbiter_n2.sv 
// VERSION: 0.1
// DATE: 2022-May-04 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
//
/*********************************************************/

module arbiter_n2
import arbiter_n2_pkg::*;
#(
	parameter CD_MAX1 = 9,
	parameter CD_MAX2 = 1
)
(
	input clk, rst,
	input req_t req,
	output gnt_t gnt
);

//cool down counter declaration
logic [4:0] cd_count [2];
logic [1:0] cd_en, cd_up;
const logic [4:0] cd_max [2] = { CD_MAX1, CD_MAX2 };

//state var declarations
state_t pr_state, nx_state;

//cool down counter logic
generate
for( genvar i = 0; i < 2; i++ ) begin: cd_counters
	always_ff @ ( posedge clk, negedge rst ) begin
		if( ~rst ) begin
			cd_count[i] <= 'b0;
		end
		else if( /* cd_en[i] && */ cd_up[i] && cd_count[i] != cd_max[i] ) begin
			cd_count[i] <= cd_count[i] + 1;
		end
		else if( /* cd_en && */ ~cd_up[i] && cd_count[i] != 0 ) begin
			cd_count[i] <= cd_count[i] - 1;
		end
		else begin
			cd_count[i] <= cd_count[i];
		end
	end
end
endgenerate

//state reg
always_ff @ ( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		pr_state <= IDLE;
	end
	else begin
		pr_state <= nx_state;
	end
end

//next state logic and output logic
always_comb begin
	case( pr_state )
		IDLE: begin
			gnt = NO_GNT;
			//cd_en = 2'b11;
			cd_up = 2'b00;
			case( req ) 
				REQ0: begin nx_state <= STATE_GNT0; end
				REQ1: begin nx_state <= STATE_GNT1; end
				REQ01: begin
					nx_state <= STATE_GNT0;
				end
				default: begin nx_state <= IDLE; end
			endcase
		end
		STATE_GNT0: begin
			gnt = GNT0;
			//cd_en = 2'b11;
			cd_up = 2'b01;
			case( req )
				REQ0: begin nx_state <= STATE_GNT0; end
				REQ1: begin nx_state <= STATE_GNT1; end
				REQ01: begin
					if( cd_count[0] == cd_max[0]-1 ) begin
						nx_state <= STATE_GNT1;
					end
					else begin
						nx_state <= STATE_GNT0;
					end
				end
				default: begin nx_state <= STATE_GNT0; end
			endcase
		end
		STATE_GNT1: begin
			gnt = GNT1;
			//cd_en = 2'b11;
			cd_up = 2'b10;
			case( req )
				REQ0: begin nx_state <= STATE_GNT0; end
				REQ1: begin nx_state <= STATE_GNT1; end
				REQ01: begin
					if( cd_count[1] == cd_max[1]-1 ) begin
						nx_state <= STATE_GNT0;
					end
					else begin
						nx_state <= STATE_GNT1;
					end
				end
				default: begin nx_state <= STATE_GNT1; end
			endcase
		end
		default: begin
			gnt = NO_GNT;
			cd_up = 2'b00;
			nx_state <= IDLE;
		end
	endcase
end

`ifdef SVA_ENABLE
	arbiter_n2_sva sva_inst ( .* );
`endif

endmodule
