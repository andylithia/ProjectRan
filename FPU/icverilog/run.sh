#!/bin/bash
iverilog -Wall -o FPALU_tb.vvp ../verilog/FPALU_tb.v ../verilog/FPALU.v ../verilog/misc.v
vvp FPALU_tb.vvp
gtkwave dump.vcd Untitled.gtkw