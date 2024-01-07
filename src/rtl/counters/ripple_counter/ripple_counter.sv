/*********************************************************/
// MODULE: 
//
// FILE NAME: ripple_counter.sv 
// VERSION: 0.1
// DATE: 2023-Dec-10 
// AUTHOR: KavinRaj D
//
// CODE TYPE: RTL or Behavioral Level
//
// DESCRIPTION:
// When used as a auto counter this will behave like a mod counter
// producing frequency of f/n
// when used as a manual counter, this will behave like a clk count 
// indicator, when max number of edges are there it will glow
//
/*********************************************************/

module ripple_counter
#(
    parameter RC_WIDTH = 3
)(
    input  logic clk,                       //clock
    input  logic clr_n,                     //reset counter
    input  logic clkpol,                    //configurable clk polarity
    input  logic auto,                      //auto counter / ~ manual counter
    input  logic [RC_WIDTH-1:0] max_count,
    output logic [RC_WIDTH-1:0] count,
    output logic [RC_WIDTH-1:0] count_n,
    output logic counted_max
);

logic clk_i;
logic clr_i;
logic count_max_clear;

always_comb begin
    clk_i = clkpol?~clk:clk;
    clr_i = clr_n & ~(count_max_clear&auto);
end

generate
    for(genvar i = 0; i < RC_WIDTH; i++) begin : gen_rc
        if(i == 0) begin
            always_ff @ (negedge clk_i, negedge clr_i) begin
                if(clr_i == 1'b0) begin
                    count[i] <= 1'b0;
                end
                else if(auto == 1'b0 && counted_max == 1'b1) begin
                    count[i] <= count[i];
                end
                else begin
                    count[i] <= ~count[i];
                end
            end
        end
        else begin
            always_ff @ (negedge count[i-1], negedge clr_i) begin
                if(clr_i == 1'b0) begin
                    count[i] <= 1'b0;
                end
                else if(auto == 1'b0 && counted_max == 1'b1) begin
                    count[i] <= count[i];
                end
                else begin
                    count[i] <= ~count[i];
                end
            end
        end
    end
endgenerate

always_comb begin
    count_n = ~count;
end

always_comb begin
    count_max_clear = (count == max_count ); //used in auto clear
    if(auto) begin
      counted_max     = (count == max_count-1 ); //mod counter like mod7 = 0-6, to produce output of div by 7
    end
    else begin
      counted_max     = (count == max_count); //like a edge counting scenario
    end
end


endmodule : ripple_counter