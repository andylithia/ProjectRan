#!/bin/bash
iverilog -Wall -o bsl_tb.vvp ../verilog/bsl_tb.v ../verilog/misc.v 
vvp bsl_tb.vvp
gtkwave bsl_tb.vcd
