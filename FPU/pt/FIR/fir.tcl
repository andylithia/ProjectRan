#################################################
# Primetime 
# Script for static timing analysis
# MS 7/2015
#################################################

#################################################
# Units are defined in the .lib file
# time: ns
#################################################

## Global
set sh_enable_page_mode true
set power_enable_analysis true

## Setting files/paths
#set verilog_files {../../dc/sram/RF1SH_256x128_4xwrapper.nl.v}
#set my_toplevel RF1SH_256x128_4xwrapper
set verilog_files {../../dc/FIR/W4823_FIR.nl.v}
set my_toplevel W4823_FIR

set search_path [list "." "/courses/ee6321/share/ibm13rflpvt/synopsys/" \
					"../../../../../mem_comp/SP_CMEM" \
					"../../../../../mem_comp/SP_DMEM" \
					"../../../../../mem_comp/SP_REGFile" ]
set link_path [list "*" "scx3_cmos8rf_lpvt_tt_1p2v_25c.db" \
					"../../../../../mem_comp/SP_CMEM" \
					"../../../../../mem_comp/SP_DMEM" \
					"../../../../../mem_comp/SP_REGFile" ]

## Read design
read_db [list "scx3_cmos8rf_lpvt_tt_1p2v_25c.db" \
				"SP_CMEM_tt_1p2v_25c_syn.db" \
				"SP_DMEM_tt_1p2v_25c_syn.db" \
				"SP_REGF_tt_1p2v_25c_syn.db"]
read_verilog $verilog_files
link_design -keep_sub_designs $my_toplevel

## Timing Constraints
source ./timing.tcl


###################################################
## Run STA 
###################################################
set rpt_file "./W4823_FIR_pt.rpt"
check_timing
report_design >> ${rpt_file}
report_reference >> ${rpt_file}
report_constraint >> ${rpt_file}
report_constraint -all_violators -significant_digits 4 >> ${rpt_file}
report_timing -significant_digits 4 -delay_type min_max >> ${rpt_file}

## Power analysis
set power_analysis_mode "time_based"
read_vcd "../../qsim_dc/W4823_FIR_tb.vcd" -strip_path "W4823_FIR_tb/dut"
report_switching_activity >> ${rpt_file}
report_switching_activity -list_not_annotated >> ${rpt_file}
update_power
report_power -verbose  >> ${rpt_file}
report_power -hierarchy  >> ${rpt_file}

write_sdf -context verilog "./W4823_FIR_pt.sdf"

# Exiting primetime
quit
