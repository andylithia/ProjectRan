onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /W4823_FIR_tb/caddr
add wave -noupdate /W4823_FIR_tb/cin
add wave -noupdate /W4823_FIR_tb/clk_div
add wave -noupdate /W4823_FIR_tb/clk_fast
add wave -noupdate /W4823_FIR_tb/clk_slow
add wave -noupdate /W4823_FIR_tb/cload
add wave -noupdate /W4823_FIR_tb/din
add wave -noupdate /W4823_FIR_tb/first_cycle_r
add wave -noupdate /W4823_FIR_tb/load_cmem_cnt_r
add wave -noupdate /W4823_FIR_tb/rst_n
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/A
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/CEN
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/CLK
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/D
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/WEN
add wave -noupdate /W4823_FIR_tb/dut/u_cmem/Q
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/A
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/CEN
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/CLK
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/D
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/WEN
add wave -noupdate /W4823_FIR_tb/dut/u_dmem/Q
add wave -noupdate /W4823_FIR_tb/dut/cycle_dinlatch
add wave -noupdate /W4823_FIR_tb/dut/cycle_load
add wave -noupdate /W4823_FIR_tb/dut/cycle_mul_ndav
add wave -noupdate /W4823_FIR_tb/dut/cycle_mul
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106763 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 55
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {93200 ns} {145700 ns}
