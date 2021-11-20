##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/mul/mulparam.v
vlog +acc -incr test_mulparam.v 

# Run Simulator 
vsim -t ps -lib work testbench 
do waveformat.do   
run -all

