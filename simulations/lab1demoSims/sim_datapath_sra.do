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
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r1_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r2_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r3_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r4_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r5_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r6_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r7_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r8_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r9_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r10_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r11_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r12_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r13_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r14_write
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RF/r15_write
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
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASH/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASH/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RASL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/iMemData
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZH/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZH/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZH/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZL/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZL/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RZL/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RA/iEn
add wave -noupdate -radix hexadecimal -childformat {{{/SIM_DATAPATH_SRA/DUT/RA/iD[31]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[30]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[29]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[28]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[27]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[26]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[25]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[24]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[23]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[22]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[21]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[20]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[19]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[18]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[17]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[16]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[15]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[14]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[13]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[12]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[11]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[10]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[9]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[8]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[7]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[6]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[5]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[4]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[3]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[2]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[1]} -radix hexadecimal} {{/SIM_DATAPATH_SRA/DUT/RA/iD[0]} -radix hexadecimal}} -subitemconfig {{/SIM_DATAPATH_SRA/DUT/RA/iD[31]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[30]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[29]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[28]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[27]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[26]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[25]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[24]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[23]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[22]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[21]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[20]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[19]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[18]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[17]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[16]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[15]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[14]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[13]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[12]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[11]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[10]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[9]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[8]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[7]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[6]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[5]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[4]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[3]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[2]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[1]} {-height 15 -radix hexadecimal} {/SIM_DATAPATH_SRA/DUT/RA/iD[0]} {-height 15 -radix hexadecimal}} /SIM_DATAPATH_SRA/DUT/RA/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RA/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RB/iD
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RB/oQ
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RWB/iEn
add wave -noupdate -radix hexadecimal /SIM_DATAPATH_SRA/DUT/RWB/iD
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
