#!/bin/bash
iverilog -Wall -o W4823_FIR_tb.vvp ../verilog/FIR_tb.v ../verilog/FIR.v
vvp W4823_FIR_tb.vvp
gtkwave W4823_FIR_tb.vcd W4823_FIR_tb.gtkw
