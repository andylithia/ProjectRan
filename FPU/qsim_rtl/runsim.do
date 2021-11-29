##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../verilog/misc.v
vlog +acc -incr ../verilog/FPALU_dummy.v
vlog +acc -incr ../verilog/sp_sram.v
vlog +acc -incr ../verilog/FIR.v
vlog +acc -incr ../verilog/FIR_tb.v


# Run Simulator 
vsim +acc -t ns -lib work W4823_FIR_tb
do waveformat.do   
run -all
