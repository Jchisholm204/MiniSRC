vsim work.SIM_DATAPATH_SRA
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/oRegA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/oRegB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r1_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r2_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r3_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r4_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r5_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r6_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r7_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r8_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r9_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r10_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r11_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r12_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r13_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r14_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r15_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/MUX_WBP
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
