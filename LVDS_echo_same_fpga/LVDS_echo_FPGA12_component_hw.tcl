# TCL File Generated by Component Editor 16.1
# Mon Jun 18 19:47:32 IST 2018
# DO NOT MODIFY


# 
# LVDS_echo_FPGA12_component "LVDS_echo_FPGA12_component" v1.0
#  2018.06.18.19:47:32
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module LVDS_echo_FPGA12_component
# 
set_module_property DESCRIPTION ""
set_module_property NAME LVDS_echo_FPGA12_component
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME LVDS_echo_FPGA12_component
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL FPGA12_TopNiosInterface
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file BRAM1.v VERILOG PATH src_files/BRAM1.v
add_fileset_file BRAM1BE.v VERILOG PATH src_files/BRAM1BE.v
add_fileset_file BRAM1BELoad.v VERILOG PATH src_files/BRAM1BELoad.v
add_fileset_file BRAM1Load.v VERILOG PATH src_files/BRAM1Load.v
add_fileset_file BRAM2.v VERILOG PATH src_files/BRAM2.v
add_fileset_file BRAM2BE.v VERILOG PATH src_files/BRAM2BE.v
add_fileset_file BRAM2BELoad.v VERILOG PATH src_files/BRAM2BELoad.v
add_fileset_file BRAM2Load.v VERILOG PATH src_files/BRAM2Load.v
add_fileset_file Bram.v VERILOG PATH src_files/Bram.v
add_fileset_file FIFO1.v VERILOG PATH src_files/FIFO1.v
add_fileset_file FIFO10.v VERILOG PATH src_files/FIFO10.v
add_fileset_file FIFO2.v VERILOG PATH src_files/FIFO2.v
add_fileset_file FPGA12_TopNiosInterface.v VERILOG PATH src_files/FPGA12_TopNiosInterface.v TOP_LEVEL_FILE
add_fileset_file LVDS_fpga.v VERILOG PATH src_files/LVDS_fpga.v
add_fileset_file LVDS_fpga.v.bak OTHER PATH src_files/LVDS_fpga.v.bak
add_fileset_file RegFile.v VERILOG PATH src_files/RegFile.v
add_fileset_file RegFileLoadSyn.v VERILOG PATH src_files/RegFileLoadSyn.v
add_fileset_file RegFile_1port.v VERILOG PATH src_files/RegFile_1port.v
add_fileset_file RevertReg.v VERILOG PATH src_files/RevertReg.v
add_fileset_file SizedFIFO.v VERILOG PATH src_files/SizedFIFO.v
add_fileset_file SyncFIFO1.v VERILOG PATH src_files/SyncFIFO1.v
add_fileset_file connect_parameters.v VERILOG PATH src_files/connect_parameters.v
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_10.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_10.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_11.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_11.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_12.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_12.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_13.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_13.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_20.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_20.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_21.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_21.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_22.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_22.hex
add_fileset_file customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_23.hex HEX PATH src_files/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_23.hex
add_fileset_file loop_back_verilog.v.bak OTHER PATH src_files/loop_back_verilog.v.bak
add_fileset_file mkCnctBridge.v VERILOG PATH src_files/mkCnctBridge.v
add_fileset_file mkIQRouterCoreSimple.v VERILOG PATH src_files/mkIQRouterCoreSimple.v
add_fileset_file mkInputArbiter.v VERILOG PATH src_files/mkInputArbiter.v
add_fileset_file mkInputQueue.v VERILOG PATH src_files/mkInputQueue.v
add_fileset_file mkInterFPGA_LVDS.v VERILOG PATH src_files/mkInterFPGA_LVDS.v
add_fileset_file mkMFpgaTop.v VERILOG PATH src_files/mkMFpgaTop.v
add_fileset_file mkMFpgaTop.v.bak OTHER PATH src_files/mkMFpgaTop.v.bak
add_fileset_file mkNetworkSimple1.v VERILOG PATH src_files/mkNetworkSimple1.v
add_fileset_file mkNetworkSimple2.v VERILOG PATH src_files/mkNetworkSimple2.v
add_fileset_file mkNodeTask_echo1.v VERILOG PATH src_files/mkNodeTask_echo1.v
add_fileset_file mkNodeTask_echo2.v VERILOG PATH src_files/mkNodeTask_echo2.v
add_fileset_file mkNodeTask_fpga1_4.v VERILOG PATH src_files/mkNodeTask_fpga1_4.v
add_fileset_file mkNodeTask_fpga2_5.v VERILOG PATH src_files/mkNodeTask_fpga2_5.v
add_fileset_file mkNodeTask_host.v VERILOG PATH src_files/mkNodeTask_host.v
add_fileset_file mkOutPortFIFO.v VERILOG PATH src_files/mkOutPortFIFO.v
add_fileset_file mkOutputArbiter.v VERILOG PATH src_files/mkOutputArbiter.v
add_fileset_file mkRouterInputArbitersRoundRobin.v VERILOG PATH src_files/mkRouterInputArbitersRoundRobin.v
add_fileset_file mkRouterInputArbitersStatic.v VERILOG PATH src_files/mkRouterInputArbitersStatic.v
add_fileset_file mkRouterOutputArbitersRoundRobin.v VERILOG PATH src_files/mkRouterOutputArbitersRoundRobin.v
add_fileset_file mkRouterOutputArbitersStatic.v VERILOG PATH src_files/mkRouterOutputArbitersStatic.v
add_fileset_file mkSepRouterAllocator.v VERILOG PATH src_files/mkSepRouterAllocator.v
add_fileset_file mkTb.v VERILOG PATH src_files/mkTb.v
add_fileset_file mkTop_fpga1.v VERILOG PATH src_files/mkTop_fpga1.v
add_fileset_file mkTop_fpga2.v VERILOG PATH src_files/mkTop_fpga2.v
add_fileset_file module_gen_grant_carry.v VERILOG PATH src_files/module_gen_grant_carry.v
add_fileset_file module_outport_encoder.v VERILOG PATH src_files/module_outport_encoder.v
add_fileset_file rx.v VERILOG PATH rx.v
add_fileset_file tx.v VERILOG PATH tx.v


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock CLK clk Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset_sink
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitStates 0
set_interface_property avalon_slave_0 readWaitTime 0
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 address address Input 3
add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 readdata readdata Output 32
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 writedata writedata Input 32
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point reset_sink
# 
add_interface reset_sink reset end
set_interface_property reset_sink associatedClock clock
set_interface_property reset_sink synchronousEdges DEASSERT
set_interface_property reset_sink ENABLED true
set_interface_property reset_sink EXPORT_OF ""
set_interface_property reset_sink PORT_NAME_MAP ""
set_interface_property reset_sink CMSIS_SVD_VARIABLES ""
set_interface_property reset_sink SVD_ADDRESS_GROUP ""

add_interface_port reset_sink RST_N reset_n Input 1


# 
# connection point interrupt_sender
# 
add_interface interrupt_sender interrupt end
set_interface_property interrupt_sender associatedAddressablePoint avalon_slave_0
set_interface_property interrupt_sender associatedClock clock
set_interface_property interrupt_sender associatedReset reset_sink
set_interface_property interrupt_sender bridgedReceiverOffset ""
set_interface_property interrupt_sender bridgesToReceiver ""
set_interface_property interrupt_sender ENABLED true
set_interface_property interrupt_sender EXPORT_OF ""
set_interface_property interrupt_sender PORT_NAME_MAP ""
set_interface_property interrupt_sender CMSIS_SVD_VARIABLES ""
set_interface_property interrupt_sender SVD_ADDRESS_GROUP ""

add_interface_port interrupt_sender irq irq Output 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock clock
set_interface_property conduit_end associatedReset reset_sink
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end CMSIS_SVD_VARIABLES ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end tx_out_fpga1 tx_out_fpga1 Output 2
add_interface_port conduit_end tx_outclock_fpga1 tx_outclock_fpga1 Output 1
add_interface_port conduit_end tx_outclock_fpga2 tx_outclock_fpga2 Output 1
add_interface_port conduit_end tx_align_done_fpga1 tx_align_done_fpga1 Input 1
add_interface_port conduit_end rx_in_fpga1 rx_in_fpga1 Input 2
add_interface_port conduit_end rx_inclock_fpga1 rx_inclock_fpga1 Input 1
add_interface_port conduit_end rx_align_done_fpga1 rx_align_done_fpga1 Output 1
add_interface_port conduit_end tx_out_fpga2 tx_out_fpga2 Output 2
add_interface_port conduit_end tx_align_done_fpga2 tx_align_done_fpga2 Input 1
add_interface_port conduit_end rx_in_fpga2 rx_in_fpga2 Input 2
add_interface_port conduit_end rx_inclock_fpga2 rx_inclock_fpga2 Input 1
add_interface_port conduit_end rx_align_done_fpga2 rx_align_done_fpga2 Output 1
add_interface_port conduit_end led_out led_out Output 8
