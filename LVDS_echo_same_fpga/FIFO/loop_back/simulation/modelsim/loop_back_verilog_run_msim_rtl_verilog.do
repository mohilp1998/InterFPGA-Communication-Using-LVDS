transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/SizedFIFO.v}
vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/loop_back_verilog.v}
vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/tx.v}
vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/rx.v}
vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/db {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/db/tx_lvds_tx.v}
vlog -vlog01compat -work work +incdir+/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/db {/home/mohil/Desktop/Summer_Project/LVDS_Project/FIFO/loop_back/db/rx_lvds_rx.v}

