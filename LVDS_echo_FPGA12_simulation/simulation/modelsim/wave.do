onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /mkMFpgaTop/CLK
add wave -noupdate /mkMFpgaTop/RST_N
add wave -noupdate -radix hexadecimal /mkMFpgaTop/putFlit0_put
add wave -noupdate /mkMFpgaTop/EN_putFlit0_put
add wave -noupdate /mkMFpgaTop/EN_getFlit0_get
add wave -noupdate /mkMFpgaTop/RDY_putFlit0_put
add wave -noupdate -radix hexadecimal /mkMFpgaTop/getFlit0_get
add wave -noupdate /mkMFpgaTop/RDY_getFlit0_get
add wave -noupdate /mkMFpgaTop/fpga2/reset_n
add wave -noupdate /mkMFpgaTop/fpga2/tx_inclock
add wave -noupdate /mkMFpgaTop/fpga2/tx_out
add wave -noupdate /mkMFpgaTop/fpga2/tx_outclock
add wave -noupdate /mkMFpgaTop/fpga2/tx_align_done
add wave -noupdate /mkMFpgaTop/fpga2/rx_in
add wave -noupdate /mkMFpgaTop/fpga2/rx_inclock
add wave -noupdate /mkMFpgaTop/fpga2/rx_align_done
add wave -noupdate /mkMFpgaTop/fpga2/rx_outclock
add wave -noupdate /mkMFpgaTop/fpga2/enq_tx
add wave -noupdate /mkMFpgaTop/fpga2/EN_enq_tx
add wave -noupdate /mkMFpgaTop/fpga2/RDY_enq_tx
add wave -noupdate /mkMFpgaTop/fpga2/deq_rx
add wave -noupdate /mkMFpgaTop/fpga2/EN_deq_rx
add wave -noupdate /mkMFpgaTop/fpga2/RDY_deq_rx
add wave -noupdate /mkMFpgaTop/fpga2/led_out
add wave -noupdate /mkMFpgaTop/fpga2/state_tx
add wave -noupdate /mkMFpgaTop/fpga2/next_state_tx
add wave -noupdate /mkMFpgaTop/fpga2/state_rx
add wave -noupdate /mkMFpgaTop/fpga2/next_state_rx
add wave -noupdate /mkMFpgaTop/fpga2/pll_areset
add wave -noupdate /mkMFpgaTop/fpga2/rx_locked
add wave -noupdate /mkMFpgaTop/fpga2/tx_locked
add wave -noupdate /mkMFpgaTop/fpga2/rx_data_align
add wave -noupdate /mkMFpgaTop/fpga2/tx_in
add wave -noupdate /mkMFpgaTop/fpga2/align_done
add wave -noupdate /mkMFpgaTop/fpga2/rx_out
add wave -noupdate /mkMFpgaTop/fpga2/count
add wave -noupdate /mkMFpgaTop/fpga2/sub_0_tx
add wave -noupdate /mkMFpgaTop/fpga2/sub_1_tx
add wave -noupdate /mkMFpgaTop/fpga2/sub_2_tx
add wave -noupdate /mkMFpgaTop/fpga2/sub_3_tx
add wave -noupdate /mkMFpgaTop/fpga2/sub_0_rx
add wave -noupdate /mkMFpgaTop/fpga2/sub_1_rx
add wave -noupdate /mkMFpgaTop/fpga2/sub_2_rx
add wave -noupdate /mkMFpgaTop/fpga2/sub_3_rx
add wave -noupdate /mkMFpgaTop/fpga2/led_tx_state
add wave -noupdate /mkMFpgaTop/fpga2/led_rx_state
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sCLK
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sRST
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sENQ
add wave -noupdate -radix hexadecimal /mkMFpgaTop/xfpga2/xfpga5/outin_/sD_IN
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sFULL_N
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dCLK
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dDEQ
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dEMPTY_N
add wave -noupdate -radix hexadecimal /mkMFpgaTop/xfpga2/xfpga5/outin_/dD_OUT
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/msbset
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/msb2set
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/msb12set
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dDoutReg
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sGEnqPtr
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sGEnqPtr1
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sNotFullReg
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sNextNotFull
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sFutureNotFull
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dGDeqPtr
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dGDeqPtr1
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dNotEmptyReg
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dNextNotEmpty
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dRST
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dSyncReg1
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dEnqPtr
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sSyncReg1
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sDeqPtr
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/sEnqPtrIndx
add wave -noupdate /mkMFpgaTop/xfpga2/xfpga5/outin_/dDeqPtrIndx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {879756 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 337
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
configure wave -timelineunits ps
update
WaveRestoreZoom {983925 ps} {1075558 ps}
