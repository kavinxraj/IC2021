/*********************************************************/
// MODULE: 
//
// FILE NAME: n_twisted_ring_counter.sv 
// VERSION: 0.1
// DATE: 2022-Apr-18 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION: N bit Twisted Ring Counter,
//		Also know as Jhonson Counter,
//		Twisted Tail Counter
//		Capable of producing fout = clk/2n
//		Where n, is the number of flops
//
/*********************************************************/

module n_twisted_ring_counter
#(
	parameter NUMBER_OF_FLOPS = 5
)
(
	input clk,
	input rst,
	output logic q_out
);

localparam N = NUMBER_OF_FLOPS - 1;

logic [N:0] q;

always_ff @( posedge clk, negedge rst ) begin
	if( ~rst ) begin
		q <= 'b0;
	end
	else begin
		q[N:1] <= q[N-1:0];
		q[0] <= ~q[N]; //twisting the output happens here
	end
end

always_comb begin
	q_out = q[N];
end

endmodule
