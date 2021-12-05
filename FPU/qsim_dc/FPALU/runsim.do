##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench

#vlog +acc -incr ../../verilog/misc.v
#vlog +acc -incr ../../verilog/FPALU.v
vlog +acc -incr /courses/ee6321/share/ibm13rflpvt/verilog/ibm13rflpvt.v
vlog +acc -incr ../../dc/FIR/FPALU.nl.v
vlog +acc -incr ../../verilog/Constants/data_cmem_fp16.v
vlog +acc -incr ../../verilog/Constants/data_dmem_fp16.v
vlog +acc -incr ../../verilog/FPALU_tb.v

vsim -voptargs=+acc -t ns -lib work -sdftyp dut=../../dc/FIR/FPALU.syn.sdf

# Run Simulator 
vsim +acc -t ns -lib work FPALU_tb
do waveformat.do   
run -all
