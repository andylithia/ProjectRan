set top_level RF1SH_256x128_4xwrapper
# source -verbose "../common_script/common.tcl"
read_verilog {../../mem_comp/RF1SH_256x128/RF1SH_256x128_4xwrapper.v}
set search_path [list "." "/tools4/syn2007.12/libraries/syn/" "../../mem_comp/RF1SH_256x128"]
set synthetic_library [list "dw_foundation.sldb"]
set link_library [list "*" \
                       "/courses/ee6321/share/ibm13rflpvt/synopsys/scx3_cmos8rf_lpvt_tt_1p2v_25c.db" \
                       "dw_foundation.sldb" \
					   "RF1SH_256x128_tt_1p2v_25c_syn.db"]
set target_library [list "/courses/ee6321/share/ibm13rflpvt/synopsys/scx3_cmos8rf_lpvt_tt_1p2v_25c.db" \
						"RF1SH_256x128_tt_1p2v_25c_syn.db"]


# read -f verilog RF1SH_256x128.v
# write_timing verilog -f sdf-v2.1 -o ${top_level}.sdf

set set_fix_multiple_port_nets "true"
list_designs

if { [check_error -v] == 1 } { exit 1 }

#########################
# Design Constraints    #
#########################
current_design $top_level
link
check_design
source -verbose "./timing.tcl"
set_max_capacitance 0.05 [all_inputs]
# set_load 1 [all_outputs]
# set_input_delay -min 5 [all_inputs]
set_max_fanout 4 $top_level
set_max_fanout 4 [all_inputs]
set_max_area 0
set_fix_multiple_port_nets -all -buffer_constants

##########################
# Compile
##########################
check_design
#uniquify
current_design $top_level
link
compile_ultra


#########################
# Optimize Design
########################

########################
# Write Outputs
#######################
source -verbose "../common_script/namingrules.tcl"
set verilogout_no_tri TRUE
write -hierarchy -format verilog -output "${top_level}.nl.v"
write_sdc "${top_level}.syn.sdc" -version 1.7
write_sdf "${top_level}.syn.sdf"

# Generate report file
set maxpaths 100
set rpt_file "${top_level}.dc.rpt"
check_design > $rpt_file
report_area >> ${rpt_file}
report_power -hier -analysis_effort medium >> ${rpt_file}
report_design >> ${rpt_file}
report_cell >> ${rpt_file}
report_port -verbose >> ${rpt_file}
report_compile_options >> ${rpt_file}
report_constraint -all_violators -verbose >> ${rpt_file}
report_timing -path full -delay max -max_paths $maxpaths -nworst 100 >> ${rpt_file}
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack > ${top_level}.syn.critical_regs
report_timing -delay max -nworst 1 -max_paths 10000 -path full -nosplit -unique -sort_by slack > ${top_level}.syn.critical_regs.full
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack -to [all_outputs] > ${top_level}.syn.critical_regs.output
report_timing -delay max -nworst 1 -max_paths 10000 -path end -nosplit -unique -sort_by slack -to [all_registers -data_pins] > ${top_level}.syn.critical_regs.regs
report_timing -delay min -nworst 1 -max_paths 10000 -path short -nosplit -unique -sort_by slack > ${top_level}.syn.fast_path
quit
