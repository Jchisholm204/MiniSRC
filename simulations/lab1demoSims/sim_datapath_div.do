vsim work.SIM_DATAPATH_DIV
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/oRegA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/oRegB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r1_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r2_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r3_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r4_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r5_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r6_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r7_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r8_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r9_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r10_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r11_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r12_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r13_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r14_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RF/r15_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_DIV/MUX_WBP
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
WaveRestoreZoom {0 ps} {116500 ps}
run 110ns
