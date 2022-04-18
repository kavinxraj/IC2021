/*********************************************************/
// MODULE: 
//
// FILE NAME: n_ring_counter.sv 
// VERSION: 0.1
// DATE: 2022-Apr-18 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: N Flop Ring Counter
//		Will Produce ouptut waveform fout = clk/n
//		Where n, is the number of flops used
//
/*********************************************************/

module n_ring_counter 
#(
	NUMBER_OF_FLOPS = 4
)
(
	input clk,
	input stop,
	output logic q_out
);

localparam N = NUMBER_OF_FLOPS - 1;

logic [N:0] q;

always_ff @ ( posedge clk , negedge stop ) begin
	if( ~stop ) begin
		q <= 'b1;
	end
	else begin
		q[N:1] <=  q[N-1:0];
		q[0] <= q[N];
	end
end

always_comb begin
	q_out = q[N];
end


endmodule
