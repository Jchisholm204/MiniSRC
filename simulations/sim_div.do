onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_DIV32/divider/iQ
add wave -noupdate /sim_DIV32/divider/iD
add wave -noupdate /sim_DIV32/divider/oQ
add wave -noupdate /sim_DIV32/divider/oR
add wave -noupdate -childformat {{{/sim_DIV32/divider/A[0]} -radix decimal}} -expand -subitemconfig {{/sim_DIV32/divider/A[0]} {-height 15 -radix decimal}} /sim_DIV32/divider/A
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6294380018 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 151
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ps} {10500 us}
