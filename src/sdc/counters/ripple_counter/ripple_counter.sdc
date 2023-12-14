#Constraints file for the ripple counter

#Clocks and Generated Clocks
create_clock -name "CLK" -period 10 -waveform {0.0 5.0} [get_ports clk]

set_clock_latency 1.0 -rise [get_clocks CLK]
set_clock_latency 1.0 -fall [get_clocks CLK]

set_clock_uncertainity -setup 0.2 [get_clocks CLK]
set_clock_uncertainity -hold 0.3 [get_clocks CLK]

set_clock_transition 0.4 -rise [get_clocks CLK]
set_clock_transition 0.2 -fall [get_clocks CLK]

create_generated_clock -name "Q0" -source [get_clocks CLK] -edges {2 4 6} [get_ports count[0]]

#IO Delays
set_input_delay 1.4 -rise -clock CLK {clkpol}
set_output_delay 1.5 -rise -clock CLK {counted_max}

#Custom path timing constraints
#set_max_delay -from [] -to []

#Multi Cycle Paths
#set_multicycle_path -setup 2 -hold 1 -from {} -to {}

#False Paths
#set_fasle_path -from {} -to {} -through