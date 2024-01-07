#run_test:
#	xrun \
#    -sv \
#    -uvm \
#    -access +rwc \
#    -f ../uvm_tb/uvm_compile.f \
#    -f ../uvm_tb/sim_defines.f \
#    -xm_newinitialize init.rule \
#    -xminit_log init.log \
#    -timescale 1ns/1ps \
#    -override_timescale \
#    -coverage all \
#    -covoverwrite \
#    -xprop F \
#    -assert \
#    -abvdisableasrtst \
#    -logfile logs/${UVM_TEST_NAME}.${TIME_STAMP}.xrun.log \
#    -input sim.tcl \
#    -define ${UVM_TEST_NAME} \
#    -mcl 4 \
#    +UVM_VERBOSITY=UVM_HIGH \
#    +UVM_TESTNAME=${UVM_TEST_NAME} \
#    $(args) ; \
#    bash -c "rm -rf logs/${UVM_TEST_NAME}.xrun.log &> /dev/null"; \
#    ln -s ${PWD}/logs/${UVM_TEST_NAME}.${TIME_STAMP}.xrun.log logs/${UVM_TEST_NAME}.xrun.log 

run_test:
	xrun \
	-sv \
	-f ${MODEL_ROOT}/filelist/counters/n_twisted_ring_counter_rtl.f \
	-f ${MODEL_ROOT}/filelist/counters/n_twisted_ring_counter_tb.f \
	-top n_twisted_ring_counter_tb \
	-access +rwc \
	-timescale 1ns/1ps \
	-override_timescale \
	-coverage all \
	-covoverwrite \
	-xprop F \
	-assert \
	-input sim.tcl \
	$(args) 
	
open_wave:
	simvision \
    -debugdb \
		waves.shm


make clean:
	rm -rf \
    *.history \
    xrun.* \
    xcelium.* \
    config_spi_* \
    simv*.diag \
    waves.shm \
    snapshot \
    vmgr_merge_logs \
    ida.db 


#short hand
rt: run_test
o: open_wave
