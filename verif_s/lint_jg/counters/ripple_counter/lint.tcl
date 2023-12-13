clear -all

#Initialize superlint app
check_superlint -init 

#Load the checks
config_rtlds -rule -enable -domain all

analyze -sv -f $::env(MODEL_ROOT)/filelist/counters/ripple_counter_rtl.f
elaborate -top ripple_counter

#Clock and reset 
clock -infer
reset ~clr_n

#Extract properties
check_superlint -extract 
check_superlint -prove

#Save database
check_superlint -save -file ripple_counter_db

#Generate report
check_superlint -report -detailed -file "ripple_counter.rpt" -force 