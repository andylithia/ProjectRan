onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /FPALU_tb/dut/a_real_FP29i_s5
add wave -noupdate /FPALU_tb/dut/a_real_FP16_s5
add wave -noupdate /FPALU_tb/dut/y_real_FP29i
add wave -noupdate /FPALU_tb/dut/y_expected_ml
add wave -noupdate /FPALU_tb/dut/y_expected_ad
add wave -noupdate /FPALU_tb/dut/tm
add wave -noupdate /FPALU_tb/dut/ta
add wave -noupdate /FPALU_tb/dut/add_valid
add wave -noupdate /FPALU_tb/dut/mul_valid
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {487 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
configure wave -valuecolwidth 100
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
WaveRestoreZoom {789 ns} {803 ns}
