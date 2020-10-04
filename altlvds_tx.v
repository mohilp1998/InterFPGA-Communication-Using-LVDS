//START_MODULE_NAME--------------------------------------------------------------
//
// Module Name     :  altlvds_tx

// Description     :  Low Voltage Differential Signaling (LVDS) transmitter
//                    megafunction. The altlvds_tx megafunction implements a
//                    serialization transmitter. LVDS is a high speed IO
//                    interface that uses inputs without a reference voltage.
//                    LVDS uses two wires carrying differential values to
//                    create a single channel. These wires are connected to two
//                    pins on supported device to create a single LVDS channel

// Limitation      :  Only available for STRATIX,
//                    STRATIX GX, STRATIX II, CYCLONE and CYCLONEII families.
//
// Results expected:  Output clock, serialized output data and pll locked signal.
//
//END_MODULE_NAME----------------------------------------------------------------

// BEGINNING OF MODULE
`timescale 1 ps / 1 ps

module altlvds_tx (
    tx_in,
    tx_inclock,
    tx_syncclock,
    tx_enable,
    sync_inclock,
    tx_pll_enable,
    pll_areset,
    tx_data_reset,

    tx_out,
    tx_outclock,
    tx_coreclock,
    tx_locked
);


// GLOBAL PARAMETER DECLARATION

    // No. of LVDS channels (required)
    parameter number_of_channels = 1;

    // No. of bits per channel (required)
    parameter deserialization_factor = 4;

    // Indicates whether the tx_in[] and tx_outclock ports should be registered.
    parameter registered_input = "ON";

    // "ON" means that sync_inclock is also used
    // (not used for Stratix and Stratix GX devices.)
    parameter multi_clock = "OFF";

    // The period of the input clock in ps (Required)
    parameter inclock_period = 10000;

    // Specifies the period of the tx_outclock port as
    // [INCLOCK_PERIOD * OUTCLOCK_DIVIDE_BY]
    parameter outclock_divide_by = deserialization_factor;

    // The effective clock period to sample output data
    parameter inclock_boost = deserialization_factor;

    // Aligns the Most Significant Bit(MSB) to the falling edge of the clock
    // instead of the rising edge.
    parameter center_align_msb = "OFF";

    // The device family to be used.
    parameter intended_device_family = "Stratix";

    // Data rate out of the PLL. (required and only for Stratix and
    // Stratix GX devices)
    parameter output_data_rate = 0;

    // The alignment of the input data with respect to the tx_inclock port.
    // (required and only for Stratix and Stratix GX devices)
    parameter inclock_data_alignment = "EDGE_ALIGNED";

    // The alignment of the output data with respect to the tx_outclock port.
    // (required and only for Stratix and Stratix GX devices)
    parameter outclock_alignment = "EDGE_ALIGNED";

    // Specifies whether the compiler uses the same PLL for both the LVDS
    // receiver and the LVDS transmitter
    parameter common_rx_tx_pll = "ON";

    parameter outclock_resource = "AUTO";
    parameter use_external_pll = "OFF";
    parameter implement_in_les = "OFF";
    parameter preemphasis_setting = 0;
    parameter vod_setting = 0;
    parameter differential_drive = 0;
    parameter outclock_multiply_by = 1;
    parameter coreclock_divide_by = 2;
    parameter outclock_duty_cycle = 50;
    parameter inclock_phase_shift = 0;
    parameter outclock_phase_shift = 0;
    parameter use_no_phase_shift = "ON";
    parameter pll_self_reset_on_loss_lock = "OFF";
    parameter refclk_frequency = "UNUSED";

parameter enable_clock_pin_mode = "UNUSED";
    parameter data_rate = "UNUSED";
    parameter lpm_type = "altlvds_tx";
    parameter lpm_hint = "UNUSED";
    parameter pll_compensation_mode = "AUTO";

// LOCAL_PARAMETERS_BEGIN

    // Specifies whether the source of the input clock is from a PLL
    parameter clk_src_is_pll = "off";

    // A STRATIX type of LVDS?
    parameter STRATIX_TX_STYLE = ((((intended_device_family == "Stratix") || (intended_device_family == "STRATIX") || (intended_device_family == "stratix") || (intended_device_family == "Yeager") || (intended_device_family == "YEAGER") || (intended_device_family == "yeager"))
                                || ((intended_device_family == "Stratix GX") || (intended_device_family == "STRATIX GX") || (intended_device_family == "stratix gx") || (intended_device_family == "Stratix-GX") || (intended_device_family == "STRATIX-GX") || (intended_device_family == "stratix-gx") || (intended_device_family == "StratixGX") || (intended_device_family == "STRATIXGX") || (intended_device_family == "stratixgx") || (intended_device_family == "Aurora") || (intended_device_family == "AURORA") || (intended_device_family == "aurora"))
                                ))
                                ? 1 : 0;

    // A STRATIXII type of LVDS?
    parameter STRATIXII_TX_STYLE = ((((intended_device_family == "Stratix II") || (intended_device_family == "STRATIX II") || (intended_device_family == "stratix ii") || (intended_device_family == "StratixII") || (intended_device_family == "STRATIXII") || (intended_device_family == "stratixii") || (intended_device_family == "Armstrong") || (intended_device_family == "ARMSTRONG") || (intended_device_family == "armstrong"))
                                || ((intended_device_family == "HardCopy II") || (intended_device_family == "HARDCOPY II") || (intended_device_family == "hardcopy ii") || (intended_device_family == "HardCopyII") || (intended_device_family == "HARDCOPYII") || (intended_device_family == "hardcopyii") || (intended_device_family == "Fusion") || (intended_device_family == "FUSION") || (intended_device_family == "fusion"))
                                || (((intended_device_family == "Stratix II GX") || (intended_device_family == "STRATIX II GX") || (intended_device_family == "stratix ii gx") || (intended_device_family == "StratixIIGX") || (intended_device_family == "STRATIXIIGX") || (intended_device_family == "stratixiigx"))
                                || ((intended_device_family == "Arria GX") || (intended_device_family == "ARRIA GX") || (intended_device_family == "arria gx") || (intended_device_family == "ArriaGX") || (intended_device_family == "ARRIAGX") || (intended_device_family == "arriagx") || (intended_device_family == "Stratix II GX Lite") || (intended_device_family == "STRATIX II GX LITE") || (intended_device_family == "stratix ii gx lite") || (intended_device_family == "StratixIIGXLite") || (intended_device_family == "STRATIXIIGXLITE") || (intended_device_family == "stratixiigxlite"))
                                ) ))
                                ? 1 : 0;

    // A Cyclone type of LVDS?
    parameter CYCLONE_TX_STYLE = ((((intended_device_family == "Cyclone") || (intended_device_family == "CYCLONE") || (intended_device_family == "cyclone") || (intended_device_family == "ACEX2K") || (intended_device_family == "acex2k") || (intended_device_family == "ACEX 2K") || (intended_device_family == "acex 2k") || (intended_device_family == "Tornado") || (intended_device_family == "TORNADO") || (intended_device_family == "tornado"))
                                ))
                                ? 1 : 0;

    // A Cyclone II type of LVDS?
    parameter CYCLONEII_TX_STYLE = ((((intended_device_family == "Cyclone II") || (intended_device_family == "CYCLONE II") || (intended_device_family == "cyclone ii") || (intended_device_family == "Cycloneii") || (intended_device_family == "CYCLONEII") || (intended_device_family == "cycloneii") || (intended_device_family == "Magellan") || (intended_device_family == "MAGELLAN") || (intended_device_family == "magellan") || (intended_device_family == "CycloneII") || (intended_device_family == "CYCLONEII") || (intended_device_family == "cycloneii"))
                                ))
                                ? 1 : 0;

    // A Stratix III type of LVDS?
    parameter STRATIXIII_TX_STYLE = ((((intended_device_family == "Stratix III") || (intended_device_family == "STRATIX III") || (intended_device_family == "stratix iii") || (intended_device_family == "StratixIII") || (intended_device_family == "STRATIXIII") || (intended_device_family == "stratixiii") || (intended_device_family == "Titan") || (intended_device_family == "TITAN") || (intended_device_family == "titan") || (intended_device_family == "SIII") || (intended_device_family == "siii"))
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

// cycloneiii_msg
    // A Cyclone III type of LVDS?
    parameter CYCLONEIII_TX_STYLE = ((((intended_device_family == "Cyclone III") || (intended_device_family == "CYCLONE III") || (intended_device_family == "cyclone iii") || (intended_device_family == "CycloneIII") || (intended_device_family == "CYCLONEIII") || (intended_device_family == "cycloneiii") || (intended_device_family == "Barracuda") || (intended_device_family == "BARRACUDA") || (intended_device_family == "barracuda") || (intended_device_family == "Cuda") || (intended_device_family == "CUDA") || (intended_device_family == "cuda") || (intended_device_family == "CIII") || (intended_device_family == "ciii"))
                                || ((intended_device_family == "Cyclone III LS") || (intended_device_family == "CYCLONE III LS") || (intended_device_family == "cyclone iii ls") || (intended_device_family == "CycloneIIILS") || (intended_device_family == "CYCLONEIIILS") || (intended_device_family == "cycloneiiils") || (intended_device_family == "Cyclone III LPS") || (intended_device_family == "CYCLONE III LPS") || (intended_device_family == "cyclone iii lps") || (intended_device_family == "Cyclone LPS") || (intended_device_family == "CYCLONE LPS") || (intended_device_family == "cyclone lps") || (intended_device_family == "CycloneLPS") || (intended_device_family == "CYCLONELPS") || (intended_device_family == "cyclonelps") || (intended_device_family == "Tarpon") || (intended_device_family == "TARPON") || (intended_device_family == "tarpon") || (intended_device_family == "Cyclone IIIE") || (intended_device_family == "CYCLONE IIIE") || (intended_device_family == "cyclone iiie"))
                                || ((intended_device_family == "Cyclone IV GX") || (intended_device_family == "CYCLONE IV GX") || (intended_device_family == "cyclone iv gx") || (intended_device_family == "Cyclone IVGX") || (intended_device_family == "CYCLONE IVGX") || (intended_device_family == "cyclone ivgx") || (intended_device_family == "CycloneIV GX") || (intended_device_family == "CYCLONEIV GX") || (intended_device_family == "cycloneiv gx") || (intended_device_family == "CycloneIVGX") || (intended_device_family == "CYCLONEIVGX") || (intended_device_family == "cycloneivgx") || (intended_device_family == "Cyclone IV") || (intended_device_family == "CYCLONE IV") || (intended_device_family == "cyclone iv") || (intended_device_family == "CycloneIV") || (intended_device_family == "CYCLONEIV") || (intended_device_family == "cycloneiv") || (intended_device_family == "Cyclone IV (GX)") || (intended_device_family == "CYCLONE IV (GX)") || (intended_device_family == "cyclone iv (gx)") || (intended_device_family == "CycloneIV(GX)") || (intended_device_family == "CYCLONEIV(GX)") || (intended_device_family == "cycloneiv(gx)") || (intended_device_family == "Cyclone III GX") || (intended_device_family == "CYCLONE III GX") || (intended_device_family == "cyclone iii gx") || (intended_device_family == "CycloneIII GX") || (intended_device_family == "CYCLONEIII GX") || (intended_device_family == "cycloneiii gx") || (intended_device_family == "Cyclone IIIGX") || (intended_device_family == "CYCLONE IIIGX") || (intended_device_family == "cyclone iiigx") || (intended_device_family == "CycloneIIIGX") || (intended_device_family == "CYCLONEIIIGX") || (intended_device_family == "cycloneiiigx") || (intended_device_family == "Cyclone III GL") || (intended_device_family == "CYCLONE III GL") || (intended_device_family == "cyclone iii gl") || (intended_device_family == "CycloneIII GL") || (intended_device_family == "CYCLONEIII GL") || (intended_device_family == "cycloneiii gl") || (intended_device_family == "Cyclone IIIGL") || (intended_device_family == "CYCLONE IIIGL") || (intended_device_family == "cyclone iiigl") || (intended_device_family == "CycloneIIIGL") || (intended_device_family == "CYCLONEIIIGL") || (intended_device_family == "cycloneiiigl") || (intended_device_family == "Stingray") || (intended_device_family == "STINGRAY") || (intended_device_family == "stingray"))
                                || (((intended_device_family == "Cyclone IV E") || (intended_device_family == "CYCLONE IV E") || (intended_device_family == "cyclone iv e") || (intended_device_family == "CycloneIV E") || (intended_device_family == "CYCLONEIV E") || (intended_device_family == "cycloneiv e") || (intended_device_family == "Cyclone IVE") || (intended_device_family == "CYCLONE IVE") || (intended_device_family == "cyclone ive") || (intended_device_family == "CycloneIVE") || (intended_device_family == "CYCLONEIVE") || (intended_device_family == "cycloneive"))
                                ) || (((intended_device_family == "MAX 10") || (intended_device_family == "max 10") || (intended_device_family == "MAX 10 FPGA") || (intended_device_family == "max 10 fpga") || (intended_device_family == "Zippleback") || (intended_device_family == "ZIPPLEBACK") || (intended_device_family == "zippleback") || (intended_device_family == "MAX10") || (intended_device_family == "max10") || (intended_device_family == "MAX 10 (DA/DF/DC/SA/SC)") || (intended_device_family == "max 10 (da/df/dc/sa/sc)") || (intended_device_family == "MAX10(DA/DF/DC/SA/SC)") || (intended_device_family == "max10(da/df/dc/sa/sc)") || (intended_device_family == "MAX 10 (DA)") || (intended_device_family == "max 10 (da)") || (intended_device_family == "MAX10(DA)") || (intended_device_family == "max10(da)") || (intended_device_family == "MAX 10 (DF)") || (intended_device_family == "max 10 (df)") || (intended_device_family == "MAX10(DF)") || (intended_device_family == "max10(df)") || (intended_device_family == "MAX 10 (DC)") || (intended_device_family == "max 10 (dc)") || (intended_device_family == "MAX10(DC)") || (intended_device_family == "max10(dc)") || (intended_device_family == "MAX 10 (SA)") || (intended_device_family == "max 10 (sa)") || (intended_device_family == "MAX10(SA)") || (intended_device_family == "max10(sa)") || (intended_device_family == "MAX 10 (SC)") || (intended_device_family == "max 10 (sc)") || (intended_device_family == "MAX10(SC)") || (intended_device_family == "max10(sc)"))
                                ) ))
                                ? 1 : 0;
// maxv_msg
    // A MAX V type of LVDS?
    parameter MAXV_TX_STYLE = ((((intended_device_family == "MAX V") || (intended_device_family == "max v") || (intended_device_family == "MAXV") || (intended_device_family == "maxv") || (intended_device_family == "Jade") || (intended_device_family == "JADE") || (intended_device_family == "jade"))
                                ))
                                ? 1 : 0;
// cycloneiii_msg

    // Is the device family has flexible LVDS?
    parameter FAMILY_HAS_FLEXIBLE_LVDS = ((CYCLONE_TX_STYLE == 1) ||
                                (CYCLONEII_TX_STYLE == 1) || (MAXV_TX_STYLE == 1) ||
                                (CYCLONEIII_TX_STYLE == 1) ||
                                (((STRATIX_TX_STYLE == 1) || (STRATIXII_TX_STYLE == 1) ||
                                (STRATIXIII_TX_STYLE == 1)) &&
                                (implement_in_les == "ON")))
                                ? 1 : 0;

    // Is the family has Stratix style PLL
    parameter FAMILY_HAS_STRATIX_STYLE_PLL = ((STRATIX_TX_STYLE == 1) ||
                                (CYCLONE_TX_STYLE == 1))
                                ? 1 : 0;

    // Is the family has Stratix II style PLL
    parameter FAMILY_HAS_STRATIXII_STYLE_PLL = ((STRATIXII_TX_STYLE == 1) ||
                                (CYCLONEII_TX_STYLE == 1))
                                ? 1 : 0;

    // Is the family has Stratix III style PLL
    parameter FAMILY_HAS_STRATIXIII_STYLE_PLL = ((STRATIXIII_TX_STYLE == 1) || (CYCLONEIII_TX_STYLE == 1))
                                ? 1 : 0;

    // calculate clock boost for device family other than STRATIX and STRATIX GX
    parameter INT_CLOCK_BOOST = ((inclock_boost == 0)
                                    ? deserialization_factor
                                    : inclock_boost);

    // M value for Stratix/Stratix II/Cyclone/Cyclone II PLL
    parameter PLL_M_VALUE = (((output_data_rate * inclock_period)
                                    + (5 * 100000)) / 1000000);

    // D value for Stratix/Stratix II/Cyclone/Cyclone II PLL
    parameter PLL_D_VALUE = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                ? ((output_data_rate !=0) && (inclock_period !=0)
                                    ? 2
                                    : 1)
                                : 1;
                                    
    // calculate clock boost for STRATIX, STRATIX GX and STRATIX II
    parameter STRATIX_INCLOCK_BOOST =
                                ((output_data_rate !=0) && (inclock_period !=0))
                                    ? PLL_M_VALUE :
                                ((inclock_boost == 0)
                                    ? deserialization_factor
                                    : inclock_boost);

    // parameter for inclock phase shift. Add 0.5 to the calculated result to
    // round up result to the nearest integer.
    // CENTER_ALIGNED means 180 degrees
    parameter PHASE_INCLOCK = (inclock_data_alignment == "UNUSED") ?
                                inclock_phase_shift :
                            (inclock_data_alignment == "EDGE_ALIGNED")?
                                0 :
                            (inclock_data_alignment == "CENTER_ALIGNED") ?
                                (0.5 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "45_DEGREES") ?
                                (0.125 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "90_DEGREES") ?
                                (0.25 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "135_DEGREES") ?
                                (0.375 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "180_DEGREES") ?
                                (0.5 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "225_DEGREES") ?
                                (0.625 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "270_DEGREES") ?
                                (0.75 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5:
                            (inclock_data_alignment == "315_DEGREES") ?
                                (0.875 * inclock_period / STRATIX_INCLOCK_BOOST) + 0.5: 0;

    // parameter for Stratix II inclock phase shift.
    parameter STXII_PHASE_INCLOCK = PHASE_INCLOCK - (0.5 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for outclock phase shift. Add 0.5 to the calculated result to
    // round up result to the nearest integer.
    parameter PHASE_OUTCLOCK = (outclock_alignment == "UNUSED") ?
                                outclock_phase_shift :
                            (outclock_alignment == "EDGE_ALIGNED") ?
                                0:
                            (outclock_alignment == "CENTER_ALIGNED") ?
                                ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "45_DEGREES") ?
                                ((0.125 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "90_DEGREES") ?
                                ((0.25 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "135_DEGREES") ?
                                ((0.375 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "180_DEGREES") ?
                                ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "225_DEGREES") ?
                                ((0.625 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "270_DEGREES") ?
                                ((0.75 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5):
                            (outclock_alignment == "315_DEGREES") ?
                                ((0.875 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5): 0;

    // parameter for Stratix and Stratix GX outclock phase shift.
    // Add 0.5 to the calculated result to round up result to the nearest integer.
    parameter STX_PHASE_OUTCLOCK  = ((outclock_divide_by == 1) ||
                            (outclock_alignment == "45_DEGREES") ||
                            (outclock_alignment == "90_DEGREES") ||
                            (outclock_alignment == "135_DEGREES")) ?
                                PHASE_OUTCLOCK + PHASE_INCLOCK:
                            (outclock_alignment == "UNUSED") ?
                                ((outclock_phase_shift >= ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST))) ?
                                    PHASE_OUTCLOCK + PHASE_INCLOCK - ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST)) :
                                    PHASE_OUTCLOCK + PHASE_INCLOCK) :
                            ((outclock_alignment == "180_DEGREES") ||
                            (outclock_alignment == "CENTER_ALIGNED")) ?
                                PHASE_INCLOCK :
                            (outclock_alignment == "225_DEGREES") ?
                                ((0.125 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5 + PHASE_INCLOCK):
                            (outclock_alignment == "270_DEGREES") ?
                                ((0.25 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5 + PHASE_INCLOCK):
                            (outclock_alignment == "315_DEGREES") ?
                                ((0.375 * inclock_period / STRATIX_INCLOCK_BOOST) +
                                    0.5 + PHASE_INCLOCK): PHASE_INCLOCK;

    // parameter for Stratix II outclock phase shift.
    parameter STXII_PHASE_OUTCLOCK = STX_PHASE_OUTCLOCK - (0.5 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for inclock phase shift of StratixII in LE mode.
    parameter STXII_LE_PHASE_INCLOCK = (use_no_phase_shift == "ON") ? PHASE_INCLOCK : PHASE_INCLOCK - (0.25 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for inclock phase shift of StratixII in LE mode.
    parameter STXII_LE_PHASE_OUTCLOCK = (use_no_phase_shift == "ON") ? PHASE_OUTCLOCK : PHASE_OUTCLOCK - (0.25 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for inclock phase shift of StratixIII in LE mode.
    parameter STXIII_LE_PHASE_INCLOCK = PHASE_INCLOCK - (0.25 * inclock_period / STRATIX_INCLOCK_BOOST);

    // parameter for inclock phase shift of StratixIII in LE mode.
    parameter STXIII_LE_PHASE_OUTCLOCK = PHASE_OUTCLOCK - (0.25 * inclock_period / STRATIX_INCLOCK_BOOST);

    parameter REGISTER_WIDTH = deserialization_factor * number_of_channels;

    parameter FAST_CLK_ENA_PHASE_SHIFT = (deserialization_factor*2-3) * (inclock_period/(2*STRATIX_INCLOCK_BOOST));

    // input clock period for PLL.
    parameter CLOCK_PERIOD = (deserialization_factor > 2) ? inclock_period : 10000;
    
    parameter USE_NEW_CORECLK_CKT = (deserialization_factor%2 == 1) && (coreclock_divide_by == 1) ? "TRUE" : "FALSE";

// LOCAL_PARAMETERS_END

// INPUT PORT DECLARATION

    // Input data (required)
    input  [REGISTER_WIDTH -1 : 0] tx_in;

    // Input clock (required)
    input tx_inclock;

    input tx_syncclock;

    input tx_enable;

    // Optional clock for input registers  (Required if "multi_clock" parameters
    // is turned on)
    input sync_inclock;

    // Enable control for the LVDS PLL
    input tx_pll_enable;

    // Asynchronously resets all counters to initial values (only for Stratix
    // and Stratix GX devices)
    input pll_areset;
    
    input tx_data_reset;


// OUTPUT PORT DECLARATION

    // Serialized data signal(required)
    output [number_of_channels-1 :0] tx_out;

    // External reference clock
    output tx_outclock;

    // Output clock used to feed non-peripheral logic.
    // Only available for Stratix, and Stratix GX devices only.
    output tx_coreclock;

    // Gives the status of the LVDS PLL
    // (when the PLL is locked, this signal is VCC. GND otherwise)
    output tx_locked;


// INTERNAL REGISTERS DECLARATION

    reg [REGISTER_WIDTH -1 : 0] tx_in_reg;
    reg [REGISTER_WIDTH -1 : 0] tx_shift_reg;
    reg [REGISTER_WIDTH -1 : 0] tx_parallel_load_reg;
    reg fb;
    reg [number_of_channels-1 :0] tx_out_stratix;
    reg [number_of_channels-1 :0] tx_ddio_out;
    reg [number_of_channels-1 :0] dataout_l;
    reg [number_of_channels-1 :0] dataout_h;
    reg enable0_reg1;
    reg enable0_reg2;
    reg enable0_neg;
    reg non_50_duty_cycle_is_valid;
    reg [9 : 0] stx_phase_shift_txdata;
    reg [9 : 0] phase_shift_txdata;
    reg stratixiii_enable0_dly;
    reg stratixiii_enable1_dly;
    reg pll_lock_sync;

// INTERNAL WIRE DECLARATION

    wire [REGISTER_WIDTH -1 : 0] tx_in_int;
    wire tx_fastclk;
    wire tx_slowclk;
    wire tx_reg_clk;
    wire tx_coreclock_int;
    wire tx_locked_int;
    wire unused_clk_ext;
    wire [1:0] stratix_pll_inclock;
    wire [1:0] stratixii_pll_inclock;
    wire [1:0] stratixiii_pll_inclock;
    wire [5:0] stratix_pll_outclock;
    wire [5:0] stratixii_pll_outclock;
    wire [9:0] stratixiii_pll_outclock;
    wire stratix_pll_enable;
    wire stratixii_pll_enable;
    wire stratix_pll_areset;
    wire stratixii_pll_areset;
    wire stratixiii_pll_areset;
    wire stratix_locked;
    wire stratixii_locked;
    wire stratixiii_locked;
    wire stratix_enable0;
    wire stratixii_enable0;
    wire stratixiii_enable0;
    wire stratix_enable1;
    wire stratixii_enable1;
    wire stratixiii_enable1;
    wire stratix_outclock;
    wire stratixii_outclock;
    wire stratixii_sclkout0;
    wire stratixii_sclkout1;
    wire stratix_inclock;
    wire stratix_enable;
    wire stratixii_inclock;
    wire stratixii_enable;
    wire flvds_fastclk;
    wire flvds_slowclk;
    wire flvds_regclk;
    wire flvds_pll_outclock;
    wire flvds_outclock;
    wire[number_of_channels-1 :0] flvds_dataout;
    wire local_clk_div_lloaden;

// INTERNAL TRI DECLARATION

    tri1 tx_enable;
    tri0 sync_inclock;
    tri1 tx_pll_enable;
    tri0 pll_areset;

// LOCAL INTEGER DECLARATION

    integer count;
    integer i;
    integer i1;
    integer i2;
    integer negedge_count;
    integer shift_data;

// LOCAL TIME DECLARATION

    time tx_out_delay;

// COMPONENT INSTANTIATIONS
    ALTERA_DEVICE_FAMILIES dev ();

// INITIAL CONSTRUCT BLOCK

    initial
    begin : INITIALIZATION
        tx_in_reg = {REGISTER_WIDTH{1'b0}};
        tx_parallel_load_reg = {REGISTER_WIDTH{1'b0}};
        tx_shift_reg = {REGISTER_WIDTH{1'b0}};

        tx_out_stratix = {number_of_channels{1'b0}};
        tx_ddio_out = {number_of_channels{1'b0}};
        dataout_l = {number_of_channels{1'b0}};
        dataout_h = {number_of_channels{1'b0}};

        fb = 'b1;
        pll_lock_sync = 1'b1;
        count = 0;
        shift_data = 0;
        negedge_count = 0;
        stratixiii_enable0_dly = 1'b0;
        stratixiii_enable1_dly = 1'b0;
        tx_out_delay = inclock_period/(deserialization_factor*2);

        // Input data needed by stratix_tx_outclk in order to generate the tx_outclock.
        stx_phase_shift_txdata = 0;
        if (outclock_divide_by > 1)
        begin
            if (deserialization_factor == 4)
            begin
                if ( outclock_divide_by == 2)
                    stx_phase_shift_txdata[3:0] = 4'b1010;
                else if (outclock_divide_by == 4)
                    stx_phase_shift_txdata[3:0] = 4'b0011;
            end
            else if (deserialization_factor == 8)
            begin
                if (outclock_divide_by == 2)
                    stx_phase_shift_txdata[7:0] = 8'b10101010;
                else if (outclock_divide_by == 4)
                    stx_phase_shift_txdata[7:0] = 8'b00110011;
                else if (outclock_divide_by == 8)
                    stx_phase_shift_txdata[7:0] = 8'b11000011;
            end
            else if (deserialization_factor == 10)
            begin
                if (outclock_divide_by == 2)
                    stx_phase_shift_txdata[9:0] = 10'b1010101010;
                else if (outclock_divide_by == 10)
                    stx_phase_shift_txdata[9:0] = 10'b1110000011;
            end
            else if (deserialization_factor == 7)
                if (outclock_divide_by == 7)
                    stx_phase_shift_txdata[6:0] = 7'b1100011;
            else if (deserialization_factor == 9)
                if (outclock_divide_by == 9)
                    stx_phase_shift_txdata[8:0] = 9'b110000111;
            else if (deserialization_factor == 5)
                if (outclock_divide_by == 5)
                    stx_phase_shift_txdata[4:0] = 5'b10011;
        end

        // Input data needed by stratixii_tx_outclk in order to generate the tx_outclock.
        phase_shift_txdata = 0;
        if (outclock_divide_by > 1)
        begin
            if (deserialization_factor == 4)
            begin
                if ( outclock_divide_by == 2)
                    phase_shift_txdata[3:0] = 4'b1010;
                else if (outclock_divide_by == 4)
                    phase_shift_txdata[3:0] = 4'b1100;
            end
            else if (deserialization_factor == 6)
            begin
                if (outclock_divide_by == 2)
                    phase_shift_txdata[5:0] = 6'b101010;
                else if (outclock_divide_by == 6)
                    phase_shift_txdata[5:0] = 6'b111000;
            end
            else if (deserialization_factor == 8)
            begin
                if (outclock_divide_by == 2)
                    phase_shift_txdata[7:0] = 8'b10101010;
                else if (outclock_divide_by == 4)
                    phase_shift_txdata[7:0] = 8'b11001100;
                else if (outclock_divide_by == 8)
                    phase_shift_txdata[7:0] = 8'b11110000;
            end
            else if (deserialization_factor == 10)
            begin
                if (outclock_divide_by == 2)
                    phase_shift_txdata[9:0] = 10'b1010101010;
                else if (outclock_divide_by == 10)
                    phase_shift_txdata[9:0] = 10'b1111100000;
            end
            else if (deserialization_factor == 7)
            begin
                if (outclock_divide_by == 7)
                    phase_shift_txdata[6:0] = 7'b1111000;
            end
            else if (deserialization_factor == 9)
            begin
                if (outclock_divide_by == 9)
                    phase_shift_txdata[8:0] = 9'b110000111;
            end
            else if (deserialization_factor == 5)
            begin
                if (outclock_divide_by == 5)
                    phase_shift_txdata[4:0] = 5'b10011;
            end
            //SPR 338253 - add support for SIII deserialization 3, outclock divide 3 mode
            else if ((deserialization_factor == 3) && (STRATIXIII_TX_STYLE == 1))
            begin
                if (outclock_divide_by == 3)
                    phase_shift_txdata[2:0] = 3'b101;
            end
        end

        if ((STRATIX_TX_STYLE == 1) &&
                (deserialization_factor != 1) && (deserialization_factor != 2) &&
                ((deserialization_factor > 10) || (deserialization_factor < 4)))
        begin
            $display ($time, "ps Error: STRATIX does not support the specified deserialization factor!");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end
        else if ((STRATIXII_TX_STYLE == 1) &&
                (deserialization_factor > 10))
        begin
            $display ($time, "ps Error: STRATIX II does not support the specified deserialization factor!");
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end
        
        // Invalid parameter checking for LE based lvds transmitter
        if (FAMILY_HAS_FLEXIBLE_LVDS == 1)
        begin
            non_50_duty_cycle_is_valid = 0;

            if ((deserialization_factor % 2) == 1)
            begin
                if ((outclock_multiply_by != 1) && (outclock_multiply_by != 2))
                begin
                    $display ("Error! Only values of 1 and 2 are allowed for outclock_multiply_by.");
                    $display("Time: %0t  Instance: %m", $time);
                    $finish;
                end
                if ((coreclock_divide_by != 1) && (coreclock_divide_by != 2))
                begin
                    $display ("Error! Only values of 1 and 2 are allowed for coreclock_divide_by.");
                    $display("Time: %0t  Instance: %m", $time);
                    $finish;
                end
                if ((coreclock_divide_by == 2) && (deserialization_factor%2 == 1))
                begin
                    if (CYCLONE_TX_STYLE  == 1)
                    begin
                        if (outclock_multiply_by == 2)
                        begin
                            $display ("Error! The specified combination of coreclock_divide_by, outclock_multiply_by, outclock_divide_by and deserialization_factor is not supported for %s.", intended_device_family);
                            $display("Time: %0t  Instance: %m", $time);
                            $display ("Use the megawizard to generate a valid configuration.");
                            $finish;
                        end
                    end
                end

                if (outclock_multiply_by == 2)
                begin
                    if (outclock_divide_by != deserialization_factor)
                    begin
                        $display ("Error! The specified combination of coreclock_divide_by, outclock_multiply_by, outclock_divide_by and deserialization_factor is not supported for %s.", intended_device_family);
                        $display("Time: %0t  Instance: %m", $time);
                        $display ("Use the megawizard to generate a valid configuration.");
                        $finish;
                    end
                end

                if (CYCLONE_TX_STYLE  == 1)
                begin
                    if ((outclock_divide_by == deserialization_factor) && (outclock_multiply_by == 1))
                        non_50_duty_cycle_is_valid = 1;
                end
                else
                begin
                    if ((outclock_divide_by == deserialization_factor) && ((outclock_multiply_by == 1) || (coreclock_divide_by == 2)))
                        non_50_duty_cycle_is_valid = 1;
                end
            end
            
            if (outclock_duty_cycle != 50)
            begin
                if (non_50_duty_cycle_is_valid)
                begin
                    if ((outclock_multiply_by == 2) && ((deserialization_factor % 2) == 1))
                    begin
                        if (deserialization_factor == 7)
                        begin
                            if (outclock_duty_cycle != 57)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 57.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                        else if (deserialization_factor == 9)
                        begin
                            if (outclock_duty_cycle != 56)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 56.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                        else if (deserialization_factor == 5)
                        begin
                            if (outclock_duty_cycle != 60)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 60.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                    end
                    else
                    begin
                        if (deserialization_factor == 7)
                        begin
                            if (outclock_duty_cycle != 57)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 50 and 57.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                        else if (deserialization_factor == 9)
                        begin
                            if (outclock_duty_cycle != 56)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 50 and 56.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                        else if (deserialization_factor == 5)
                        begin
                            if (outclock_duty_cycle != 60)
                            begin
                                $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 50 and 60.", outclock_duty_cycle);
                                $display("Time: %0t  Instance: %m", $time);
                                $finish;
                            end
                        end
                    end
                end
                else
                begin
                    $display ("Error! Illegal value of %0d specified for outclock_duty_cycle parameter. The legal value(s) for the specified parameter are 50.", outclock_duty_cycle);
                    $display("Time: %0t  Instance: %m", $time);
                    $finish;
                end
            end
        end

        if (dev.IS_VALID_FAMILY(intended_device_family) == 0)
        begin
            $display ("Error! Unknown INTENDED_DEVICE_FAMILY=%s.", intended_device_family);
            $display("Time: %0t  Instance: %m", $time);
            $finish;
        end

    end // INITIALIZATION


// COMPONENT INSTANTIATIONS

    // PLL for Stratix and Stratix GX
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
        .comparator(1'b0),
        .extclk(),
        .clkbad(),
        .enable0(stratix_enable0),
        .enable1(stratix_enable1),
        .activeclock(),
        .clkloss(),
        .scandataout() );

    defparam
        u1.primary_clock        = "inclk0",
        u1.pll_type             = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u1.inclk0_input_frequency = CLOCK_PERIOD,
        u1.valid_lock_multiplier  = 1,
        u1.clk0_multiply_by     = STRATIX_INCLOCK_BOOST,
        u1.clk0_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : 1,
        u1.clk0_phase_shift_num = PHASE_INCLOCK,
        u1.clk1_multiply_by     = (FAMILY_HAS_FLEXIBLE_LVDS == 1) && (CYCLONE_TX_STYLE  == 1)
                                    ? (((deserialization_factor%2 == 1) ||
                                        (deserialization_factor == 6) ||
                                        (deserialization_factor == 10)) &&
                                        (outclock_multiply_by == 2) &&
                                        (outclock_divide_by == deserialization_factor)
                                        ? STRATIX_INCLOCK_BOOST*2
                                        : STRATIX_INCLOCK_BOOST)
                                    : STRATIX_INCLOCK_BOOST,
        u1.clk1_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((CYCLONE_TX_STYLE  == 1)
                                        ? PLL_D_VALUE*outclock_divide_by
                                        : PLL_D_VALUE)
                                    : 1,
        u1.clk1_duty_cycle      = (FAMILY_HAS_FLEXIBLE_LVDS == 1) && (CYCLONE_TX_STYLE  == 1)
                                    ? outclock_duty_cycle
                                    : 50,
        u1.clk1_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PHASE_OUTCLOCK
                                    : STX_PHASE_OUTCLOCK,
        u1.clk2_multiply_by     = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 0) || (USE_NEW_CORECLK_CKT == "TRUE")
                                        ? STRATIX_INCLOCK_BOOST*2
                                        : STRATIX_INCLOCK_BOOST)
                                    : STRATIX_INCLOCK_BOOST,
        u1.clk2_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE*deserialization_factor
                                    : deserialization_factor,
        u1.clk2_phase_shift_num = PHASE_INCLOCK,
        u1.simulation_type      = "functional",
        u1.family_name          = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix",
        u1.m                    = 0;
    end
    endgenerate

    // PLL for Stratix II
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
        u2.pll_type             = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u2.vco_multiply_by      = STRATIX_INCLOCK_BOOST,
        u2.vco_divide_by        = 1,
        u2.inclk0_input_frequency = CLOCK_PERIOD,
        u2.clk0_multiply_by     = STRATIX_INCLOCK_BOOST,
        u2.clk0_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : deserialization_factor,
        u2.clk0_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXII_LE_PHASE_INCLOCK
                                    : STXII_PHASE_INCLOCK,
        u2.clk1_multiply_by     = STRATIX_INCLOCK_BOOST,
        u2.clk1_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : deserialization_factor,
        u2.clk1_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PHASE_OUTCLOCK
                                    : STXII_PHASE_OUTCLOCK,
        u2.clk2_multiply_by     = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 0) || (USE_NEW_CORECLK_CKT == "TRUE")
                                        ? STRATIX_INCLOCK_BOOST*2
                                        : STRATIX_INCLOCK_BOOST)
                                    : 1,
        u2.clk2_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE*deserialization_factor
                                    : 1,
        u2.clk2_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PHASE_INCLOCK
                                    : 1,
        u2.sclkout0_phase_shift = STXII_LE_PHASE_INCLOCK,
        u2.sclkout1_phase_shift = STXII_LE_PHASE_OUTCLOCK,
        u2.simulation_type      = "functional",
        u2.family_name          = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix II",
        u2.m                    = 0;
    end
    endgenerate

    // pll for Stratix III
    generate
    if ((FAMILY_HAS_STRATIXIII_STYLE_PLL == 1) && (use_external_pll == "OFF") &&
        (deserialization_factor > 2))
    begin : MF_stratixiii_pll
    MF_stratixiii_pll u6 (
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
        u6.pll_type             = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((inclock_data_alignment == "UNUSED") 
                                        ? "auto"
                                        : "flvds")
                                    : "lvds",
        u6.vco_multiply_by      = STRATIX_INCLOCK_BOOST,
        u6.vco_divide_by        = 1,
        u6.inclk0_input_frequency = CLOCK_PERIOD,
        u6.clk0_multiply_by     = STRATIX_INCLOCK_BOOST,
        u6.clk0_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : 1,
        u6.clk0_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXIII_LE_PHASE_INCLOCK
                                    : STXII_PHASE_INCLOCK,
        u6.clk1_multiply_by     = STRATIX_INCLOCK_BOOST,
        u6.clk1_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : deserialization_factor,
        u6.clk1_duty_cycle      = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 50
                                    : (100/deserialization_factor) + 0.5,
        u6.clk1_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXIII_LE_PHASE_OUTCLOCK
                                    : STXII_PHASE_INCLOCK + FAST_CLK_ENA_PHASE_SHIFT,
        u6.clk2_multiply_by     = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? ((deserialization_factor%2 == 0) || (USE_NEW_CORECLK_CKT == "TRUE")
                                        ? STRATIX_INCLOCK_BOOST*2
                                        : STRATIX_INCLOCK_BOOST)
                                    : STRATIX_INCLOCK_BOOST,
        u6.clk2_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE*deserialization_factor
                                    : deserialization_factor,
        u6.clk2_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? STXIII_LE_PHASE_INCLOCK
                                    : STXII_PHASE_INCLOCK,
        u6.clk3_multiply_by     = STRATIX_INCLOCK_BOOST,
        u6.clk3_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? PLL_D_VALUE
                                    : 1,
        u6.clk3_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 1
                                    : STXII_PHASE_OUTCLOCK,
        u6.clk4_multiply_by     = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 1
                                    : STRATIX_INCLOCK_BOOST,
        u6.clk4_divide_by       = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 1
                                    : deserialization_factor,
        u6.clk4_duty_cycle      = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 1
                                    : (100/deserialization_factor) + 0.5,
        u6.clk4_phase_shift_num = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? 1
                                    : STXII_PHASE_OUTCLOCK + FAST_CLK_ENA_PHASE_SHIFT,
        u6.simulation_type      = "functional",
        u6.family_name          = (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                                    ? intended_device_family
                                    : "Stratix III",
        u6.self_reset_on_loss_lock = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                    ? pll_self_reset_on_loss_lock
                                    : "OFF",
        u6.m                    = 0;
    end
    endgenerate

    // This module produces output clock for Stratix and Stratix GX.
    generate
    if ((STRATIX_TX_STYLE == 1) && (implement_in_les == "OFF") && (deserialization_factor > 2))
    begin : stratix_tx_outclk
    stratix_tx_outclk u3 (
        .tx_in(stx_phase_shift_txdata),
        .tx_fastclk(stratix_inclock),
        .tx_enable(stratix_enable),
        .tx_out(stratix_outclock));
    defparam
        u3.deserialization_factor = deserialization_factor,
        u3.bypass_serializer      = (outclock_divide_by == 1) ?
                                    "TRUE" : "'FALSE",
        u3.invert_clock           = ((outclock_alignment == "180_DEGREES")   ||
                                    (outclock_alignment == "CENTER_ALIGNED")) && (use_external_pll == "ON") ?
                                    "TRUE" : "FALSE",
        u3.use_falling_clock_edge = ((outclock_phase_shift >= ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST))) ||
                                    (outclock_alignment == "180_DEGREES")   ||
                                    (outclock_alignment == "CENTER_ALIGNED") ||
                                    (outclock_alignment == "225_DEGREES")    ||
                                    (outclock_alignment == "270_DEGREES")    ||
                                    (outclock_alignment == "315_DEGREES")) ?
                                    "TRUE" : "FALSE";
    end
    endgenerate

    
    // This module produces output clock for StratixII.
    generate
    if (((STRATIXII_TX_STYLE == 1) || (STRATIXIII_TX_STYLE == 1)) &&
            (implement_in_les == "OFF") && (deserialization_factor > 2)) 
    begin: stratixii_tx_outclk
    stratixii_tx_outclk u4 (
        .tx_in(phase_shift_txdata),
        .tx_fastclk(stratixii_inclock),
        .tx_enable(stratixii_enable),
        .tx_out(stratixii_outclock));

    defparam
        u4.deserialization_factor = deserialization_factor,
        u4.bypass_serializer      = (outclock_divide_by == 1) ?
                                    "TRUE" : "'FALSE",
        u4.invert_clock           = ((outclock_alignment == "180_DEGREES")   ||
                                    (outclock_alignment == "CENTER_ALIGNED")) && (use_external_pll == "ON") ?
                                    "TRUE" : "FALSE",
        u4.use_falling_clock_edge = ((outclock_phase_shift >= ((0.5 * inclock_period / STRATIX_INCLOCK_BOOST))) ||
                                    (outclock_alignment == "180_DEGREES")   ||
                                    (outclock_alignment == "CENTER_ALIGNED") ||
                                    (outclock_alignment == "225_DEGREES")    ||
                                    (outclock_alignment == "270_DEGREES")    ||
                                    (outclock_alignment == "315_DEGREES")) ?
                                    "TRUE" : "FALSE";
    end
    endgenerate

    // This module produces output clock for StratixII.
    generate
    if (((FAMILY_HAS_FLEXIBLE_LVDS == 1) && (deserialization_factor > 2)) || (MAXV_TX_STYLE == 1))
    begin: flexible_lvds_tx
    flexible_lvds_tx u5 (
        .tx_in(tx_in),
        .tx_fastclk(flvds_fastclk),
        .tx_slowclk(flvds_slowclk),
        .tx_regclk(flvds_regclk),
        .tx_locked(tx_locked_int),
        .pll_areset(pll_areset | tx_data_reset),
        .pll_outclock(flvds_pll_outclock),
        .tx_out(flvds_dataout),
        .tx_outclock(flvds_outclock));

    defparam
        u5.number_of_channels     = number_of_channels,
        u5.deserialization_factor = deserialization_factor,
        u5.registered_input       = registered_input,
        u5.use_new_coreclk_ckt    = USE_NEW_CORECLK_CKT,
        u5.outclock_multiply_by   = outclock_multiply_by,
        u5.outclock_duty_cycle    = outclock_duty_cycle,
        u5.outclock_divide_by     = outclock_divide_by,
        u5.use_self_generated_outclock = (CYCLONE_TX_STYLE  == 0) ? "TRUE" : "FALSE";
    end
    endgenerate

    // This module produces lloaden clock from local clock divider.
    generate
    if ((STRATIXIII_TX_STYLE == 1) && (enable_clock_pin_mode == "ON") &&
            (implement_in_les == "OFF") && (deserialization_factor > 2)) 
    begin: stratixv_local_clk_divider
    stratixv_local_clk_divider u6 (
        .clkin(tx_fastclk),
        .lloaden(local_clk_div_lloaden));

    defparam
        u6.clk_divide_by = deserialization_factor;
    end
    endgenerate

// ALWAYS CONSTRUCT BLOCK

    // For x2 mode. For each data channel, input data are separated into 2 data
    // stream which will be transmitted on different edge of input clock.
    always @ (posedge tx_inclock)
    begin : DDIO_OUT_RECEIVE
        if (deserialization_factor == 2)
        begin
            for (i1 = 0;  i1 < number_of_channels; i1 = i1 +1)
            begin
                dataout_l[i1] <= tx_in_int[i1*2];
                dataout_h[i1] <= tx_in_int[i1*2+1];
            end
        end
    end // DDIO_OUT_RECEIVE

    // Fast Clock
    always @ (posedge tx_fastclk)
    begin : FAST_CLOCK_POS
        if (deserialization_factor > 2)
        begin
        
            // registering load enable signal
            enable0_reg2 <= enable0_reg1;
            enable0_reg1 <= (use_external_pll == "ON") ? tx_enable :
                            (STRATIX_TX_STYLE == 1)   ? stratix_enable0 :
                            (STRATIXII_TX_STYLE == 1)  ? stratixii_enable0 :
                                                        stratixiii_enable0_dly;

                if(((STRATIX_TX_STYLE == 1) && (enable0_neg == 1)) ||
                    (((STRATIXII_TX_STYLE == 1) || (STRATIXIII_TX_STYLE == 1)) && (enable0_reg1 == 1)))
                begin
                    tx_shift_reg <= tx_parallel_load_reg;
                    count <= 2;

                    for (i = 0;  i < number_of_channels; i = i +1)
                    begin
                        tx_out_stratix[i] <= tx_parallel_load_reg[(i+1)*deserialization_factor - 1];
                    end
                end
                else
                begin
                    count <= (count % deserialization_factor) + 1;
                    for (i = 0;  i < number_of_channels; i = i +1)
                    begin
                        tx_out_stratix[i] <= tx_shift_reg[(i+1)*deserialization_factor - count];
                    end
                end

                // Loading data to parallel load register for Stratix and
                // Stratix GX
                if (((STRATIX_TX_STYLE == 1) && (stratix_enable0 == 1)) ||
                    (STRATIXII_TX_STYLE == 1) || (STRATIXIII_TX_STYLE == 1))
                begin
                    tx_parallel_load_reg <= tx_in_int;
                end
        end
    end // FAST_CLOCK_POS

        always @ (negedge tx_fastclk)
    begin : FAST_CLOCK_NEG
        if (deserialization_factor > 2)
        begin
            // registering load enable signal
            enable0_neg <= enable0_reg2;

            negedge_count <= negedge_count + 1;
    
            // Loading data to parallel load register for non-STRATIX family
            if ((negedge_count == 2) && (STRATIX_TX_STYLE == 0) &&
                (STRATIXII_TX_STYLE == 0) && (STRATIXIII_TX_STYLE == 0) &&
                (tx_locked_int == 1))
            begin
                tx_parallel_load_reg <= tx_in_int;
            end
        end
    end // FAST_CLOCK_NEG

    // Slow Clock
    always @ (posedge tx_slowclk)
    begin : SLOW_CLOCK
        negedge_count <= 0;
    end // SLOW_CLOCK

    // synchronization register
    always @ (posedge tx_reg_clk)
    begin : SYNC_REGISTER
        tx_in_reg <= #5 tx_in;
    end // SYNC_REGISTER

    always @ (stratixiii_enable0)
    begin
        stratixiii_enable0_dly <= stratixiii_enable0;
    end

    always @ (stratixiii_enable1)
    begin
        stratixiii_enable1_dly <= stratixiii_enable1;
    end
    
    always @(posedge stratixiii_locked or posedge pll_areset)
    begin
        if (pll_areset)
            pll_lock_sync <= 1'b0;
        else
            pll_lock_sync <= 1'b1;
    end 

    // CONTINOUS ASSIGNMENT
    assign tx_out        =  (deserialization_factor == 1)
                                ? tx_in_int[number_of_channels-1 :0] :
                            (deserialization_factor == 2)
                                ? ((tx_inclock == 1) ? dataout_h : dataout_l) :
                            (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                ? flvds_dataout :
                            ((STRATIX_TX_STYLE == 1) || (STRATIXII_TX_STYLE == 1)
                                || (STRATIXIII_TX_STYLE == 1))
                                ? tx_out_stratix
                                : {number_of_channels{1'b0}};

    assign tx_in_int     =  (registered_input != "OFF")
                                ? tx_in_reg
                                : tx_in;

    assign tx_reg_clk    =  ((deserialization_factor > 2) &&
                                ((STRATIX_TX_STYLE == 1) ||
                                (((STRATIXII_TX_STYLE == 1) ||
                                (CYCLONE_TX_STYLE == 1) ||
                                (CYCLONEII_TX_STYLE == 1) ||
                                (STRATIXIII_TX_STYLE == 1) || (CYCLONEIII_TX_STYLE == 1)) &&
                                (use_external_pll == "OFF"))))
                                    ? ((registered_input == "TX_CLKIN")
                                        ? tx_inclock
                                        : tx_coreclock_int) :
                            (((registered_input == "ON") &&
                                (multi_clock == "ON"))
                                ? sync_inclock
                                : tx_inclock);

    assign tx_outclock   =  (deserialization_factor < 3)
                                ? tx_inclock :
                            (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                ? flvds_outclock :
                            (STRATIX_TX_STYLE == 1)
                                ? stratix_outclock :
                            ((STRATIXII_TX_STYLE == 1) || (STRATIXIII_TX_STYLE == 1))
                                ? stratixii_outclock
                                : tx_slowclk;

    assign flvds_pll_outclock   = ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                                ? stratix_pll_outclock[1] :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                                ? stratixii_pll_outclock[1] :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                                ? stratixiii_pll_outclock[1] 
                                : tx_slowclk;

    assign tx_coreclock  =  tx_coreclock_int;

    assign tx_coreclock_int  =  (deserialization_factor < 3)
                                ? 1'b0 :
                            (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                                ? flvds_slowclk
                                : tx_slowclk;

    assign tx_locked     =  (deserialization_factor > 2)
                                ? tx_locked_int
                                : 1'b1;

    assign tx_locked_int =  ((STRATIX_TX_STYLE == 1) ||
                            (CYCLONE_TX_STYLE == 1))
                                ? stratix_locked :
                            ((STRATIXII_TX_STYLE == 1) ||
                            (CYCLONEII_TX_STYLE == 1))
                                ? stratixii_locked :
                            ((STRATIXIII_TX_STYLE == 1) || (CYCLONEIII_TX_STYLE == 1))
                                ? stratixiii_locked & pll_lock_sync
                                : 1'b1;

    assign tx_fastclk  =    ((deserialization_factor < 3) ||
                            (FAMILY_HAS_FLEXIBLE_LVDS == 1))
                                ? 1'b0 :
                            ((use_external_pll == "ON") || (enable_clock_pin_mode == "ON"))
                                ? tx_inclock :
                            (STRATIX_TX_STYLE == 1)
                                ? stratix_pll_outclock[0] :
                            (STRATIXII_TX_STYLE == 1)
                                ? stratixii_sclkout0 :
                            (STRATIXIII_TX_STYLE == 1)
                                ? stratixiii_pll_outclock[0]
                                : 1'b0;

    assign tx_slowclk   =   ((use_external_pll == "ON") ||
                            (FAMILY_HAS_FLEXIBLE_LVDS == 1))
                                ? 1'b0 :
                            (STRATIX_TX_STYLE == 1)
                                ? stratix_pll_outclock[2] :
                            (STRATIXII_TX_STYLE == 1)
                                ? stratixii_pll_outclock[0] :
                            (STRATIXIII_TX_STYLE == 1)
                                ? stratixiii_pll_outclock[2]
                                : 1'b0;

    assign stratix_pll_inclock[1:0] = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                                    ? {1'b0, tx_inclock}
                                    : 2'b00;

    assign stratixii_pll_inclock[1:0] = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                                    ? {1'b0, tx_inclock}
                                    : 2'b00;

    assign stratixiii_pll_inclock[1:0] = (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                                    ? {1'b0, tx_inclock}
                                    : 2'b00;

    assign stratix_pll_enable = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                                    ? tx_pll_enable
                                    : 1'b0;

    assign stratixii_pll_enable = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                                    ? tx_pll_enable
                                    : 1'b0;

    assign stratix_pll_areset = (FAMILY_HAS_STRATIX_STYLE_PLL == 1)
                                    ? pll_areset
                                    : 1'b0;

    assign stratixii_pll_areset = (FAMILY_HAS_STRATIXII_STYLE_PLL == 1)
                                    ? pll_areset
                                    : 1'b0;

    assign stratixiii_pll_areset = (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1)
                                    ? pll_areset
                                    : 1'b0;

    assign stratix_inclock = ((STRATIX_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? stratix_pll_outclock[1]
                                : 1'b0;

    assign stratix_enable  = ((STRATIX_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? stratix_enable1
                                : 1'b0;

    assign stratixii_inclock = ((STRATIXII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? ((use_external_pll == "ON")
                                    ? tx_inclock
                                    : stratixii_sclkout1) :
                                ((STRATIXIII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? (((use_external_pll == "ON") || (enable_clock_pin_mode == "ON"))
                                    ? tx_inclock
                                    : stratixiii_pll_outclock[3])
                                : 1'b0;

    assign stratixii_enable  = ((STRATIXII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? ((use_external_pll == "ON")
                                    ? tx_enable
                                    : stratixii_enable1) :
                                ((STRATIXIII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ? ((use_external_pll == "ON")
                                    ? tx_enable
                                    : stratixiii_enable1_dly)
                                : 1'b0;

    assign stratixiii_enable0 = ((STRATIXIII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ?((enable_clock_pin_mode == "ON")
                                ?local_clk_div_lloaden:
                                stratixiii_pll_outclock[1]) 
                                : 1'b0;

    assign stratixiii_enable1 = ((STRATIXIII_TX_STYLE == 1) &&
                                (implement_in_les == "OFF"))
                                ?((enable_clock_pin_mode == "ON") 
                                ?local_clk_div_lloaden:
                                stratixiii_pll_outclock[4])
                                : 1'b0;

    assign flvds_fastclk = ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_inclock
                                : stratix_pll_outclock[0]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_inclock
                                : stratixii_pll_outclock[0]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_inclock
                                : stratixiii_pll_outclock[0]) :
                            (MAXV_TX_STYLE == 1)
                            ? tx_inclock 
                            : 1'b0;

    assign flvds_slowclk = ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIX_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_syncclock
                                : stratix_pll_outclock[2]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_syncclock
                                : stratixii_pll_outclock[2]) :
                            ((FAMILY_HAS_FLEXIBLE_LVDS == 1) &&
                            (FAMILY_HAS_STRATIXIII_STYLE_PLL == 1))
                            ? ((use_external_pll == "ON")
                                ? tx_syncclock
                                : stratixiii_pll_outclock[2]) :
                            (MAXV_TX_STYLE == 1)
                            ? tx_syncclock 
                            : 1'b0;

    assign flvds_regclk = (FAMILY_HAS_FLEXIBLE_LVDS == 1)
                            ? tx_reg_clk
                            : 1'b0;

endmodule // altlvds_tx
// END OF MODULE

