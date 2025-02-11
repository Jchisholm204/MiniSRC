onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RF_iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RF_iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RF_iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RF_iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RWB_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RA_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RB_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RZH_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/RZL_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r3/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r3/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r7/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r7/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r4/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RF/r4/oQ
add wave -noupdate /SIM_DATAPATH_AND/DUT/RWB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RWB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RZL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RZL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RA/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RA/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_AND/MUX_WBP
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {134980 ps} 0}
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
WaveRestoreZoom {15220 ps} {146570 ps}
