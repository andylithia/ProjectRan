#!/bin/bash
iverilog -Wall -o FPALU_tb.vvp ../verilog/FPALU_add29i_tb.v ../verilog/FPALU.v ../verilog/misc.v
vvp FPALU_tb.vvp
gtkwave dump.vcd FPALU_FPADD29i_test.gtkw
