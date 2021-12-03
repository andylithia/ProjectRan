##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../verilog/misc.v
vlog +acc -incr ../verilog/IALU_behav.v
# vlog +acc -incr ../verilog/sp_sram.v
vlog +acc -incr ../../../../mem_comp/SP_CMEM/SP_CMEM.v
vlog +acc -incr ../../../../mem_comp/SP_DMEM/SP_DMEM.v
vlog +acc -incr ../../../../mem_comp/SP_REGFile/SP_REGF.v
vlog +acc -incr ../verilog/icgc.v
vlog +acc -incr ../verilog/FIR.v
vlog +acc -incr ../verilog/iFIR_tb.v

# Run Simulator 
vsim +acc -t ns -lib work W4823_iFIR_tb
do waveformat.do   
run -all
