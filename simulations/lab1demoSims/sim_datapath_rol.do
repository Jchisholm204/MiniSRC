vsim work.SIM_DATAPATH_ROL
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/oRegA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/oRegB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r1_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r2_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r3_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r4_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r5_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r6_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r7_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r8_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r9_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r10_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r11_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r12_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r13_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r14_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RF/r15_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_ROL/MUX_WBP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {127580 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 245
configure wave -valuecolwidth 81
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {136500 ps}
run 130ns
