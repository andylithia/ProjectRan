##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr /courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog +acc -incr ../../../../mem_comp/SP_CMEM/SP_CMEM.v
vlog +acc -incr ../../../../mem_comp/SP_DMEM/SP_DMEM.v
vlog +acc -incr ../../../../mem_comp/SP_REGFile/SP_REGF.v
vlog +acc -incr ../dc/FIR/W4823_FIR.nl.v
vlog +acc -incr ../verilog/FIR_tb.v

vsim -voptargs=+acc -t ns -lib work -sdftyp dut=../dc/FIR/W4823_FIR.syn.sdf

# Run Simulator 
vsim +acc -t ns -lib work W4823_FIR_tb
do waveformat.do   
run -all
