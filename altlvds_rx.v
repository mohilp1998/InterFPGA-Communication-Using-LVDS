//START_MODULE_NAME----------------------------------------------------
//
// Module Name     :    altlvds_rx
//
// Description     :   Low Voltage Differential Signaling (LVDS) receiver
//                     megafunction. The altlvds_rx megafunction implements a
//                     deserialization receiver. LVDS is a high speed IO interface
//                     that uses inputs without a reference voltage. LVDS uses
//                     two wires carrying differential values to create a single
//                     channel. These wires are connected to two pins on
//                     supported device to create a single LVDS channel
//
// Limitation      :   Only available for STRATIX,
//                     STRATIX GX, Stratix II, Cyclone and Cyclone II families.
//
// Results expected:   output clock, deserialized output data and pll locked
//                     signal.
//
//END_MODULE_NAME----------------------------------------------------

// BEGINNING OF MODULE
`timescale 1 ps / 1 ps

// MODULE DECLARATION
module altlvds_rx (
    rx_in,
    rx_inclock,
    rx_syncclock,
    rx_dpaclock,
    rx_readclock,
    rx_enable,
    rx_deskew,
    rx_pll_enable,
    rx_data_align,
    rx_data_align_reset,
    rx_reset,
    rx_dpll_reset,
    rx_dpll_hold,
    rx_dpll_enable,
    rx_fifo_reset,
    rx_channel_data_align,
    rx_cda_reset,
    rx_coreclk,
    pll_areset,
    pll_phasedone,
    dpa_pll_recal,
    rx_dpa_lock_reset,
    rx_out,
    rx_outclock,
    rx_locked,
    rx_dpa_locked,
    rx_cda_max,
    rx_divfwdclk,
    pll_phasestep,
    pll_phaseupdown,
    pll_phasecounterselect,
    pll_scanclk,
    dpa_pll_cal_busy,
    rx_data_reset
);

// GLOBAL PARAMETER DECLARATION
    parameter number_of_channels = 1;
    parameter deserialization_factor = 4;
    parameter registered_output = "ON";
    parameter inclock_period = 10000;
    parameter inclock_boost = deserialization_factor;
    parameter cds_mode = "UNUSED";
    parameter intended_device_family = "Stratix";
    parameter input_data_rate =0;
    parameter inclock_data_alignment = "UNUSED";
    parameter registered_data_align_input = "ON";
    parameter common_rx_tx_pll = "ON";
    parameter enable_dpa_mode = "OFF";
    parameter enable_dpa_calibration = "ON";
    parameter enable_dpa_pll_calibration = "OFF";
    parameter enable_dpa_fifo = "ON";
    parameter use_dpll_rawperror = "OFF";
    parameter use_coreclock_input = "OFF";
    parameter dpll_lock_count = 0;
    parameter dpll_lock_window = 0;
    parameter outclock_resource = "AUTO";
    parameter data_align_rollover = deserialization_factor;
    parameter lose_lock_on_one_change ="OFF" ;
    parameter reset_fifo_at_first_lock ="ON" ;
    parameter use_external_pll = "OFF";
    parameter implement_in_les = "OFF";
    parameter buffer_implementation = "RAM";
    parameter port_rx_data_align = "PORT_CONNECTIVITY";
    parameter port_rx_channel_data_align = "PORT_CONNECTIVITY";
    parameter pll_operation_mode = "NORMAL";
    parameter x_on_bitslip = "ON";
    parameter use_no_phase_shift = "ON";
    parameter rx_align_data_reg = "RISING_EDGE";
    parameter inclock_phase_shift = 0;
    parameter enable_soft_cdr_mode = "OFF";
    parameter sim_dpa_output_clock_phase_shift = 0;
    parameter sim_dpa_is_negative_ppm_drift = "OFF";
    parameter sim_dpa_net_ppm_variation = 0;
    parameter enable_dpa_align_to_rising_edge_only = "OFF";
    parameter enable_dpa_initial_phase_selection = "OFF";
    parameter dpa_initial_phase_value = 0;
    parameter pll_self_reset_on_loss_lock = "OFF";
    parameter refclk_frequency = "UNUSED";

parameter enable_clock_pin_mode = "UNUSED";
    parameter data_rate = "UNUSED";
    parameter lpm_hint = "UNUSED";
    parameter lpm_type = "altlvds_rx";

// LOCAL_PARAMETERS_BEGIN

    // Specifies whether the source of the input clock is from a PLL
    parameter clk_src_is_pll = "off";

    // A STRATIX type of LVDS?
    parameter STRATIX_RX_STYLE =  (((((intended_device_family == "Stratix") || (intended_device_family == "STRATIX") || (intended_device_family == "stratix") || (intended_device_family == "Yeager") || (intended_device_family == "YEAGER") || (intended_device_family == "yeager"))
                                )) ||
                                ((((intended_device_family == "Stratix GX") || (intended_device_family == "STRATIX GX") || (intended_device_family == "stratix gx") || (intended_device_family == "Stratix-GX") || (intended_device_family == "STRATIX-GX") || (intended_device_family == "stratix-gx") || (intended_device_family == "StratixGX") || (intended_device_family == "STRATIXGX") || (intended_device_family == "stratixgx") || (intended_device_family == "Aurora") || (intended_device_family == "AURORA") || (intended_device_family == "aurora"))
                                ) &&
                                (enable_dpa_mode == "OFF")))
                                ? 1 : 0;

    // A STRATIXGX DPA type of LVDS?
    parameter STRATIXGX_DPA_RX_STYLE =((((intended_device_family == "Stratix GX") || (intended_device_family == "STRATIX GX") || (intended_device_family == "stratix gx") || (intended_device_family == "Stratix-GX") || (intended_device_family == "STRATIX-GX") || (intended_device_family == "stratix-gx") || (intended_device_family == "StratixGX") || (intended_device_family == "STRATIXGX") || (intended_device_family == "stratixgx") || (intended_device_family == "Aurora") || (intended_device_family == "AURORA") || (intended_device_family == "aurora"))
                                ) &&
                                (enable_dpa_mode == "ON"))
                                ? 1 : 0;

    // A STRATIX II type of LVDS?
    parameter STRATIXII_RX_STYLE = ((((intended_device_family == "Stratix II") || (intended_device_family == "STRATIX II") || (intended_device_family == "stratix ii") || (intended_device_family == "StratixII") || (intended_device_family == "STRATIXII") || (intended_device_family == "stratixii") || (intended_device_family == "Armstrong") || (intended_device_family == "ARMSTRONG") || (intended_device_family == "armstrong"))
                                || ((intended_device_family == "HardCopy II") || (intended_device_family == "HARDCOPY II") || (intended_device_family == "hardcopy ii") || (intended_device_family == "HardCopyII") || (intended_device_family == "HARDCOPYII") || (intended_device_family == "hardcopyii") || (intended_device_family == "Fusion") || (intended_device_family == "FUSION") || (intended_device_family == "fusion"))
                                || (((intended_device_family == "Stratix II GX") || (intended_device_family == "STRATIX II GX") || (intended_device_family == "stratix ii gx") || (intended_device_family == "StratixIIGX") || (intended_device_family == "STRATIXIIGX") || (intended_device_family == "stratixiigx"))
                                || ((intended_device_family == "Arria GX") || (intended_device_family == "ARRIA GX") || (intended_device_family == "arria gx") || (intended_device_family == "ArriaGX") || (intended_device_family == "ARRIAGX") || (intended_device_family == "arriagx") || (intended_device_family == "Stratix II GX Lite") || (intended_device_family == "STRATIX II GX LITE") || (intended_device_family == "stratix ii gx lite") || (intended_device_family == "StratixIIGXLite") || (intended_device_family == "STRATIXIIGXLITE") || (intended_device_family == "stratixiigxlite"))
                                ) ))
                                ? 1 : 0;

    // A Cyclone type of LVDS?
    parameter CYCLONE_RX_STYLE = ((((intended_device_family == "Cyclone") || (intended_device_family == "CYCLONE") || (intended_device_family == "cyclone") || (intended_device_family == "ACEX2K") || (intended_device_family == "acex2k") || (intended_device_family == "ACEX 2K") || (intended_device_family == "acex 2k") || (intended_device_family == "Tornado") || (intended_device_family == "TORNADO") || (intended_device_family == "tornado"))
                                ))
                                ? 1 : 0;

    // A Cyclone II type of LVDS?
    parameter CYCLONEII_RX_STYLE = ((((intended_device_family == "Cyclone II") || (intended_device_family == "CYCLONE II") || (intended_device_family == "cyclone ii") || (intended_device_family == "Cycloneii") || (intended_device_family == "CYCLONEII") || (intended_device_family == "cycloneii") || (intended_device_family == "Magellan") || (intended_device_family == "MAGELLAN") || (intended_device_family == "magellan") || (intended_device_family == "CycloneII") || (intended_device_family == "CYCLONEII") || (intended_device_family == "cycloneii"))
                                ))
                                ? 1 : 0;

    // A Stratix III type of LVDS?
    parameter STRATIXIII_RX_STYLE = ((((intended_device_family == "Stratix III") || (intended_device_family == "STRATIX III") || (intended_device_family == "stratix iii") || (intended_device_family == "StratixIII") || (intended_device_family == "STRATIXIII") || (intended_device_family == "stratixiii") || (intended_device_family == "Titan") || (intended_device_family == "TITAN") || (intended_device_family == "titan") || (intended_device_family == "SIII") || (intended_device_family == "siii"))
                                || (((intended_device_family == "Stratix IV") || (intended_device_family == "STRATIX IV") || (intended_device_family == "stratix iv") || (intended_device_family == "TGX") || (intended_device_family == "tgx") || (intended_device_family == "StratixIV") || (intended_device_family == "STRATIXIV") || (intended_device_family == "stratixiv") || (intended_device_family == "Stratix IV (GT)") || (intended_device_family == "STRATIX IV (GT)") || (intended_device_family == "stratix iv (gt)") || (intended_device_family == "Stratix IV (GX)") || (intended_device_family == "STRATIX IV (GX)") || (intended_device_family == "stratix iv (gx)") || (intended_device_family == "Stratix IV (E)") || (intended_device_family == "STRATIX IV (E)") || (intended_device_family == "stratix iv (e)") || (intended_device_family == "StratixIV(GT)") || (intended_device_family == "STRATIXIV(GT)") || (intended_device_family == "stratixiv(gt)") || (intended_device_family == "StratixIV(GX)") || (intended_device_family == "STRATIXIV(GX)") || (intended_device_family == "stratixiv(gx)") || (intended_device_family == "StratixIV(E)") || (intended_device_family == "STRATIXIV(E)") || (intended_device_family == "stratixiv(e)") || (intended_device_family == "StratixIIIGX") || (intended_device_family == "STRATIXIIIGX") || (intended_device_family == "stratixiiigx") || (intended_device_family == "Stratix IV (GT/GX/E)") || (intended_device_family == "STRATIX IV (GT/GX/E)") || (intended_device_family == "stratix iv (gt/gx/e)") || (intended_device_family == "Stratix IV (GT/E/GX)") || (intended_device_family == "STRATIX IV (GT/E/GX)") || (intended_device_family == "stratix iv (gt/e/gx)") || (intended_device_family == "Stratix IV (E/GT/GX)") || (intended_device_family == "STRATIX IV (E/GT/GX)") || (intended_device_family == "stratix iv (e/gt/gx)") || (intended_device_family == "Stratix IV (E/GX/GT)") || (intended_device_family == "STRATIX IV (E/GX/GT)") || (intended_device_family == "stratix iv (e/gx/gt)") || (intended_device_family == "StratixIV(GT/GX/E)") || (intended_device_family == "STRATIXIV(GT/GX/E)") || (intended_device_family == "stratixiv(gt/gx/e)") || (intended_device_family == "StratixIV(GT/E/GX)") || (intended_device_family == "STRATIXIV(GT/E/GX)") || (intended_device_family == "stratixiv(gt/e/gx)") || (intended_device_family == "StratixIV(E/GX/GT)") || (intended_device_family == "STRATIXIV(E/GX/GT)") || (intended_device_family == "stratixiv(e/gx/gt)") || (intended_device_family == "StratixIV(E/GT/GX)") || (intended_device_family == "STRATIXIV(E/GT/GX)") || (intended_device_family == "stratixiv(e/gt/gx)") || (intended_device_family == "Stratix IV (GX/E)") || (intended_device_family == "STRATIX IV (GX/E)") || (intended_device_family == "stratix iv (gx/e)") || (intended_device_family == "StratixIV(GX/E)") || (intended_device_family == "STRATIXIV(GX/E)") || (intended_device_family == "stratixiv(gx/e)"))
                                || ((intended_device_family == "Arria II GX") || (intended_device_family == "ARRIA II GX") || (intended_device_family == "arria ii gx") || (intended_device_family == "ArriaIIGX") || (intended_device_family == "ARRIAIIGX") || (intended_device_family == "arriaiigx") || (intended_device_family == "Arria IIGX") || (intended_device_family == "ARRIA IIGX") || (intended_device_family == "arria iigx") || (intended_device_family == "ArriaII GX") || (intended_device_family == "ARRIAII GX") || (intended_device_family == "arriaii gx") || (intended_device_family == "Arria II") || (intended_device_family == "ARRIA II") || (intended_device_family == "arria ii") || (intended_device_family == "ArriaII") || (intended_device_family == "ARRIAII") || (intended_device_family == "arriaii") || (intended_device_family == "Arria II (GX/E)") || (intended_device_family == "ARRIA II (GX/E)") || (intended_device_family == "arria ii (gx/e)") || (intended_device_family == "ArriaII(GX/E)") || (intended_device_family == "ARRIAII(GX/E)") || (intended_device_family == "arriaii(gx/e)") || (intended_device_family == "PIRANHA") || (intended_device_family == "piranha"))
                                || (((intended_device_family == "HardCopy IV") || (intended_device_family == "HARDCOPY IV") || (intended_device_family == "hardcopy iv") || (intended_device_family == "HardCopyIV") || (intended_device_family == "HARDCOPYIV") || (intended_device_family == "hardcopyiv") || (intended_device_family == "HardCopy IV (GX)") || (intended_device_family == "HARDCOPY IV (GX)") || (intended_device_family == "hardcopy iv (gx)") || (intended_device_family == "HardCopy IV (E)") || (intended_device_family == "HARDCOPY IV (E)") || (intended_device_family == "hardcopy iv (e)") || (intended_device_family == "HardCopyIV(GX)") || (intended_device_family == "HARDCOPYIV(GX)") || (intended_device_family == "hardcopyiv(gx)") || (intended_device_family == "HardCopyIV(E)") || (intended_device_family == "HARDCOPYIV(E)") || (intended_device_family == "hardcopyiv(e)") || (intended_device_family == "HCXIV") || (intended_device_family == "hcxiv") || (intended_device_family == "HardCopy IV (GX/E)") || (intended_device_family == "HARDCOPY IV (GX/E)") || (intended_device_family == "hardcopy iv (gx/e)") || (intended_device_family == "HardCopy IV (E/GX)") || (intended_device_family == "HARDCOPY IV (E/GX)") || (intended_device_family == "hardcopy iv (e/gx)") || (intended_device_family == "HardCopyIV(GX/E)") || (intended_device_family == "HARDCOPYIV(GX/E)") || (intended_device_family == "hardcopyiv(gx/e)") || (intended_device_family == "HardCopyIV(E/GX)") || (intended_device_family == "HARDCOPYIV(E/GX)") || (intended_device_family == "hardcopyiv(e/gx)"))
                                || ((intended_device_family == "HardCopy IV") || (intended_device_family == "HARDCOPY IV") || (intended_device_family == "hardcopy iv") || (intended_device_family == "HardCopyIV") || (intended_device_family == "HARDCOPYIV") || (intended_device_family == "hardcopyiv") || (intended_device_family == "HardCopy IV (GX)") || (intended_device_family == "HARDCOPY IV (GX)") || (intended_device_family == "hardcopy iv (gx)") || (intended_device_family == "HardCopy IV (E)") || (intended_device_family == "HARDCOPY IV (E)") || (intended_device_family == "hardcopy iv (e)") || (intended_device_family == "HardCopyIV(GX)") || (intended_device_family == "HARDCOPYIV(GX)") || (intended_device_family == "hardcopyiv(gx)") || (intended_device_family == "HardCopyIV(E)") || (intended_device_family == "HARDCOPYIV(E)") || (intended_device_family == "hardcopyiv(e)") || (intended_device_family == "HCXIV") || (intended_device_family == "hcxiv") || (intended_device_family == "HardCopy IV (GX/E)") || (intended_device_family == "HARDCOPY IV (GX/E)") || (intended_device_family == "hardcopy iv (gx/e)") || (intended_device_family == "HardCopy IV (E/GX)") || (intended_device_family == "HARDCOPY IV (E/GX)") || (intended_device_family == "hardcopy iv (e/gx)") || (intended_device_family == "HardCopyIV(GX/E)") || (intended_device_family == "HARDCOPYIV(GX/E)") || (intended_device_family == "hardcopyiv(gx/e)") || (intended_device_family == "HardCopyIV(E/GX)") || (intended_device_family == "HARDCOPYIV(E/GX)") || (intended_device_family == "hardcopyiv(e/gx)"))
                                ) || (((intended_device_family == "Stratix V") || (intended_device_family == "STRATIX V") || (intended_device_family == "stratix v") || (intended_device_family == "StratixV") || (intended_device_family == "STRATIXV") || (intended_device_family == "stratixv") || (intended_device_family == "Stratix V (GS)") || (intended_device_family == "STRATIX V (GS)") || (intended_device_family == "stratix v (gs)") || (intended_device_family == "StratixV(GS)") || (intended_device_family == "STRATIXV(GS)") || (intended_device_family == "stratixv(gs)") || (intended_device_family == "Stratix V (GT)") || (intended_device_family == "STRATIX V (GT)") || (intended_device_family == "stratix v (gt)") || (intended_device_family == "StratixV(GT)") || (intended_device_family == "STRATIXV(GT)") || (intended_device_family == "stratixv(gt)") || (intended_device_family == "Stratix V (GX)") || (intended_device_family == "STRATIX V (GX)") || (intended_device_family == "stratix v (gx)") || (intended_device_family == "StratixV(GX)") || (intended_device_family == "STRATIXV(GX)") || (intended_device_family == "stratixv(gx)") || (intended_device_family == "Stratix V (GS/GX)") || (intended_device_family == "STRATIX V (GS/GX)") || (intended_device_family == "stratix v (gs/gx)") || (intended_device_family == "StratixV(GS/GX)") || (intended_device_family == "STRATIXV(GS/GX)") || (intended_device_family == "stratixv(gs/gx)") || (intended_device_family == "Stratix V (GS/GT)") || (intended_device_family == "STRATIX V (GS/GT)") || (intended_device_family == "stratix v (gs/gt)") || (intended_device_family == "StratixV(GS/GT)") || (intended_device_family == "STRATIXV(GS/GT)") || (intended_device_family == "stratixv(gs/gt)") || (intended_device_family == "Stratix V (GT/GX)") || (intended_device_family == "STRATIX V (GT/GX)") || (intended_device_family == "stratix v (gt/gx)") || (intended_device_family == "StratixV(GT/GX)") || (intended_device_family == "STRATIXV(GT/GX)") || (intended_device_family == "stratixv(gt/gx)") || (intended_device_family == "Stratix V (GX/GS)") || (intended_device_family == "STRATIX V (GX/GS)") || (intended_device_family == "stratix v (gx/gs)") || (intended_device_family == "StratixV(GX/GS)") || (intended_device_family == "STRATIXV(GX/GS)") || (intended_device_family == "stratixv(gx/gs)") || (intended_device_family == "Stratix V (GT/GS)") || (intended_device_family == "STRATIX V (GT/GS)") || (intended_device_family == "stratix v (gt/gs)") || (intended_device_family == "StratixV(GT/GS)") || (intended_device_family == "STRATIXV(GT/GS)") || (intended_device_family == "stratixv(gt/gs)") || (intended_device_family == "Stratix V (GX/GT)") || (intended_device_family == "STRATIX V (GX/GT)") || (intended_device_family == "stratix v (gx/gt)") || (intended_device_family == "StratixV(GX/GT)") || (intended_device_family == "STRATIXV(GX/GT)") || (intended_device_family == "stratixv(gx/gt)") || (intended_device_family == "Stratix V (GS/GT/GX)") || (intended_device_family == "STRATIX V (GS/GT/GX)") || (intended_device_family == "stratix v (gs/gt/gx)") || (intended_device_family == "Stratix V (GS/GX/GT)") || (intended_device_family == "STRATIX V (GS/GX/GT)") || (intended_device_family == "stratix v (gs/gx/gt)") || (intended_device_family == "Stratix V (GT/GS/GX)") || (intended_device_family == "STRATIX V (GT/GS/GX)") || (intended_device_family == "stratix v (gt/gs/gx)") || (intended_device_family == "Stratix V (GT/GX/GS)") || (intended_device_family == "STRATIX V (GT/GX/GS)") || (intended_device_family == "stratix v (gt/gx/gs)") || (intended_device_family == "Stratix V (GX/GS/GT)") || (intended_device_family == "STRATIX V (GX/GS/GT)") || (intended_device_family == "stratix v (gx/gs/gt)") || (intended_device_family == "Stratix V (GX/GT/GS)") || (intended_device_family == "STRATIX V (GX/GT/GS)") || (intended_device_family == "stratix v (gx/gt/gs)") || (intended_device_family == "StratixV(GS/GT/GX)") || (intended_device_family == "STRATIXV(GS/GT/GX)") || (intended_device_family == "stratixv(gs/gt/gx)") || (intended_device_family == "StratixV(GS/GX/GT)") || (intended_device_family == "STRATIXV(GS/GX/GT)") || (intended_device_family == "stratixv(gs/gx/gt)") || (intended_device_family == "StratixV(GT/GS/GX)") || (intended_device_family == "STRATIXV(GT/GS/GX)") || (intended_device_family == "stratixv(gt/gs/gx)") || (intended_device_family == "StratixV(GT/GX/GS)") || (intended_device_family == "STRATIXV(GT/GX/GS)") || (intended_device_family == "stratixv(gt/gx/gs)") || (intended_device_family == "StratixV(GX/GS/GT)") || (intended_device_family == "STRATIXV(GX/GS/GT)") || (intended_device_family == "stratixv(gx/gs/gt)") || (intended_device_family == "StratixV(GX/GT/GS)") || (intended_device_family == "STRATIXV(GX/GT/GS)") || (intended_device_family == "stratixv(gx/gt/gs)") || (intended_device_family == "Stratix V (GS/GT/GX/E)") || (intended_device_family == "STRATIX V (GS/GT/GX/E)") || (intended_device_family == "stratix v (gs/gt/gx/e)") || (intended_device_family == "StratixV(GS/GT/GX/E)") || (intended_device_family == "STRATIXV(GS/GT/GX/E)") || (intended_device_family == "stratixv(gs/gt/gx/e)") || (intended_device_family == "Stratix V (E)") || (intended_device_family == "STRATIX V (E)") || (intended_device_family == "stratix v (e)") || (intended_device_family == "StratixV(E)") || (intended_device_family == "STRATIXV(E)") || (intended_device_family == "stratixv(e)"))
                                || (((intended_device_family == "Arria V GZ") || (intended_device_family == "ARRIA V GZ") || (intended_device_family == "arria v gz") || (intended_device_family == "ArriaVGZ") || (intended_device_family == "ARRIAVGZ") || (intended_device_family == "arriavgz"))
                                ) ) || (((intended_device_family == "Arria V") || (intended_device_family == "ARRIA V") || (intended_device_family == "arria v") || (intended_device_family == "Arria V (GT/GX)") || (intended_device_family == "ARRIA V (GT/GX)") || (intended_device_family == "arria v (gt/gx)") || (intended_device_family == "ArriaV(GT/GX)") || (intended_device_family == "ARRIAV(GT/GX)") || (intended_device_family == "arriav(gt/gx)") || (intended_device_family == "ArriaV") || (intended_device_family == "ARRIAV") || (intended_device_family == "arriav") || (intended_device_family == "Arria V (GT/GX/ST/SX)") || (intended_device_family == "ARRIA V (GT/GX/ST/SX)") || (intended_device_family == "arria v (gt/gx/st/sx)") || (intended_device_family == "ArriaV(GT/GX/ST/SX)") || (intended_device_family == "ARRIAV(GT/GX/ST/SX)") || (intended_device_family == "arriav(gt/gx/st/sx)") || (intended_device_family == "Arria V (GT)") || (intended_device_family == "ARRIA V (GT)") || (intended_device_family == "arria v (gt)") || (intended_device_family == "ArriaV(GT)") || (intended_device_family == "ARRIAV(GT)") || (intended_device_family == "arriav(gt)") || (intended_device_family == "Arria V (GX)") || (intended_device_family == "ARRIA V (GX)") || (intended_device_family == "arria v (gx)") || (intended_device_family == "ArriaV(GX)") || (intended_device_family == "ARRIAV(GX)") || (intended_device_family == "arriav(gx)") || (intended_device_family == "Arria V (ST)") || (intended_device_family == "ARRIA V (ST)") || (intended_device_family == "arria v (st)") || (intended_device_family == "ArriaV(ST)") || (intended_device_family == "ARRIAV(ST)") || (intended_device_family == "arriav(st)") || (intended_device_family == "Arria V (SX)") || (intended_device_family == "ARRIA V (SX)") || (intended_device_family == "arria v (sx)") || (intended_device_family == "ArriaV(SX)") || (intended_device_family == "ARRIAV(SX)") || (intended_device_family == "arriav(sx)"))
                                || (((intended_device_family == "Cyclone V") || (intended_device_family == "CYCLONE V") || (intended_device_family == "cyclone v") || (intended_device_family == "CycloneV") || (intended_device_family == "CYCLONEV") || (intended_device_family == "cyclonev") || (intended_device_family == "Cyclone V (GT/GX/E/SX)") || (intended_device_family == "CYCLONE V (GT/GX/E/SX)") || (intended_device_family == "cyclone v (gt/gx/e/sx)") || (intended_device_family == "CycloneV(GT/GX/E/SX)") || (intended_device_family == "CYCLONEV(GT/GX/E/SX)") || (intended_device_family == "cyclonev(gt/gx/e/sx)") || (intended_device_family == "Cyclone V (E/GX/GT/SX/SE/ST)") || (intended_device_family == "CYCLONE V (E/GX/GT/SX/SE/ST)") || (intended_device_family == "cyclone v (e/gx/gt/sx/se/st)") || (intended_device_family == "CycloneV(E/GX/GT/SX/SE/ST)") || (intended_device_family == "CYCLONEV(E/GX/GT/SX/SE/ST)") || (intended_device_family == "cyclonev(e/gx/gt/sx/se/st)") || (intended_device_family == "Cyclone V (E)") || (intended_device_family == "CYCLONE V (E)") || (intended_device_family == "cyclone v (e)") || (intended_device_family == "CycloneV(E)") || (intended_device_family == "CYCLONEV(E)") || (intended_device_family == "cyclonev(e)") || (intended_device_family == "Cyclone V (GX)") || (intended_device_family == "CYCLONE V (GX)") || (intended_device_family == "cyclone v (gx)") || (intended_device_family == "CycloneV(GX)") || (intended_device_family == "CYCLONEV(GX)") || (intended_device_family == "cyclonev(gx)") || (intended_device_family == "Cyclone V (GT)") || (intended_device_family == "CYCLONE V (GT)") || (intended_device_family == "cyclone v (gt)") || (intended_device_family == "CycloneV(GT)") || (intended_device_family == "CYCLONEV(GT)") || (intended_device_family == "cyclonev(gt)") || (intended_device_family == "Cyclone V (SX)") || (intended_device_family == "CYCLONE V (SX)") || (intended_device_family == "cyclone v (sx)") || (intended_device_family == "CycloneV(SX)") || (intended_device_family == "CYCLONEV(SX)") || (intended_device_family == "cyclonev(sx)") || (intended_device_family == "Cyclone V (SE)") || (intended_device_family == "CYCLONE V (SE)") || (intended_device_family == "cyclone v (se)") || (intended_device_family == "CycloneV(SE)") || (intended_device_family == "CYCLONEV(SE)") || (intended_device_family == "cyclonev(se)") || (intended_device_family == "Cyclone V (ST)") || (intended_device_family == "CYCLONE V (ST)") || (intended_device_family == "cyclone v (st)") || (intended_device_family == "CycloneV(ST)") || (intended_device_family == "CYCLONEV(ST)") || (intended_device_family == "cyclonev(st)"))
                                ) ) || (((intended_device_family == "Arria II GZ") || (intended_device_family == "ARRIA II GZ") || (intended_device_family == "arria ii gz") || (intended_device_family == "ArriaII GZ") || (intended_device_family == "ARRIAII GZ") || (intended_device_family == "arriaii gz") || (intended_device_family == "Arria IIGZ") || (intended_device_family == "ARRIA IIGZ") || (intended_device_family == "arria iigz") || (intended_device_family == "ArriaIIGZ") || (intended_device_family == "ARRIAIIGZ") || (intended_device_family == "arriaiigz"))
                                ) || (((intended_device_family == "Arria 10") || (intended_device_family == "ARRIA 10") || (intended_device_family == "arria 10") || (intended_device_family == "Arria10") || (intended_device_family == "ARRIA10") || (intended_device_family == "arria10") || (intended_device_family == "Arria VI") || (intended_device_family == "ARRIA VI") || (intended_device_family == "arria vi") || (intended_device_family == "ArriaVI") || (intended_device_family == "ARRIAVI") || (intended_device_family == "arriavi") || (intended_device_family == "Night Fury") || (intended_device_family == "NIGHT FURY") || (intended_device_family == "night fury") || (intended_device_family == "nightfury") || (intended_device_family == "NIGHTFURY") || (intended_device_family == "Arria 10 (GX/SX/GT)") || (intended_device_family == "ARRIA 10 (GX/SX/GT)") || (intended_device_family == "arria 10 (gx/sx/gt)") || (intended_device_family == "Arria10(GX/SX/GT)") || (intended_device_family == "ARRIA10(GX/SX/GT)") || (intended_device_family == "arria10(gx/sx/gt)") || (intended_device_family == "Arria 10 (GX)") || (intended_device_family == "ARRIA 10 (GX)") || (intended_device_family == "arria 10 (gx)") || (intended_device_family == "Arria10(GX)") || (intended_device_family == "ARRIA10(GX)") || (intended_device_family == "arria10(gx)") || (intended_device_family == "Arria 10 (SX)") || (intended_device_family == "ARRIA 10 (SX)") || (intended_device_family == "arria 10 (sx)") || (intended_device_family == "Arria10(SX)") || (intended_device_family == "ARRIA10(SX)") || (intended_device_family == "arria10(sx)") || (intended_device_family == "Arria 10 (GT)") || (intended_device_family == "ARRIA 10 (GT)") || (intended_device_family == "arria 10 (gt)") || (intended_device_family == "Arria10(GT)") || (intended_device_family == "ARRIA10(GT)") || (intended_device_family == "arria10(gt)"))
                                || ((intended_device_family == "Arria 10") || (intended_device_family == "ARRIA 10") || (intended_device_family == "arria 10") || (intended_device_family == "Arria10") || (intended_device_family == "ARRIA10") || (intended_device_family == "arria10") || (intended_device_family == "Arria VI") || (intended_device_family == "ARRIA VI") || (intended_device_family == "arria vi") || (intended_device_family == "ArriaVI") || (intended_device_family == "ARRIAVI") || (intended_device_family == "arriavi") || (intended_device_family == "Night Fury") || (intended_device_family == "NIGHT FURY") || (intended_device_family == "night fury") || (intended_device_family == "nightfury") || (intended_device_family == "NIGHTFURY") || (intended_device_family == "Arria 10 (GX/SX/GT)") || (intended_device_family == "ARRIA 10 (GX/SX/GT)") || (intended_device_family == "arria 10 (gx/sx/gt)") || (intended_device_family == "Arria10(GX/SX/GT)") || (intended_device_family == "ARRIA10(GX/SX/GT)") || (intended_device_family == "arria10(gx/sx/gt)") || (intended_device_family == "Arria 10 (GX)") || (intended_device_family == "ARRIA 10 (GX)") || (intended_device_family == "arria 10 (gx)") || (intended_device_family == "Arria10(GX)") || (intended_device_family == "ARRIA10(GX)") || (intended_device_family == "arria10(gx)") || (intended_device_family == "Arria 10 (SX)") || (intended_device_family == "ARRIA 10 (SX)") || (intended_device_family == "arria 10 (sx)") || (intended_device_family == "Arria10(SX)") || (intended_device_family == "ARRIA10(SX)") || (intended_device_family == "arria10(sx)") || (intended_device_family == "Arria 10 (GT)") || (intended_device_family == "ARRIA 10 (GT)") || (intended_device_family == "arria 10 (gt)") || (intended_device_family == "Arria10(GT)") || (intended_device_family == "ARRIA10(GT)") || (intended_device_family == "arria10(gt)"))
                                ) || (((intended_device_family == "Stratix 10") || (intended_device_family == "STRATIX 10") || (intended_device_family == "stratix 10") || (intended_device_family == "Stratix10") || (intended_device_family == "STRATIX10") || (intended_device_family == "stratix10") || (intended_device_family == "nadder") || (intended_device_family == "NADDER") || (intended_device_family == "Stratix 10 (GX/SX)") || (intended_device_family == "STRATIX 10 (GX/SX)") || (intended_device_family == "stratix 10 (gx/sx)") || (intended_device_family == "Stratix10(GX/SX)") || (intended_device_family == "STRATIX10(GX/SX)") || (intended_device_family == "stratix10(gx/sx)") || (intended_device_family == "Stratix 10 (GX)") || (intended_device_family == "STRATIX 10 (GX)") || (intended_device_family == "stratix 10 (gx)") || (intended_device_family == "Stratix10(GX)") || (intended_device_family == "STRATIX10(GX)") || (intended_device_family == "stratix10(gx)") || (intended_device_family == "Stratix 10 (SX)") || (intended_device_family == "STRATIX 10 (SX)") || (intended_device_family == "stratix 10 (sx)") || (intended_device_family == "Stratix10(SX)") || (intended_device_family == "STRATIX10(SX)") || (intended_device_family == "stratix10(sx)"))
                                || ((intended_device_family == "Stratix 10") || (intended_device_family == "STRATIX 10") || (intended_device_family == "stratix 10") || (intended_device_family == "Stratix10") || (intended_device_family == "STRATIX10") || (intended_device_family == "stratix10") || (intended_device_family == "nadder") || (intended_device_family == "NADDER") || (intended_device_family == "Stratix 10 (GX/SX)") || (intended_device_family == "STRATIX 10 (GX/SX)") || (intended_device_family == "stratix 10 (gx/sx)") || (intended_device_family == "Stratix10(GX/SX)") || (intended_device_family == "STRATIX10(GX/SX)") || (intended_device_family == "stratix10(gx/sx)") || (intended_device_family == "Stratix 10 (GX)") || (intended_device_family == "STRATIX 10 (GX)") || (intended_device_family == "stratix 10 (gx)") || (intended_device_family == "Stratix10(GX)") || (intended_device_family == "STRATIX10(GX)") || (intended_device_family == "stratix10(gx)") || (intended_device_family == "Stratix 10 (SX)") || (intended_device_family == "STRATIX 10 (SX)") || (intended_device_family == "stratix 10 (sx)") || (intended_device_family == "Stratix10(SX)") || (intended_device_family == "STRATIX10(SX)") || (intended_device_family == "stratix10(sx)"))
                                ) ) || ((intended_device_family == "HardCopy III") || (intended_device_family == "HARDCOPY III") || (intended_device_family == "hardcopy iii") || (intended_device_family == "HardCopyIII") || (intended_device_family == "HARDCOPYIII") || (intended_device_family == "hardcopyiii") || (intended_device_family == "HCX") || (intended_device_family == "hcx"))
                                ))
                                ? 1 : 0;
    
    // A ARRIA type of LVDS?
    parameter ARRIAII_RX_STYLE = ((((intended_device_family == "Arria II GX") || (intended_device_family == "ARRIA II GX") || (intended_device_family == "arria ii gx") || (intended_device_family == "ArriaIIGX") || (intended_device_family == "ARRIAIIGX") || (intended_device_family == "arriaiigx") || (intended_device_family == "Arria IIGX") || (intended_device_family == "ARRIA IIGX") || (intended_device_family == "arria iigx") || (intended_device_family == "ArriaII GX") || (intended_device_family == "ARRIAII GX") || (intended_device_family == "arriaii gx") || (intended_device_family == "Arria II") || (intended_device_family == "ARRIA II") || (intended_device_family == "arria ii") || (intended_device_family == "ArriaII") || (intended_device_family == "ARRIAII") || (intended_device_family == "arriaii") || (intended_device_family == "Arria II (GX/E)") || (intended_device_family == "ARRIA II (GX/E)") || (intended_device_family == "arria ii (gx/e)") || (intended_device_family == "ArriaII(GX/E)") || (intended_device_family == "ARRIAII(GX/E)") || (intended_device_family == "arriaii(gx/e)") || (intended_device_family == "PIRANHA") || (intended_device_family == "piranha"))
                                ))
                                ? 1 : 0;
                                
    // A Stratix V type of LVDS?
    parameter STRATIXV_RX_STYLE = ((((intended_device_family == "Stratix V") || (intended_device_family == "STRATIX V") || (intended_device_family == "stratix v") || (intended_device_family == "StratixV") || (intended_device_family == "STRATIXV") || (intended_device_family == "stratixv") || (intended_device_family == "Stratix V (GS)") || (intended_device_family == "STRATIX V (GS)") || (intended_device_family == "stratix v (gs)") || (intended_device_family == "StratixV(GS)") || (intended_device_family == "STRATIXV(GS)") || (intended_device_family == "stratixv(gs)") || (intended_device_family == "Stratix V (GT)") || (intended_device_family == "STRATIX V (GT)") || (intended_device_family == "stratix v (gt)") || (intended_device_family == "StratixV(GT)") || (intended_device_family == "STRATIXV(GT)") || (intended_device_family == "stratixv(gt)") || (intended_device_family == "Stratix V (GX)") || (intended_device_family == "STRATIX V (GX)") || (intended_device_family == "stratix v (gx)") || (intended_device_family == "StratixV(GX)") || (intended_device_family == "STRATIXV(GX)") || (intended_device_family == "stratixv(gx)") || (intended_device_family == "Stratix V (GS/GX)") || (intended_device_family == "STRATIX V (GS/GX)") || (intended_device_family == "stratix v (gs/gx)") || (intended_device_family == "StratixV(GS/GX)") || (intended_device_family == "STRATIXV(GS/GX)") || (intended_device_family == "stratixv(gs/gx)") || (intended_device_family == "Stratix V (GS/GT)") || (intended_device_family == "STRATIX V (GS/GT)") || (intended_device_family == "stratix v (gs/gt)") || (intended_device_family == "StratixV(GS/GT)") || (intended_device_family == "STRATIXV(GS/GT)") || (intended_device_family == "stratixv(gs/gt)") || (intended_device_family == "Stratix V (GT/GX)") || (intended_device_family == "STRATIX V (GT/GX)") || (intended_device_family == "stratix v (gt/gx)") || (intended_device_family == "StratixV(GT/GX)") || (intended_device_family == "STRATIXV(GT/GX)") || (intended_device_family == "stratixv(gt/gx)") || (intended_device_family == "Stratix V (GX/GS)") || (intended_device_family == "STRATIX V (GX/GS)") || (intended_device_family == "stratix v (gx/gs)") || (intended_device_family == "StratixV(GX/GS)") || (intended_device_family == "STRATIXV(GX/GS)") || (intended_device_family == "stratixv(gx/gs)") || (intended_device_family == "Stratix V (GT/GS)") || (intended_device_family == "STRATIX V (GT/GS)") || (intended_device_family == "stratix v (gt/gs)") || (intended_device_family == "StratixV(GT/GS)") || (intended_device_family == "STRATIXV(GT/GS)") || (intended_device_family == "stratixv(gt/gs)") || (intended_device_family == "Stratix V (GX/GT)") || (intended_device_family == "STRATIX V (GX/GT)") || (intended_device_family == "stratix v (gx/gt)") || (intended_device_family == "StratixV(GX/GT)") || (intended_device_family == "STRATIXV(GX/GT)") || (intended_device_family == "stratixv(gx/gt)") || (intended_device_family == "Stratix V (GS/GT/GX)") || (intended_device_family == "STRATIX V (GS/GT/GX)") || (intended_device_family == "stratix v (gs/gt/gx)") || (intended_device_family == "Stratix V (GS/GX/GT)") || (intended_device_family == "STRATIX V (GS/GX/GT)") || (intended_device_family == "stratix v (gs/gx/gt)") || (intended_device_family == "Stratix V (GT/GS/GX)") || (intended_device_family == "STRATIX V (GT/GS/GX)") || (intended_device_family == "stratix v (gt/gs/gx)") || (intended_device_family == "Stratix V (GT/GX/GS)") || (intended_device_family == "STRATIX V (GT/GX/GS)") || (intended_device_family == "stratix v (gt/gx/gs)") || (intended_device_family == "Stratix V (GX/GS/GT)") || (intended_device_family == "STRATIX V (GX/GS/GT)") || (intended_device_family == "stratix v (gx/gs/gt)") || (intended_device_family == "Stratix V (GX/GT/GS)") || (intended_device_family == "STRATIX V (GX/GT/GS)") || (intended_device_family == "stratix v (gx/gt/gs)") || (intended_device_family == "StratixV(GS/GT/GX)") || (intended_device_family == "STRATIXV(GS/GT/GX)") || (intended_device_family == "stratixv(gs/gt/gx)") || (intended_device_family == "StratixV(GS/GX/GT)") || (intended_device_family == "STRATIXV(GS/GX/GT)") || (intended_device_family == "stratixv(gs/gx/gt)") || (intended_device_family == "StratixV(GT/GS/GX)") || (intended_device_family == "STRATIXV(GT/GS/GX)") || (intended_device_family == "stratixv(gt/gs/gx)") || (intended_device_family == "StratixV(GT/GX/GS)") || (intended_device_family == "STRATIXV(GT/GX/GS)") || (intended_device_family == "stratixv(gt/gx/gs)") || (intended_device_family == "StratixV(GX/GS/GT)") || (intended_device_family == "STRATIXV(GX/GS/GT)") || (intended_device_family == "stratixv(gx/gs/gt)") || (intended_device_family == "StratixV(GX/GT/GS)") || (intended_device_family == "STRATIXV(GX/GT/GS)") || (intended_device_family == "stratixv(gx/gt/gs)") || (intended_device_family == "Stratix V (GS/GT/GX/E)") || (intended_device_family == "STRATIX V (GS/GT/GX/E)") || (intended_device_family == "stratix v (gs/gt/gx/e)") || (intended_device_family == "StratixV(GS/GT/GX/E)") || (intended_device_family == "STRATIXV(GS/GT/GX/E)") || (intended_device_family == "stratixv(gs/gt/gx/e)") || (intended_device_family == "Stratix V (E)") || (intended_device_family == "STRATIX V (E)") || (intended_device_family == "stratix v (e)") || (intended_device_family == "StratixV(E)") || (intended_device_family == "STRATIXV(E)") || (intended_device_family == "stratixv(e)"))
                                || (((intended_device_family == "Arria V GZ") || (intended_device_family == "ARRIA V GZ") || (intended_device_family == "arria v gz") || (intended_device_family == "ArriaVGZ") || (intended_device_family == "ARRIAVGZ") || (intended_device_family == "arriavgz"))
                                ) ))
                                ? 1 : 0;
// cycloneiii_msg
    // A Cyclone III type of LVDS?
    parameter CYCLONEIII_RX_STYLE = ((((intended_device_family == "Cyclone III") || (intended_device_family == "CYCLONE III") || (intended_device_family == "cyclone iii") || (intended_device_family == "CycloneIII") || (intended_device_family == "CYCLONEIII") || (intended_device_family == "cycloneiii") || (intended_device_family == "Barracuda") || (intended_device_family == "BARRACUDA") || (intended_device_family == "barracuda") || (intended_device_family == "Cuda") || (intended_device_family == "CUDA") || (intended_device_family == "cuda") || (intended_device_family == "CIII") || (intended_device_family == "ciii"))
                                || ((intended_device_family == "Cyclone III LS") || (intended_device_family == "CYCLONE III LS") || (intended_device_family == "cyclone iii ls") || (intended_device_family == "CycloneIIILS") || (intended_device_family == "CYCLONEIIILS") || (intended_device_family == "cycloneiiils") || (intended_device_family == "Cyclone III LPS") || (intended_device_family == "CYCLONE III LPS") || (intended_device_family == "cyclone iii lps") || (intended_device_family == "Cyclone LPS") || (intended_device_family == "CYCLONE LPS") || (intended_device_family == "cyclone lps") || (intended_device_family == "CycloneLPS") || (intended_device_family == "CYCLONELPS") || (intended_device_family == "cyclonelps") || (intended_device_family == "Tarpon") || (intended_device_family == "TARPON") || (intended_device_family == "tarpon") || (intended_device_family == "Cyclone IIIE") || (intended_device_family == "CYCLONE IIIE") || (intended_device_family == "cyclone iiie"))
                                || ((intended_device_family == "Cyclone IV GX") || (intended_device_family == "CYCLONE IV GX") || (intended_device_family == "cyclone iv gx") || (intended_device_family == "Cyclone IVGX") || (intended_device_family == "CYCLONE IVGX") || (intended_device_family == "cyclone ivgx") || (intended_device_family == "CycloneIV GX") || (intended_device_family == "CYCLONEIV GX") || (intended_device_family == "cycloneiv gx") || (intended_device_family == "CycloneIVGX") || (intended_device_family == "CYCLONEIVGX") || (intended_device_family == "cycloneivgx") || (intended_device_family == "Cyclone IV") || (intended_device_family == "CYCLONE IV") || (intended_device_family == "cyclone iv") || (intended_device_family == "CycloneIV") || (intended_device_family == "CYCLONEIV") || (intended_device_family == "cycloneiv") || (intended_device_family == "Cyclone IV (GX)") || (intended_device_family == "CYCLONE IV (GX)") || (intended_device_family == "cyclone iv (gx)") || (intended_device_family == "CycloneIV(GX)") || (intended_device_family == "CYCLONEIV(GX)") || (intended_device_family == "cycloneiv(gx)") || (intended_device_family == "Cyclone III GX") || (intended_device_family == "CYCLONE III GX") || (intended_device_family == "cyclone iii gx") || (intended_device_family == "CycloneIII GX") || (intended_device_family == "CYCLONEIII GX") || (intended_device_family == "cycloneiii gx") || (intended_device_family == "Cyclone IIIGX") || (intended_device_family == "CYCLONE IIIGX") || (intended_device_family == "cyclone iiigx") || (intended_device_family == "CycloneIIIGX") || (intended_device_family == "CYCLONEIIIGX") || (intended_device_family == "cycloneiiigx") || (intended_device_family == "Cyclone III GL") || (intended_device_family == "CYCLONE III GL") || (intended_device_family == "cyclone iii gl") || (intended_device_family == "CycloneIII GL") || (intended_device_family == "CYCLONEIII GL") || (intended_device_family == "cycloneiii gl") || (intended_device_family == "Cyclone IIIGL") || (intended_device_family == "CYCLONE IIIGL") || (intended_device_family == "cyclone iiigl") || (intended_device_family == "CycloneIIIGL") || (intended_device_family == "CYCLONEIIIGL") || (intended_device_family == "cycloneiiigl") || (intended_device_family == "Stingray") || (intended_device_family == "STINGRAY") || (intended_device_family == "stingray"))
                                || (((intended_device_family == "Cyclone IV E") || (intended_device_family == "CYCLONE IV E") || (intended_device_family == "cyclone iv e") || (intended_device_family == "CycloneIV E") || (intended_device_family == "CYCLONEIV E") || (intended_device_family == "cycloneiv e") || (intended_device_family == "Cyclone IVE") || (intended_device_family == "CYCLONE IVE") || (intended_device_family == "cyclone ive") || (intended_device_family == "CycloneIVE") || (intended_device_family == "CYCLONEIVE") || (intended_device_family == "cycloneive"))
                                ) || (((intended_device_family == "MAX 10") || (intended_device_family == "max 10") || (intended_device_family == "MAX 10 FPGA") || (intended_device_family == "max 10 fpga") || (intended_device_family == "Zippleback") || (intended_device_family == "ZIPPLEBACK") || (intended_device_family == "zippleback") || (intended_device_family == "MAX10") || (intended_device_family == "max10") || (intended_device_family == "MAX 10 (DA/DF/DC/SA/SC)") || (intended_device_family == "max 10 (da/df/dc/sa/sc)") || (intended_device_family == "MAX10(DA/DF/DC/SA/SC)") || (intended_device_family == "max10(da/df/dc/sa/sc)") || (intended_device_family == "MAX 10 (DA)") || (intended_device_family == "max 10 (da)") || (intended_device_family == "MAX10(DA)") || (intended_device_family == "max10(da)") || (intended_device_family == "MAX 10 (DF)") || (intended_device_family == "max 10 (df)") || (intended_device_family == "MAX10(DF)") || (intended_device_family == "max10(df)") || (intended_device_family == "MAX 10 (DC)") || (intended_device_family == "max 10 (dc)") || (intended_device_family == "MAX10(DC)") || (intended_device_family == "max10(dc)") || (intended_device_family == "MAX 10 (SA)") || (intended_device_family == "max 10 (sa)") || (intended_device_family == "MAX10(SA)") || (intended_device_family == "max10(sa)") || (intended_device_family == "MAX 10 (SC)") || (intended_device_family == "max 10 (sc)") || (intended_device_family == "MAX10(SC)") || (intended_device_family == "max10(sc)"))
                                ) ))
                                ? 1 : 0;
// cycloneiii_msg

    // Is the device family has flexible LVDS?
    parameter FAMILY_HAS_FLEXIBLE_LVDS = ((CYCLONE_RX_STYLE == 1) ||
                                (CYCLONEII_RX_STYLE == 1) ||
                                (CYCLONEIII_RX_STYLE == 1) ||
                                (((STRATIX_RX_STYLE == 1) ||
                                (STRATIXII_RX_STYLE == 1) ||
                                (STRATIXIII_RX_STYLE == 1)) &&
                                (implement_in_les == "ON")))
                                ? 1 : 0;

    // Is the family has Stratix style PLL
    parameter FAMILY_HAS_STRATIX_STYLE_PLL = ((STRATIX_RX_STYLE == 1) ||
                                (STRATIXGX_DPA_RX_STYLE == 1) ||
                                (CYCLONE_RX_STYLE == 1))
                                ? 1 : 0;

    // Is the family has StratixII style PLL
    parameter FAMILY_HAS_STRATIXII_STYLE_PLL = ((STRATIXII_RX_STYLE == 1) ||
                                (CYCLONEII_RX_STYLE == 1))
                                ? 1 : 0;

    // Is the family has StratixIII style PLL
    parameter FAMILY_HAS_STRATIXIII_STYLE_PLL = ((STRATIXIII_RX_STYLE == 1) || (CYCLONEIII_RX_STYLE == 1))
                                ? 1 : 0;

    // calculate clock boost for device family other than STRATIX, STRATIX GX
    // and STRATIX II
    parameter INT_CLOCK_BOOST = ( (inclock_boost == 0)
                                    ? deserialization_factor
                                    : inclock_boost);

    // M value for stratix/stratix II/Cyclone/Cyclone II PLL
    parameter PLL_M_VALUE = (((input_data_rate * inclock_period)
                                    + (5 * 100000)) / 1000000);

    // D value for Stratix/Stratix II/Cyclone/Cyclone II PLL
    parameter PLL_D_VALUE = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                ? ((input_data_rate !=0) && (inclock_period !=0)
                                    ? 2
                                    : 1)
                                : 1;


    //28 NM families, to override the inclock_data_alignment parameter. 
    parameter VSERIES_FAMILY = ((((intended_device_family == "Stratix V") || (intended_device_family == "STRATIX V") || (intended_device_family == "stratix v") || (intended_device_family == "StratixV") || (intended_device_family == "STRATIXV") || (intended_device_family == "stratixv") || (intended_device_family == "Stratix V (GS)") || (intended_device_family == "STRATIX V (GS)") || (intended_device_family == "stratix v (gs)") || (intended_device_family == "StratixV(GS)") || (intended_device_family == "STRATIXV(GS)") || (intended_device_family == "stratixv(gs)") || (intended_device_family == "Stratix V (GT)") || (intended_device_family == "STRATIX V (GT)") || (intended_device_family == "stratix v (gt)") || (intended_device_family == "StratixV(GT)") || (intended_device_family == "STRATIXV(GT)") || (intended_device_family == "stratixv(gt)") || (intended_device_family == "Stratix V (GX)") || (intended_device_family == "STRATIX V (GX)") || (intended_device_family == "stratix v (gx)") || (intended_device_family == "StratixV(GX)") || (intended_device_family == "STRATIXV(GX)") || (intended_device_family == "stratixv(gx)") || (intended_device_family == "Stratix V (GS/GX)") || (intended_device_family == "STRATIX V (GS/GX)") || (intended_device_family == "stratix v (gs/gx)") || (intended_device_family == "StratixV(GS/GX)") || (intended_device_family == "STRATIXV(GS/GX)") || (intended_device_family == "stratixv(gs/gx)") || (intended_device_family == "Stratix V (GS/GT)") || (intended_device_family == "STRATIX V (GS/GT)") || (intended_device_family == "stratix v (gs/gt)") || (intended_device_family == "StratixV(GS/GT)") || (intended_device_family == "STRATIXV(GS/GT)") || (intended_device_family == "stratixv(gs/gt)") || (intended_device_family == "Stratix V (GT/GX)") || (intended_device_family == "STRATIX V (GT/GX)") || (intended_device_family == "stratix v (gt/gx)") || (intended_device_family == "StratixV(GT/GX)") || (intended_device_family == "STRATIXV(GT/GX)") || (intended_device_family == "stratixv(gt/gx)") || (intended_device_family == "Stratix V (GX/GS)") || (intended_device_family == "STRATIX V (GX/GS)") || (intended_device_family == "stratix v (gx/gs)") || (intended_device_family == "StratixV(GX/GS)") || (intended_device_family == "STRATIXV(GX/GS)") || (intended_device_family == "stratixv(gx/gs)") || (intended_device_family == "Stratix V (GT/GS)") || (intended_device_family == "STRATIX V (GT/GS)") || (intended_device_family == "stratix v (gt/gs)") || (intended_device_family == "StratixV(GT/GS)") || (intended_device_family == "STRATIXV(GT/GS)") || (intended_device_family == "stratixv(gt/gs)") || (intended_device_family == "Stratix V (GX/GT)") || (intended_device_family == "STRATIX V (GX/GT)") || (intended_device_family == "stratix v (gx/gt)") || (intended_device_family == "StratixV(GX/GT)") || (intended_device_family == "STRATIXV(GX/GT)") || (intended_device_family == "stratixv(gx/gt)") || (intended_device_family == "Stratix V (GS/GT/GX)") || (intended_device_family == "STRATIX V (GS/GT/GX)") || (intended_device_family == "stratix v (gs/gt/gx)") || (intended_device_family == "Stratix V (GS/GX/GT)") || (intended_device_family == "STRATIX V (GS/GX/GT)") || (intended_device_family == "stratix v (gs/gx/gt)") || (intended_device_family == "Stratix V (GT/GS/GX)") || (intended_device_family == "STRATIX V (GT/GS/GX)") || (intended_device_family == "stratix v (gt/gs/gx)") || (intended_device_family == "Stratix V (GT/GX/GS)") || (intended_device_family == "STRATIX V (GT/GX/GS)") || (intended_device_family == "stratix v (gt/gx/gs)") || (intended_device_family == "Stratix V (GX/GS/GT)") || (intended_device_family == "STRATIX V (GX/GS/GT)") || (intended_device_family == "stratix v (gx/gs/gt)") || (intended_device_family == "Stratix V (GX/GT/GS)") || (intended_device_family == "STRATIX V (GX/GT/GS)") || (intended_device_family == "stratix v (gx/gt/gs)") || (intended_device_family == "StratixV(GS/GT/GX)") || (intended_device_family == "STRATIXV(GS/GT/GX)") || (intended_device_family == "stratixv(gs/gt/gx)") || (intended_device_family == "StratixV(GS/GX/GT)") || (intended_device_family == "STRATIXV(GS/GX/GT)") || (intended_device_family == "stratixv(gs/gx/gt)") || (intended_device_family == "StratixV(GT/GS/GX)") || (intended_device_family == "STRATIXV(GT/GS/GX)") || (intended_device_family == "stratixv(gt/gs/gx)") || (intended_device_family == "StratixV(GT/GX/GS)") || (intended_device_family == "STRATIXV(GT/GX/GS)") || (intended_device_family == "stratixv(gt/gx/gs)") || (intended_device_family == "StratixV(GX/GS/GT)") || (intended_device_family == "STRATIXV(GX/GS/GT)") || (intended_device_family == "stratixv(gx/gs/gt)") || (intended_device_family == "StratixV(GX/GT/GS)") || (intended_device_family == "STRATIXV(GX/GT/GS)") || (intended_device_family == "stratixv(gx/gt/gs)") || (intended_device_family == "Stratix V (GS/GT/GX/E)") || (intended_device_family == "STRATIX V (GS/GT/GX/E)") || (intended_device_family == "stratix v (gs/gt/gx/e)") || (intended_device_family == "StratixV(GS/GT/GX/E)") || (intended_device_family == "STRATIXV(GS/GT/GX/E)") || (intended_device_family == "stratixv(gs/gt/gx/e)") || (intended_device_family == "Stratix V (E)") || (intended_device_family == "STRATIX V (E)") || (intended_device_family == "stratix v (e)") || (intended_device_family == "StratixV(E)") || (intended_device_family == "STRATIXV(E)") || (intended_device_family == "stratixv(e)"))
                                || (((intended_device_family == "Arria V GZ") || (intended_device_family == "ARRIA V GZ") || (intended_device_family == "arria v gz") || (intended_device_family == "ArriaVGZ") || (intended_device_family == "ARRIAVGZ") || (intended_device_family == "arriavgz"))
                                ) ) || (((intended_device_family == "Arria V") || (intended_device_family == "ARRIA V") || (intended_device_family == "arria v") || (intended_device_family == "Arria V (GT/GX)") || (intended_device_family == "ARRIA V (GT/GX)") || (intended_device_family == "arria v (gt/gx)") || (intended_device_family == "ArriaV(GT/GX)") || (intended_device_family == "ARRIAV(GT/GX)") || (intended_device_family == "arriav(gt/gx)") || (intended_device_family == "ArriaV") || (intended_device_family == "ARRIAV") || (intended_device_family == "arriav") || (intended_device_family == "Arria V (GT/GX/ST/SX)") || (intended_device_family == "ARRIA V (GT/GX/ST/SX)") || (intended_device_family == "arria v (gt/gx/st/sx)") || (intended_device_family == "ArriaV(GT/GX/ST/SX)") || (intended_device_family == "ARRIAV(GT/GX/ST/SX)") || (intended_device_family == "arriav(gt/gx/st/sx)") || (intended_device_family == "Arria V (GT)") || (intended_device_family == "ARRIA V (GT)") || (intended_device_family == "arria v (gt)") || (intended_device_family == "ArriaV(GT)") || (intended_device_family == "ARRIAV(GT)") || (intended_device_family == "arriav(gt)") || (intended_device_family == "Arria V (GX)") || (intended_device_family == "ARRIA V (GX)") || (intended_device_family == "arria v (gx)") || (intended_device_family == "ArriaV(GX)") || (intended_device_family == "ARRIAV(GX)") || (intended_device_family == "arriav(gx)") || (intended_device_family == "Arria V (ST)") || (intended_device_family == "ARRIA V (ST)") || (intended_device_family == "arria v (st)") || (intended_device_family == "ArriaV(ST)") || (intended_device_family == "ARRIAV(ST)") || (intended_device_family == "arriav(st)") || (intended_device_family == "Arria V (SX)") || (intended_device_family == "ARRIA V (SX)") || (intended_device_family == "arria v (sx)") || (intended_device_family == "ArriaV(SX)") || (intended_device_family == "ARRIAV(SX)") || (intended_device_family == "arriav(sx)"))
                                || (((intended_device_family == "Cyclone V") || (intended_device_family == "CYCLONE V") || (intended_device_family == "cyclone v") || (intended_device_family == "CycloneV") || (intended_device_family == "CYCLONEV") || (intended_device_family == "cyclonev") || (intended_device_family == "Cyclone V (GT/GX/E/SX)") || (intended_device_family == "CYCLONE V (GT/GX/E/SX)") || (intended_device_family == "cyclone v (gt/gx/e/sx)") || (intended_device_family == "CycloneV(GT/GX/E/SX)") || (intended_device_family == "CYCLONEV(GT/GX/E/SX)") || (intended_device_family == "cyclonev(gt/gx/e/sx)") || (intended_device_family == "Cyclone V (E/GX/GT/SX/SE/ST)") || (intended_device_family == "CYCLONE V (E/GX/GT/SX/SE/ST)") || (intended_device_family == "cyclone v (e/gx/gt/sx/se/st)") || (intended_device_family == "CycloneV(E/GX/GT/SX/SE/ST)") || (intended_device_family == "CYCLONEV(E/GX/GT/SX/SE/ST)") || (intended_device_family == "cyclonev(e/gx/gt/sx/se/st)") || (intended_device_family == "Cyclone V (E)") || (intended_device_family == "CYCLONE V (E)") || (intended_device_family == "cyclone v (e)") || (intended_device_family == "CycloneV(E)") || (intended_device_family == "CYCLONEV(E)") || (intended_device_family == "cyclonev(e)") || (intended_device_family == "Cyclone V (GX)") || (intended_device_family == "CYCLONE V (GX)") || (intended_device_family == "cyclone v (gx)") || (intended_device_family == "CycloneV(GX)") || (intended_device_family == "CYCLONEV(GX)") || (intended_device_family == "cyclonev(gx)") || (intended_device_family == "Cyclone V (GT)") || (intended_device_family == "CYCLONE V (GT)") || (intended_device_family == "cyclone v (gt)") || (intended_device_family == "CycloneV(GT)") || (intended_device_family == "CYCLONEV(GT)") || (intended_device_family == "cyclonev(gt)") || (intended_device_family == "Cyclone V (SX)") || (intended_device_family == "CYCLONE V (SX)") || (intended_device_family == "cyclone v (sx)") || (intended_device_family == "CycloneV(SX)") || (intended_device_family == "CYCLONEV(SX)") || (intended_device_family == "cyclonev(sx)") || (intended_device_family == "Cyclone V (SE)") || (intended_device_family == "CYCLONE V (SE)") || (intended_device_family == "cyclone v (se)") || (intended_device_family == "CycloneV(SE)") || (intended_device_family == "CYCLONEV(SE)") || (intended_device_family == "cyclonev(se)") || (intended_device_family == "Cyclone V (ST)") || (intended_device_family == "CYCLONE V (ST)") || (intended_device_family == "cyclone v (st)") || (intended_device_family == "CycloneV(ST)") || (intended_device_family == "CYCLONEV(ST)") || (intended_device_family == "cyclonev(st)"))
                                ) )) ? 1 : 0;

    // calculate clock boost for STRATIX, STRATIX GX, STRATIX II and Stratix III
    parameter STRATIX_INCLOCK_BOOST = ((input_data_rate !=0) &&
                                        (inclock_period !=0))
                                            ? PLL_M_VALUE :
                                        ((inclock_boost == 0)
                                            ? deserialization_factor
                                            : inclock_boost);

    // phase_shift delay. Add 0.5 to the calculated result to round up result to
    // the nearest integer.
    parameter PHASE_SHIFT =
                (inclock_data_alignment == "UNUSED" || VSERIES_FAMILY)
                    ? inclock_phase_shift :
                (inclock_data_alignment == "EDGE_ALIGNED")
                    ? 0 :
                (inclock_data_alignment == "CENTER_ALIGNED")
                    ? (0.5 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "45_DEGREES")
                    ? (0.125 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "90_DEGREES")
                    ? (0.25 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "135_DEGREES")
                    ? (0.375 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "180_DEGREES")
                    ? (0.5 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "225_DEGREES")
                    ? (0.625 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "270_DEGREES")
                    ? (0.75 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5 :
                (inclock_data_alignment == "315_DEGREES")
                    ? (0.875 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5
                    : 0;

    // parameter for Stratix II inclock phase shift.
    parameter STXII_PHASE_SHIFT = PHASE_SHIFT -
                            (0.5 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for inclock phase shift of Cyclone II and Stratix II in LE mode.
    parameter STXII_LE_PHASE_SHIFT = ((use_no_phase_shift == "OFF") && (pll_operation_mode == "SOURCE_SYNCHRONOUS"))
                                ? (PHASE_SHIFT -
                                    (0.25 * inclock_period / STRATIX_INCLOCK_BOOST))
                                : PHASE_SHIFT;

    // parameter for inclock phase shift of StratixIII in LE mode.
    parameter STXIII_LE_PHASE_SHIFT = PHASE_SHIFT - (PLL_D_VALUE * inclock_period / STRATIX_INCLOCK_BOOST/4);

    parameter REGISTER_WIDTH = deserialization_factor * number_of_channels;

    // input clock period for PLL.
    parameter CLOCK_PERIOD = (deserialization_factor > 2)
                                ? inclock_period
                                : 10000;

    parameter FAST_CLK_ENA_PHASE_SHIFT = (deserialization_factor*2-3) * (inclock_period/(2*STRATIX_INCLOCK_BOOST));
    
    parameter use_dpa_calibration = ((ARRIAII_RX_STYLE == 1) && (enable_dpa_calibration == "ON"))
                                ? 1 : 0;
                                
// LOCAL_PARAMETERS_END

// INPUT PORT DECLARATION
    input [number_of_channels -1 :0] rx_in;
    input rx_inclock;
    input rx_syncclock;
    input rx_dpaclock;
    input rx_readclock;
    input rx_enable;
    input rx_deskew;
    input rx_pll_enable;
    input rx_data_align;
    input rx_data_align_reset;
    input [number_of_channels -1 :0] rx_reset;
    input [number_of_channels -1 :0] rx_dpll_reset;
    input [number_of_channels -1 :0] rx_dpll_hold;
    input [number_of_channels -1 :0] rx_dpll_enable;
    input [number_of_channels -1 :0] rx_fifo_reset;
    input [number_of_channels -1 :0] rx_channel_data_align;
    input [number_of_channels -1 :0] rx_cda_reset;
    input [number_of_channels -1 :0] rx_coreclk;
    input pll_areset;
    input pll_phasedone;
    input [number_of_channels -1 :0] rx_dpa_lock_reset;
    input dpa_pll_recal;
    input rx_data_reset;

// OUTPUT PORT DECLARATION
    output [REGISTER_WIDTH -1: 0] rx_out;
    output rx_outclock;
    output rx_locked;
    output [number_of_channels -1: 0] rx_dpa_locked;
    output [number_of_channels -1: 0] rx_cda_max;
    output [number_of_channels -1: 0] rx_divfwdclk;
    output pll_phasestep;
    output pll_phaseupdown;
    output pll_scanclk;
    output [3: 0] pll_phasecounterselect;
    output dpa_pll_cal_busy;

// INTERNAL REGISTERS DECLARATION
    reg [REGISTER_WIDTH -1 : 0] pattern;
    reg [REGISTER_WIDTH -1 : 0] rx_shift_reg;
    reg [REGISTER_WIDTH -1 : 0] rx_parallel_load_reg;
    reg [REGISTER_WIDTH -1 : 0] rx_out_reg;
    reg rx_data_align_reg;
    reg pll_lock_sync;

    // for x2 mode (deserialization_factor = 2)
    reg [REGISTER_WIDTH -1 : 0] rx_ddio_in;
    reg [number_of_channels -1 : 0] rx_in_latched;

// INTERNAL WIRE DECLARATION
    wire [REGISTER_WIDTH -1 : 0] rx_out_int;
    wire [REGISTER_WIDTH -1 : 0] stratix_dataout;
    wire [REGISTER_WIDTH -1 : 0] stratixgx_dataout;
    wire [REGISTER_WIDTH -1 : 0] stratixii_dataout;
    wire [REGISTER_WIDTH -1 : 0] stratixiii_dataout;
    wire [REGISTER_WIDTH -1 : 0] flvds_dataout;
    wire [number_of_channels -1 : 0] stratixgx_dpa_locked;
    wire [number_of_channels -1 : 0] stratixii_dpa_locked;
    wire [number_of_channels -1 : 0] stratixiii_dpa_locked;
    wire [number_of_channels -1 : 0] stratixii_cda_max;
    wire [number_of_channels -1 : 0] stratixiii_cda_max;
    wire [number_of_channels -1 : 0] stratixiii_divfwdclk;
    wire rx_slowclk;
    wire rx_locked_int;
    wire rx_outclk_int;
    wire rx_data_align_clk;
    wire [number_of_channels -1 : 0] rx_reg_clk;
    wire[1:0] stratix_pll_inclock;
    wire[1:0] stratixii_pll_inclock;
    wire[1:0] stratixiii_pll_inclock;
    wire[5:0] stratix_pll_outclock;
    wire[5:0] stratixii_pll_outclock;
    wire[9:0] stratixiii_pll_outclock;
    wire stratix_pll_enable;
    wire stratixii_pll_enable;
    wire stratix_pll_areset;
    wire stratixii_pll_areset;
    wire stratixiii_pll_areset;
    wire stratixii_sclkout0;
    wire stratixii_sclkout1;
    wire stratix_locked;
    wire stratixii_locked;
    wire stratixiii_locked;
    wire stratix_enable0;
    wire stratix_enable1;
    wire stratixii_enable0;
    wire stratixii_enable1;
    wire stratix_fastclk;
    wire stratix_slowclk;
    wire stratixgx_fastclk;
    wire stratixgx_slowclk;
    wire[number_of_channels -1 :0] stratixgx_coreclk;
    wire stratixii_fastclk;
    wire stratixiii_fastclk;
    wire stratixiii_slowclk;
    wire stratixii_enable;
    wire stratixiii_enable;
    wire flvds_fastclk;
    wire flvds_slowclk;
    wire flvds_syncclk;
    wire[number_of_channels -1 :0] flvds_rx_data_align;
    wire[number_of_channels -1 :0] flvds_rx_cda_reset;
    wire rx_data_align_int;
    wire rx_data_align_pulldown;
    wire[number_of_channels -1 :0] rx_channel_data_align_int;

// INTERNAL TRI DECLARATION
    tri0 rx_deskew;
    tri1 rx_pll_enable;
    tri0[number_of_channels -1 :0] rx_reset;
    tri0[number_of_channels -1 :0] rx_dpll_reset;
    tri0[number_of_channels -1 :0] rx_dpll_hold;
    tri1[number_of_channels -1 :0] rx_dpll_enable;
    tri0[number_of_channels -1 :0] rx_fifo_reset;
    tri0[number_of_channels -1 :0] rx_cda_reset;
    tri0[number_of_channels -1 :0] rx_coreclk;
    tri0 pll_areset;
    tri0 rx_data_align_reset;
    tri0 dpa_pll_recalibrate;
    tri1 pll_phasedone;
    tri0[number_of_channels -1 :0] rx_dpa_lock_reset;

// LOCAL INTEGER DECLARATION
    integer i;
    integer i1;
    integer i2;
    integer i3;
    integer i4;
    integer i5;
    integer j;
    integer j1;
    integer x;

// COMPONENT INSTANTIATIONS
    ALTERA_DEVICE_FAMILIES dev ();

// FUNCTION DECLARATIONS

// INITIAL CONSTRUCT BLOCK
    initial
    begin : INITIALIZATION
        pll_lock_sync = 1'b1;
        rx_data_align_reg = 1'b0;
        rx_in_latched = {number_of_channels{1'b0}};

        rx_out_reg = {REGISTER_WIDTH{1'b0}};
        rx_shift_reg = {REGISTER_WIDTH{1'b0}};
        rx_parallel_load_reg = {REGISTER_WIDTH{1'b0}};
        rx_ddio_in = {REGISTER_WIDTH{1'b0}};

        // Check for illegal mode settings
        if ((STRATIX_RX_STYLE == 1) &&
            (deserialization_factor != 1) && (deserialization_factor != 2) &&
            ((deserialization_factor > 10) || (deserialization_factor < 4)))
        begin
            $display ($time, "ps Error: STRATIX or STRATIXGX in non DPA mode does not support the specified deserialization factor!");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end
        else if ((STRATIXGX_DPA_RX_STYLE == 1) && (deserialization_factor != 8) && (deserialization_factor != 10))
        begin
            $display ($time, "ps Error: STRATIXGX in DPA mode does not support the specified deserialization factor!");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end

        if ((STRATIXII_RX_STYLE == 1) &&
            (deserialization_factor > 10))
        begin
            $display ($time, "ps Error: STRATIX II does not support the specified deserialization factor!");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end

        if ((STRATIXII_RX_STYLE == 1) &&
            (data_align_rollover > 11))
        begin
            $display ($time, "ps Error: STRATIX II does not support data align rollover values > 11 !");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end

        if (CYCLONE_RX_STYLE == 1)
        begin
            if ((use_external_pll == "OFF") && ((deserialization_factor > 10) || (deserialization_factor == 3)))
            begin
                $display ($time, "ps Error: Cyclone does not support the specified deserialization factor when use_external_pll is 'OFF'!");
                $display("Time: %0t  Instance: %m", $time);
                $finish;
            end
        end
        
        if (CYCLONEII_RX_STYLE == 1)
        begin
            if ((use_external_pll == "OFF") && ((deserialization_factor > 10) || (deserialization_factor == 3)))
            begin
                $display ($time, "ps Error: Cyclone II does not support the specified deserialization factor when use_external_pll is 'OFF'!");
                $display("Time: %0t  Instance: %m", $time);
                $finish;
            end
        end
        
        if (dev.IS_VALID_FAMILY(intended_device_family) == 0)
        begin
            $display ("Error! Unknown INTENDED_DEVICE_FAMILY=%s.", intended_device_family);
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end
    end

    // NCSIM will only assigns 1'bZ to unconnected port at time 0fs + 1
    initial #0
    begin
        if ((STRATIXII_RX_STYLE == 1) &&
            (rx_channel_data_align === {number_of_channels{1'bZ}}) &&
            (rx_data_align !== 1'bZ))
        begin
            $display("Warning : Data alignment on Stratix II devices introduces one bit of latency for each assertion of the data alignment signal.  In comparison, Stratix and Stratix GX devices remove one bit of latency for each assertion.");
            $display("Time: %0t  Instance: %m", $time);
        end
    end

// COMPONENT INSTANTIATIONS

    // pll for Stratix and Stratix GX
    generate
    if ((FAMILY_HAS_STRATIX_STYLE_PLL == 1) && (use_external_pll == "OFF") && (deserialization_factor > 2))
    begin : MF_stratix_pll
    MF_stratix_pll u1 (
        .inclk(stratix_pll_inclock), // Required
        .ena(stratix_pll_enable),
        .areset(stratix_pll_areset),
        .clkena(6'b111111),
        .clk (stratix_pll_outclock),
        .locked(stratix_locked),
        .fbin(1'b1),
        .clkswitch(1'b0),
        .pfdena(1'b1),
        .extclkena(4'b0),
        .scanclk(1'b0),
        .scanaclr(1'b0),
        .scandata(1'b0),
        .comparator(rx_data_align_int),
        .extclk(),
        .clkbad(),
        .enable0(stratix_enable0),
        .enable1(stratix_enable1),
        .activeclock(),
        .clkloss(),
        .scandataout());

    defparam
        u1.pll_type               = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u1.inclk0_input_frequency = CLOCK_PERIOD,
        u1.inclk1_input_frequency = CLOCK_PERIOD,
        u1.valid_lock_multiplier  = 1,
        u1.clk0_multiply_by       = STRATIX_INCLOCK_BOOST,
        u1.clk0_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : 1,
        u1.clk1_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STRATIX_INCLOCK_BOOST
                                    : 1,
        u1.clk1_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? PLL_D_VALUE*deserialization_factor
                                    : 1,
        u1.clk2_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STRATIX_INCLOCK_BOOST *2
                                    : STRATIX_INCLOCK_BOOST,
        u1.clk2_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 0)
                                        ? PLL_D_VALUE*deserialization_factor/2
                                        : PLL_D_VALUE*deserialization_factor)
                                    : deserialization_factor,
        u1.clk0_phase_shift_num   = PHASE_SHIFT,
        u1.clk1_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? PHASE_SHIFT
                                    : 1,
        u1.clk2_phase_shift_num   = PHASE_SHIFT,
        u1.simulation_type        = "functional",
        u1.family_name            = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix",
        u1.m                      = 0;
    end
    endgenerate

    
    // pll for Stratix II
    generate
    if ((FAMILY_HAS_STRATIXII_STYLE_PLL == 1) && (use_external_pll == "OFF") &&
            (deserialization_factor > 2))
    begin : MF_stratixii_pll
    MF_stratixii_pll u2 (
        .inclk(stratixii_pll_inclock), // Required
        .ena(stratixii_pll_enable),
        .areset(stratixii_pll_areset),
        .clk (stratixii_pll_outclock ),
        .locked(stratixii_locked),
        .fbin(1'b1),
        .clkswitch(1'b0),
        .pfdena(1'b1),
        .scanclk(1'b0),
        .scanread(1'b0),
        .scanwrite(1'b0),
        .scandata(1'b0),
        .testin(4'b0),
        .clkbad(),
        .enable0(stratixii_enable0),
        .enable1(stratixii_enable1),
        .activeclock(),
        .clkloss(),
        .scandataout(),
        .scandone(),
        .sclkout({stratixii_sclkout1, stratixii_sclkout0}),
        .testupout(),
        .testdownout());

    defparam
        u2.operation_mode         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? pll_operation_mode
                                    : "normal",
        u2.pll_type               = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u2.vco_multiply_by        = STRATIX_INCLOCK_BOOST,
        u2.vco_divide_by          = 1,
        u2.inclk0_input_frequency = CLOCK_PERIOD,
        u2.inclk1_input_frequency = CLOCK_PERIOD,
        u2.clk0_multiply_by       = STRATIX_INCLOCK_BOOST,
        u2.clk0_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : deserialization_factor,
        u2.clk1_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STRATIX_INCLOCK_BOOST
                                    : 1,
        u2.clk1_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? PLL_D_VALUE*deserialization_factor
                                    : 1,
        u2.clk2_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STRATIX_INCLOCK_BOOST *2
                                    : STRATIX_INCLOCK_BOOST,
        u2.clk2_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 0)
                                        ? PLL_D_VALUE*deserialization_factor/2
                                        : PLL_D_VALUE*deserialization_factor)
                                    : deserialization_factor,
        u2.clk0_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXII_LE_PHASE_SHIFT
                                    : STXII_PHASE_SHIFT,
        u2.clk1_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STXII_LE_PHASE_SHIFT
                                    : 1,
        u2.clk2_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXII_LE_PHASE_SHIFT
                                    : STXII_PHASE_SHIFT,
        u2.sclkout0_phase_shift   = STXII_PHASE_SHIFT,
        u2.simulation_type        = "functional",
        u2.family_name            = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix II",
        u2.m                      = 0;
    end
    endgenerate

    // pll for Stratix III
    generate
    if ((FAMILY_HAS_STRATIXIII_STYLE_PLL == 1) && (use_external_pll == "OFF") &&
            (deserialization_factor > 2))
    begin : MF_stratixiii_pll
    MF_stratixiii_pll u8 (
        .inclk(stratixiii_pll_inclock), // Required
        .areset(stratixiii_pll_areset),
        .clk (stratixiii_pll_outclock ),
        .locked(stratixiii_locked),
        .fbin(1'b1),
        .clkswitch(1'b0),
        .pfdena(1'b1),
        .scanclk(1'b0),
        .scanclkena(1'b0),
        .scandata(1'b0),
        .configupdate(1'b0),
        .phasecounterselect(4'b1111),
        .phaseupdown(1'b1),
        .phasestep(1'b1),
        .fbout(),
        .clkbad(),
        .activeclock(),
        .scandataout(),
        .scandone(),
        .phasedone(),
        .vcooverrange(),
        .vcounderrange());

    defparam
        u8.operation_mode         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? pll_operation_mode
                                    : "source_synchronous",
        u8.pll_type               = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u8.vco_multiply_by        = STRATIX_INCLOCK_BOOST,
        u8.vco_divide_by          = 1,
        u8.inclk0_input_frequency = CLOCK_PERIOD,
        u8.inclk1_input_frequency = CLOCK_PERIOD,
        u8.clk0_multiply_by       = STRATIX_INCLOCK_BOOST,
        u8.clk0_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : 1,
        u8.clk1_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 0)
                                    ? 1
                                    : STRATIX_INCLOCK_BOOST,
        u8.clk1_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 1)
                                        ? PLL_D_VALUE*deserialization_factor
                                        : 1)
                                    : deserialization_factor,
        u8.clk2_multiply_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                                    (deserialization_factor%2 == 1)
                                    ? STRATIX_INCLOCK_BOOST *2
                                    : STRATIX_INCLOCK_BOOST,
        u8.clk2_divide_by         = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 1)
                                        ? PLL_D_VALUE*deserialization_factor
                                        : PLL_D_VALUE*deserialization_factor/2)
                                    : deserialization_factor,
        u8.clk0_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXIII_LE_PHASE_SHIFT
                                    : STXII_PHASE_SHIFT,
        u8.clk1_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 1)
                                        ? STXIII_LE_PHASE_SHIFT
                                        : 1)
                                    : STXII_PHASE_SHIFT + FAST_CLK_ENA_PHASE_SHIFT,
        u8.clk2_phase_shift_num   = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXIII_LE_PHASE_SHIFT
                                    : STXII_PHASE_SHIFT,
        u8.clk1_duty_cycle        = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 50
                                    : (100/deserialization_factor) + 0.5,
        u8.simulation_type        = "functional",
        u8.family_name            = (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix III",
        u8.self_reset_on_loss_lock = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? pll_self_reset_on_loss_lock
                                    : "OFF",
        u8.m                      = 0;
    end
    endgenerate

    // Stratix lvds receiver
    stratix_lvds_rx u3 (
        .rx_in(rx_in),
        .rx_fastclk(stratix_fastclk),
        .rx_enable0(stratix_enable0),
        .rx_enable1(stratix_enable1),
        .rx_out(stratix_dataout));

    defparam
        u3.number_of_channels = number_of_channels,
        u3.deserialization_factor = deserialization_factor;

    // Stratixgx lvds receiver with DPA mode
    stratixgx_dpa_lvds_rx u4 (
        .rx_in(rx_in),
        .rx_fastclk(stratixgx_fastclk),
        .rx_slowclk(stratixgx_slowclk),
        .rx_coreclk(stratixgx_coreclk),
        .rx_locked(stratix_locked),
        .rx_reset(rx_reset),
        .rx_dpll_reset(rx_dpll_reset),
        .rx_channel_data_align(rx_channel_data_align_int),
        .rx_out(stratixgx_dataout),
        .rx_dpa_locked(stratixgx_dpa_locked));

    defparam
        u4.number_of_channels = number_of_channels,
        u4.deserialization_factor = deserialization_factor,
        u4.use_coreclock_input = use_coreclock_input,
        u4.enable_dpa_fifo = enable_dpa_fifo,
        u4.registered_output = registered_output;


    // Stratix II lvds receiver
    generate
    if ((STRATIXII_RX_STYLE == 1) && (implement_in_les == "OFF") && (deserialization_factor > 2))
    begin : stratixii_lvds_rx
    stratixii_lvds_rx u5 (
        .rx_in(rx_in),
        .rx_reset(rx_reset),
        .rx_fastclk(stratixii_fastclk),
        .rx_enable(stratixii_enable),
        .rx_locked(stratixii_locked),
        .rx_dpll_reset(rx_dpll_reset),
        .rx_dpll_hold(rx_dpll_hold),
        .rx_dpll_enable(rx_dpll_enable),
        .rx_fifo_reset(rx_fifo_reset),
        .rx_channel_data_align(rx_channel_data_align_int),
        .rx_cda_reset(rx_cda_reset),
        .rx_out(stratixii_dataout),
        .rx_dpa_locked(stratixii_dpa_locked),
        .rx_cda_max(stratixii_cda_max));

    defparam
        u5.number_of_channels = number_of_channels,
        u5.deserialization_factor = deserialization_factor,
        u5.enable_dpa_mode = enable_dpa_mode,
        u5.data_align_rollover = data_align_rollover,
        u5.lose_lock_on_one_change = lose_lock_on_one_change,
        u5.reset_fifo_at_first_lock = reset_fifo_at_first_lock,
        u5.x_on_bitslip = x_on_bitslip,
        u5.show_warning = (STRATIXII_RX_STYLE == 1) ? "ON" : "OFF";
    end
    endgenerate

    // flexible lvds receiver
    flexible_lvds_rx u6 (
        .rx_in(rx_in),
        .rx_fastclk(flvds_fastclk),
        .rx_slowclk(flvds_slowclk),
        .rx_syncclk(flvds_syncclk),
        .rx_locked(rx_locked_int),
        .pll_areset(pll_areset | rx_data_reset),
        .rx_data_align(flvds_rx_data_align),
        .rx_cda_reset(flvds_rx_cda_reset),
        .rx_out(flvds_dataout));

    defparam
        u6.number_of_channels = number_of_channels,
        u6.deserialization_factor = deserialization_factor,
        u6.use_extra_ddio_register = (CYCLONE_RX_STYLE == 1) ||
                                    (CYCLONEIII_RX_STYLE == 1) ||
                                    (CYCLONEII_RX_STYLE == 1) ? "YES" : "NO",
        u6.use_extra_pll_clk =  (CYCLONE_RX_STYLE == 1) ||
                                (CYCLONEII_RX_STYLE == 1) ? "NO" : "YES",
        u6.buffer_implementation = buffer_implementation,
        u6.registered_data_align_input = registered_data_align_input,
        u6.use_external_pll = use_external_pll,
        u6.registered_output = registered_output,
        u6.add_latency = (CYCLONE_RX_STYLE == 1) ||
                        (CYCLONEII_RX_STYLE == 1) ||
                        (CYCLONEIII_RX_STYLE == 1) ? "YES" : "NO";


// Stratix III lvds receiver
    generate
    if ((STRATIXIII_RX_STYLE == 1) && (implement_in_les == "OFF") && (deserialization_factor > 2)) 
    begin : stratixiii_lvds_rx
    stratixiii_lvds_rx u7 (
        .rx_in(rx_in),
        .rx_reset(rx_reset),
        .rx_fastclk(stratixiii_fastclk),
        .rx_slowclk(stratixiii_slowclk),
        .rx_enable(stratixiii_enable),
        .rx_dpll_reset(rx_dpll_reset),
        .rx_dpll_hold(rx_dpll_hold),
        .rx_dpll_enable(rx_dpll_enable),
        .rx_fifo_reset(rx_fifo_reset),
        .rx_channel_data_align(rx_channel_data_align_int),
        .rx_cda_reset(rx_cda_reset),
        .rx_out(stratixiii_dataout),
        .rx_dpa_locked(stratixiii_dpa_locked),
        .rx_cda_max(stratixiii_cda_max),
        .rx_divfwdclk(stratixiii_divfwdclk),
        .rx_dpa_lock_reset(rx_dpa_lock_reset),
        .rx_locked(rx_locked_int),
        .rx_dpaclock(rx_dpaclock));

    defparam
        u7.number_of_channels = number_of_channels,
        u7.deserialization_factor = deserialization_factor,
        u7.enable_dpa_mode = enable_dpa_mode,
        u7.data_align_rollover = data_align_rollover,
        u7.lose_lock_on_one_change = lose_lock_on_one_change,
        u7.reset_fifo_at_first_lock = reset_fifo_at_first_lock,
        u7.x_on_bitslip = x_on_bitslip,
        u7.rx_align_data_reg = rx_align_data_reg,
        u7.enable_soft_cdr_mode = enable_soft_cdr_mode,
        u7.sim_dpa_output_clock_phase_shift = sim_dpa_output_clock_phase_shift,
        u7.sim_dpa_is_negative_ppm_drift = sim_dpa_is_negative_ppm_drift,
        u7.sim_dpa_net_ppm_variation = sim_dpa_net_ppm_variation,
        u7.enable_dpa_align_to_rising_edge_only = enable_dpa_align_to_rising_edge_only,
        u7.enable_dpa_initial_phase_selection = enable_dpa_initial_phase_selection,
        u7.dpa_initial_phase_value = dpa_initial_phase_value,
        u7.use_external_pll = use_external_pll,
        u7.registered_output = registered_output,
        u7.use_dpa_calibration = use_dpa_calibration,
        u7.enable_clock_pin_mode = enable_clock_pin_mode,
        u7.ARRIAII_RX_STYLE = ARRIAII_RX_STYLE,
        u7.STRATIXV_RX_STYLE = STRATIXV_RX_STYLE;
    end
    endgenerate
        

// ALWAYS CONSTRUCT BLOCK

    // For x2 mode. Data input is sampled in both the rising edge and falling
    // edge of input clock.
    always @(posedge rx_inclock)
    begin : DDIO_IN
        if (deserialization_factor == 2)
        begin
            for (i1 = 0; i1 <= number_of_channels-1; i1 = i1+1)
            begin
                if (CYCLONEIII_RX_STYLE == 1)
                begin
                    rx_ddio_in[(i1*2)+1] <= rx_in[i1];
                    rx_ddio_in[(i1*2)] <= rx_in_latched[i1];
                end
                else
                begin
                    rx_ddio_in[(i1*2)] <= rx_in[i1];
                    rx_ddio_in[(i1*2)+1] <= rx_in_latched[i1];
                end
            end
        end
    end // DDIO_IN

    always @(negedge rx_inclock)
    begin : DDIO_IN_LATCH
        if ((deserialization_factor == 2) && ($time > 0))
        begin
            rx_in_latched <= rx_in;
        end
    end // DDIO_IN_LATCH


    // synchronization register
    always @ (posedge rx_reg_clk)
    begin : SYNC_REGISTER
        rx_out_reg <= rx_out_int;
    end // SYNC_REGISTER

    // Registering rx_data_align signal for stratix II lvds_rx.
    always @ (posedge rx_data_align_clk)
    begin
        rx_data_align_reg <= rx_data_align_pulldown;
    end

    always @(posedge stratixiii_locked or posedge pll_areset)
    begin
        if (pll_areset)
            pll_lock_sync <= 1'b0;
        else
            pll_lock_sync <= 1'b1;
    end 

// CONTINOUS ASSIGNMENT
    assign rx_out = (STRATIXGX_DPA_RX_STYLE == 1) && (deserialization_factor > 2)
                        ? stratixgx_dataout :
                    (FAMILY_HAS_FLEXIBLE_LVDS == 1) && (deserialization_factor > 2)
                        ? flvds_dataout :
                    (STRATIXIII_RX_STYLE == 1) && (deserialization_factor > 2)
                        ? stratixiii_dataout :
                    (registered_output == "ON") && (use_external_pll == "OFF")
                        ? rx_out_reg
                        : rx_out_int;

    assign rx_out_int = (deserialization_factor == 1)
                            ? rx_in :
                        (deserialization_factor == 2)
                            ? rx_ddio_in :
                        (STRATIX_RX_STYLE == 1)
                            ? stratix_dataout :
                        (STRATIXII_RX_STYLE == 1)
                            ? stratixii_dataout : rx_parallel_load_reg;

    assign rx_reg_clk  = (use_external_pll == "ON")
                            ? rx_inclock :
                        (enable_soft_cdr_mode == "ON")
                            ? stratixiii_divfwdclk[0]
                            : {number_of_channels{rx_outclk_int}};

    assign rx_divfwdclk = stratixiii_divfwdclk;

    assign rx_outclock = rx_outclk_int;

    assign rx_outclk_int = (deserialization_factor <= 2)
                            ? rx_inclock 
                            : rx_slowclk;

    assign rx_slowclk = ((STRATIX_RX_STYLE == 1) ||
                        (STRATIXGX_DPA_RX_STYLE == 1) ||
                        (CYCLONE_RX_STYLE == 1))
                            ? stratix_pll_outclock[2] :
                        ((STRATIXII_RX_STYLE == 1) ||
                        (CYCLONEII_RX_STYLE == 1))
                            ? stratixii_pll_outclock[2] :
                        ((STRATIXIII_RX_STYLE == 1) || (CYCLONEIII_RX_STYLE == 1))
                            ? stratixiii_pll_outclock[2]
                            : 1'b0;

    assign rx_locked = (deserialization_factor > 2)
                            ? rx_locked_int
                            : 1'b1;

    assign rx_locked_int = (use_external_pll == "ON")
                            ? 1'b1 :
                        ((STRATIX_RX_STYLE == 1) ||
                        (STRATIXGX_DPA_RX_STYLE == 1) ||
                        (CYCLONE_RX_STYLE == 1))
                            ? stratix_locked :
                        ((STRATIXII_RX_STYLE == 1) ||
                        (CYCLONEII_RX_STYLE == 1))
                            ? stratixii_locked :
                        ((STRATIXIII_RX_STYLE == 1) || (CYCLONEIII_RX_STYLE == 1))
                            ? stratixiii_locked & pll_lock_sync
                            : 1'b1;

    assign rx_dpa_locked =  (STRATIXGX_DPA_RX_STYLE == 1)
                            ? stratixgx_dpa_locked :
                        (STRATIXII_RX_STYLE == 1)
                            ? stratixii_dpa_locked :
                        (STRATIXIII_RX_STYLE == 1)
                            ? stratixiii_dpa_locked
                            : {number_of_channels{1'b1}};

    assign rx_cda_max = (STRATIXII_RX_STYLE == 1)
                            ? stratixii_cda_max :
                        (STRATIXIII_RX_STYLE == 1)
                            ? stratixiii_cda_max
                            : {number_of_channels{1'b0}};

    assign rx_data_align_pulldown = (port_rx_data_align == "PORT_USED")
                                    ? rx_data_align :
                                    (port_rx_data_align == "PORT_UNUSED")
                                    ? 1'b0 :
                                    (rx_data_align !== 1'bz)
                                    ? rx_data_align :
                                    1'b0;

    assign rx_data_align_int = (registered_data_align_input == "ON")
                            ? rx_data_align_reg
                            : rx_data_align_pulldown;

    assign rx_channel_data_align_int = ((port_rx_channel_data_align == "PORT_USED") ||
                        ((port_rx_channel_data_align == "PORT_CONNECTIVITY") &&
                        (rx_channel_data_align !== {number_of_channels{1'bZ}})))
                            ? rx_channel_data_align :
                        ((STRATIXII_RX_STYLE == 1) || (STRATIXIII_RX_STYLE == 1))
                            ? {number_of_channels{rx_data_align_int}}
                            : {number_of_channels{1'b0}};

    assign rx_data_align_clk = ((STRATIX_RX_STYLE == 1) ||
                        (STRATIXGX_DPA_RX_STYLE == 1))
                            ? stratix_pll_outclock[2] :
                        (STRATIXII_RX_STYLE == 1)
                            ? stratixii_pll_outclock[2] :
                        (STRATIXIII_RX_STYLE == 1)
                            ? stratixiii_pll_outclock[2]
                            : 1'b0;

    assign stratix_pll_inclock[1:0] = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                            ? {1'b0, rx_inclock}
                            : {2{1'b0}};

    assign stratix_pll_enable = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                            ? rx_pll_enable
                            : 1'b0;

    assign stratix_pll_areset = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                            ? pll_areset
                            : 1'b0;

    assign stratix_fastclk = (STRATIX_RX_STYLE == 1) && (implement_in_les == "OFF")
                            ? stratix_pll_outclock[0]
                            : 1'b0;

    assign stratix_slowclk = (STRATIX_RX_STYLE == 1) && (implement_in_les == "OFF")
                            ? stratix_pll_outclock[2]
                            : 1'b0;

    assign stratixgx_fastclk = (STRATIXGX_DPA_RX_STYLE == 1) && (implement_in_les == "OFF")
                            ? stratix_pll_outclock[0]
                            : 1'b0;

    assign stratixgx_slowclk = (STRATIXGX_DPA_RX_STYLE == 1) && (implement_in_les == "OFF")
                            ? stratix_pll_outclock[2]
                            : 1'b0;

    assign stratixgx_coreclk = (STRATIXGX_DPA_RX_STYLE == 1) && (implement_in_les == "OFF")
                            ? rx_coreclk
                            : {number_of_channels{1'b0}};

    assign stratixii_pll_inclock[1:0] =  (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                            ? {1'b0, rx_inclock}
                            : {2{1'b0}};

    assign stratixii_pll_enable = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                            ? rx_pll_enable
                            : 1'b0;

    assign stratixii_pll_areset = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                            ? pll_areset
                            : 1'b0;
    assign stratixii_fastclk = (STRATIXII_RX_STYLE == 0) && (implement_in_les == "OFF")
                            ? 1'b0 :
                        (use_external_pll == "ON")
                            ? rx_inclock
                            : stratixii_sclkout0;

    assign stratixii_enable = (STRATIXII_RX_STYLE == 0) && (implement_in_les == "OFF")
                            ? 1'b0 :
                        (use_external_pll == "ON")
                            ? rx_enable
                            : stratixii_enable0;

    assign stratixiii_pll_inclock[1:0] =  (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                            ? {1'b0, rx_inclock}
                            : {2{1'b0}};

    assign stratixiii_pll_areset = (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                            ? pll_areset
                            : 1'b0;
    assign stratixiii_fastclk = (STRATIXIII_RX_STYLE == 0) && (implement_in_les == "OFF")
                            ? 1'b0 :
                        ((use_external_pll == "ON") || ((STRATIXV_RX_STYLE == 1) && (enable_clock_pin_mode == "ON")))
                            ? rx_inclock
                            : stratixiii_pll_outclock[0];
                            
    assign stratixiii_slowclk = (((STRATIXIII_RX_STYLE == 0) && (implement_in_les == "OFF")) || ((STRATIXV_RX_STYLE == 1) && (enable_clock_pin_mode == "ON"))) 
                            ? 1'b0
                            : (use_external_pll == "ON")
                            ? rx_syncclock
                            : stratixiii_pll_outclock[2];

    assign stratixiii_enable = (((STRATIXIII_RX_STYLE == 0) && (implement_in_les == "OFF")) || ((STRATIXV_RX_STYLE == 1) && (enable_clock_pin_mode == "ON")))
                            ? 1'b0 :
                        (use_external_pll == "ON")
                            ? rx_enable
                            : stratixiii_pll_outclock[1];

    assign flvds_fastclk = ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_inclock
                                : stratix_pll_outclock[0]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_inclock
                                : stratixii_pll_outclock[0]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_inclock
                                : stratixiii_pll_outclock[0])
                            : 1'b0;

    assign flvds_slowclk =  ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_readclock
                                : stratix_pll_outclock[2]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_readclock
                                : stratixii_pll_outclock[2]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_readclock
                                : stratixiii_pll_outclock[2])
                            : 1'b0;

    assign flvds_syncclk =  ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_syncclock
                                : stratix_pll_outclock[1]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_syncclock
                                : stratixii_pll_outclock[1]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? rx_syncclock
                                : stratixiii_pll_outclock[1])
                            : 1'b0;
                            
    assign flvds_rx_data_align = ((port_rx_channel_data_align == "PORT_USED") ||
                                ((port_rx_channel_data_align == "PORT_CONNECTIVITY") &&
                                (rx_channel_data_align !== {number_of_channels{1'bZ}})))
                                ? rx_channel_data_align :
                            (port_rx_data_align != "PORT_UNUSED")
                                ? {number_of_channels{rx_data_align_pulldown}}
                                : {number_of_channels{1'b0}};

    assign flvds_rx_cda_reset = ((port_rx_channel_data_align == "PORT_USED") ||
                                ((port_rx_channel_data_align == "PORT_CONNECTIVITY") &&
                                (rx_channel_data_align !== {number_of_channels{1'bZ}})))
                                ? rx_cda_reset :
                            (port_rx_data_align != "PORT_UNUSED")
                                ? {number_of_channels{rx_data_align_reset}}
                                : {number_of_channels{1'b0}};

                            
endmodule // altlvds_rx

