# Makefile for creating, building and testing Quartus and Nios II software projects for a given hardware platform
# Keep this file in your quartus project directory.

# IMP : TODO : set following path to Quartus installation directory.
QUARTUS16:=/opt/quartus/intelFPGA_lite/16.1

PROJECT_NAME:=LVDS_echo_FPGA12
PROJECT_NAME_CAPS:=LVDS_echo_FPGA12
SOFTWARE_PROJECT_NAME:=my_software
NIOS_CMD_SHELL_SCRIPT:=$(QUARTUS16)/nios2eds/nios2_command_shell.sh
VSIM_BIN_DIR__:=$(QUARTUS16)/modelsim_ase/linuxaloem
QSYS_SYSTEM_NAME__:=$(shell basename $(SOPCINFO) .sopcinfo)
QUARTUS_PROJECT_DIR__:=$(shell pwd)
QUARTUS_PROJECT:=$(PROJECT_NAME).qsf
SOF_FILE:=output_files/$(PROJECT_NAME).sof
JIC_FILE:=output_files/$(PROJECT_NAME).jic
SOPCINFO:=$(PROJECT_NAME).sopcinfo


network_files :
	tar -xvf ${tar_file} 
	
	cp -r vlog_sim_j23/ FPGA12_sim
	
	cp FPGA12_sim/mkNetworkSimple.v FPGA12_sim/mkNetworkSimple1.v
	mv FPGA12_sim/mkNetworkSimple.v FPGA12_sim/mkNetworkSimple2.v
		
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple1/g" FPGA12_sim/mkTop_fpga1.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple2/g" FPGA12_sim/mkTop_fpga2.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple1/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple2/g" FPGA12_sim/mkNetworkSimple2.v
		
	rm FPGA12_sim/*.hex
	rm FPGA12_sim/mkTb.v
	
	cp -r files/* FPGA12_sim/
	
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_0.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_10.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_1.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_11.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_2.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_12.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_3.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_13.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_0.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_20.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_1.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_21.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_2.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_22.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_3.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_23.hex/g" FPGA12_sim/mkNetworkSimple2.v
	
	cp -r FPGA12_sim/ FPGA1
	cp -r FPGA12_sim/ FPGA2

#top file for FPGA1 - FPGA1_TopNiosInterface.v 		(instantiates mkTop_fpga1.v)
#top file for FPGA2 - FPGA2_rst_TopInterface.v		(instantiates mkTop_fpga2.v)
#top file for FPGA12_sim - FPGA12_TopNiosInterface.v	(instantiates mkMFpgaTop.v)

replace_network_files :
	tar -xvf ${tar_file} 
	
	cp -r vlog_sim_j23/* FPGA12_sim/
	
	cp FPGA12_sim/mkNetworkSimple.v FPGA12_sim/mkNetworkSimple1.v
	mv FPGA12_sim/mkNetworkSimple.v FPGA12_sim/mkNetworkSimple2.v
		
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple1/g" FPGA12_sim/mkTop_fpga1.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple2/g" FPGA12_sim/mkTop_fpga2.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple1/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/mkNetworkSimple/mkNetworkSimple2/g" FPGA12_sim/mkNetworkSimple2.v
		
	rm FPGA12_sim/*.hex
	rm FPGA12_sim/mkTb.v
	
	cp -r files/* FPGA12_sim/
	
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_0.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_10.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_1.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_11.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_2.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_12.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_3.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_13.hex/g" FPGA12_sim/mkNetworkSimple1.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_0.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_20.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_1.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_21.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_2.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_22.hex/g" FPGA12_sim/mkNetworkSimple2.v
	perl -p -i -e "s/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_3.hex/customdb72c8b4c5f5588943c5ff029a85054c_8RTs_2VCs_8BD_25DW_SepIFRoundRobinAlloc_routing_23.hex/g" FPGA12_sim/mkNetworkSimple2.v
	
	cp -r FPGA12_sim/* FPGA1/
	cp -r FPGA12_sim/* FPGA2/

compile_quartus :
	quartus_map --read_settings_files=on --write_settings_files=off ${QUARTUS_PROJECT} -c ${QUARTUS_PROJECT}
	quartus_fit --read_settings_files=off --write_settings_files=off ${QUARTUS_PROJECT} -c ${QUARTUS_PROJECT}
	quartus_asm --read_settings_files=off --write_settings_files=off ${QUARTUS_PROJECT} -c ${QUARTUS_PROJECT}
	quartus_sta ${QUARTUS_PROJECT} -c ${QUARTUS_PROJECT}
	quartus_eda --read_settings_files=off --write_settings_files=off ${QUARTUS_PROJECT} -c ${QUARTUS_PROJECT}
	
convert_sof_jic_de0 :
	#quartus_cpf -c -d config_device_name -s serial_flash_loader_device_name input_SOF_FILE output_JIC_FILE
	quartus_cpf -c -d EPCS64 -s EP4CE22 ${SOF_FILE} ${JIC_FILE}

convert_sof_jic_de2 :
	#quartus_cpf -c -d config_device_name -s serial_flash_loader_device_name input_SOF_FILE output_JIC_FILE
	quartus_cpf -c -d EPCS64 -s EP4CE115 ${SOF_FILE} ${JIC_FILE}

program_sof :
	quartus_pgm -c "USB-Blaster [${cable_name}]" -m JTAG -o "p;${SOF_FILE}"

program_jic :
	quartus_pgm -c "USB-Blaster [${cable_name}]" -m JTAG -o "ip;${JIC_FILE}"

iverilog_sim :
	iverilog *.v -s ${tb} -o a.out && stdbuf -oL -eL vvp -n ./a.out

run_nios:
	cd software/$(SOFTWARE_PROJECT_NAME) && make download-elf DOWNLOAD_CABLE="USB-Blaster [${cable_name}]" && nios2-terminal --cable="USB-Blaster [${cable_name}]"

new-project-and-bsp: 
	#0. Create software app and bsp directories
	ls $(SOPCINFO)
	$(NIOS_CMD_SHELL_SCRIPT) nios2-swexample-create --sopc-file=$(SOPCINFO) --type=hello_world_small --elf-name=$(SOFTWARE_PROJECT_NAME).elf --app-dir=software/$(SOFTWARE_PROJECT_NAME) --bsp-dir=software/$(SOFTWARE_PROJECT_NAME)_bsp
	# 1. create contenets of bsp project
	cd software/$(SOFTWARE_PROJECT_NAME)_bsp && $(NIOS_CMD_SHELL_SCRIPT) ./create-this-bsp --cpu-name nios2_gen2_0 --no-make	
	# 2. create default application project
	cd software/$(SOFTWARE_PROJECT_NAME) && rm -f Makefile
	cd software/$(SOFTWARE_PROJECT_NAME) && $(NIOS_CMD_SHELL_SCRIPT) ./create-this-app --no-make
	cd software/$(SOFTWARE_PROJECT_NAME) && rm hello_world_small.c
	cp ../files/app.cpp software/$(SOFTWARE_PROJECT_NAME)/
	cd software/$(SOFTWARE_PROJECT_NAME) && perl -p -i -e "s/COMPONENT/$(PROJECT_NAME_CAPS)_COMPONENT/g" app.cpp
	cd software/$(SOFTWARE_PROJECT_NAME) && perl -p -i -e "s/hello_world_small.c//g" Makefile
	cd software/$(SOFTWARE_PROJECT_NAME) && perl -p -i -e "s/CXX_SRCS :=/CXX_SRCS := app.cpp/g" Makefile 

build: 
	#software/$(SOFTWARE_PROJECT_NAME)_bsp/Makefile
	# 1. build bsp project
	cd software/$(SOFTWARE_PROJECT_NAME)_bsp && $(NIOS_CMD_SHELL_SCRIPT) make
	# 2. build application project
	cd software/$(SOFTWARE_PROJECT_NAME) && $(NIOS_CMD_SHELL_SCRIPT) make

clean:	
	# 2. build application project
	cd software/$(SOFTWARE_PROJECT_NAME) && $(NIOS_CMD_SHELL_SCRIPT) make clean
	# 1. clean bsp project
	cd software/$(SOFTWARE_PROJECT_NAME)_bsp && $(NIOS_CMD_SHELL_SCRIPT) make clean

download-elf:
	cd software/$(SOFTWARE_PROJECT_NAME) && $(NIOS_CMD_SHELL_SCRIPT) make download-elf
	@echo "Starting nios2-terminal."
	@echo "Make sure to press ctrl+c, and exit from nios2-terminal. Else, quartus programmer will fail."
	cd software/$(SOFTWARE_PROJECT_NAME) && $(NIOS_CMD_SHELL_SCRIPT) nios2-terminal
	
