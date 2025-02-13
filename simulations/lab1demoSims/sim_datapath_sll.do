vsim work.SIM_DATAPATH_SLL
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/oRegA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/oRegB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r1_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r2_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r3_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r4_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r5_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r6_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r7_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r8_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r9_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r10_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r11_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r12_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r13_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r14_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RF/r15_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SLL/MUX_WBP
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
