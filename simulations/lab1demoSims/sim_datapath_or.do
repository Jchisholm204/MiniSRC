vsim work.SIM_DATAPATH_OR
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/nReset
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/Clock
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/Present_State
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iWrite
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iAddrA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iAddrB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iAddrC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/oRegA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/oRegB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/iRegC
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r1_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r2_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r3_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r4_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r5_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r6_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r7_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r8_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r9_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r10_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r11_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r12_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r13_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r14_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r15_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r1_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r2_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r3_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r4_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r5_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r6_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r7_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r8_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r9_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r10_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r11_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r12_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r13_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r14_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RF/r15_out
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASH/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASH/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZH/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZH/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RA/iEn
add wave -noupdate -radix hexadecimal -childformat {{{/SIM_DATAPATH_OR/DUT/RA/iD[31]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[30]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[29]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[28]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[27]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[26]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[25]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[24]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[23]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[22]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[21]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[20]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[19]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[18]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[17]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[16]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[15]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[14]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[13]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[12]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[11]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[10]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[9]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[8]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[7]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[6]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[5]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[4]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[3]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[2]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[1]} -radix hexadecimal} {{/SIM_DATAPATH_OR/DUT/RA/iD[0]} -radix hexadecimal}} -subitemconfig {{/SIM_DATAPATH_OR/DUT/RA/iD[31]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[30]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[29]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[28]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[27]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[26]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[25]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[24]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[23]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[22]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[21]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[20]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[19]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[18]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[17]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[16]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[15]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[14]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[13]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[12]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[11]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[10]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[9]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[8]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[7]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[6]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[5]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[4]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[3]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[2]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[1]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_OR/DUT/RA/iD[0]} {-height 15 -radix hexadecimal}} /SIM_DATAPATH_OR/DUT/RA/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RWB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RWB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/RWB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/ALU_iCtrl
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/iA
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/iB
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/oC_hi
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/DUT/alu/oC_lo
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/oMemAddr
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/oMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_BIS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_RZHS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_WBM
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_MAP
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_ASS
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_OR/MUX_WBP
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
