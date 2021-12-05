#!/bin/bash
iverilog -Wall -o FPALU_tb.vvp ../verilog/FPALU_tb.v ../verilog/FPALU.v ../verilog/misc.v ../verilog/Constants/data_cmem_fp16.v ../verilog/Constants/data_dmem_fp16.v
vvp FPALU_tb.vvp
gtkwave dump.vcd FPALU_FPADD29i_test.gtkw
