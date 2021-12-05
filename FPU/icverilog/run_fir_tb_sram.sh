#!/bin/bash
iverilog -Wall -o W4823_FIR_tb.vvp ../verilog/FIR_tb.v ../verilog/FIR.v ../verilog/FPALU_dummy.v ../verilog/SRAM/SP_DMEM.v ../verilog/SRAM/SP_REGF.v ../verilog/SRAM/SP_CMEM.v ../verilog/FPALU.v ../verilog/icgc.v ../verilog/misc.v ../verilog/Constants/data_cmem_i16.v ../verilog/Constants/data_dmem_i16.v ../verilog/Constants/data_cmem_fp16.v ../verilog/Constants/data_dmem_fp16.v
vvp W4823_FIR_tb.vvp ../verilog/FPALU.v
gtkwave W4823_FIR_tb.vcd W4823_FIR_tb.gtkw
