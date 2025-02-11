onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RF_iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RF_iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RF_iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RF_iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RWB_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RA_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RB_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RZH_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/RZL_en
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r3/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r3/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r7/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r7/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r4/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r4/oQ
add wave -noupdate /SIM_DATAPATH_OR/DUT/RWB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RWB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RA/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RA/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_WBP
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
