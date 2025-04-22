# tb_top name
tc =  tb_top

glbl_src        = /opt/vivado/glbl.v
vivado_dir      = /opt/vivado/data/verilog/src
vivado_xpm_dir  = /opt/vivado/data/ip/xpm
vivado_lib      = -y$(vivado_dir) \
                  -y$(vivado_dir)/retarget \
                  -y$(vivado_dir)/unifast \
                  -y$(vivado_dir)/unimacro \
                  -y$(vivado_dir)/unisims \
                  -y$(vivado_dir)/xeclib \

verdi_opts = -P $(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab $(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a
i_source_file = $(shell cat ./filelist.f)

rtl_list = ../../design/rtl
commonip_list = ../../design/common_ip
include_list = ../../design/incl
tb_list	= ../../verify/tb

tb_files = $(tb_list)/$(tc).sv

all:  mklist compile elaborateR sim 

allv: mklist compile elaborate sim verdi

mklist:
				rm -rf ./filelist.f
				touch ./filelist.f
				echo "+incdir+${include_list}" > filelist.f
				find  $(rtl_list) -type f \( -name "*.v" -o -name "*.sv" \) >> filelist.f

compile:
				vlogan -assert svaext\
				+v2k \
				-full64 \
				-work xil_defaultlib \
				$(glbl_src) \
				+incdir+${include_list} \
				-sverilog \
				+define+SIMULATION_EN \
				$(tb_files) \
				-F ./filelist.f \
				-l com.log \

elaborate:
				vcs \
				-full64 \
				-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
				-Mdir=./vcs_lib/xil_defaultlib \
				-sverilog \
			    -debug_acc+all -debug_region+cell+encrypt \
				$(verdi_opts) \
				xil_defaultlib.${tc} xil_defaultlib.glbl\
				-o simv \
				2>&1 | tee -a vlogan.log

elaborateR:
				vcs \
				-full64 \
				-R \
				-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed \
				-Mdir=./vcs_lib/xil_defaultlib \
				-sverilog \
			    -debug_acc+all -debug_region+cell+encrypt \
				$(verdi_opts) \
				xil_defaultlib.${tc} xil_defaultlib.glbl\
				-o simv \
				2>&1 | tee -a vlogan.log


sim:
				./simv -ucli -licqueue -l simulate.log -do simulate.do

verdi:
				@echo "Are you sure you want to run make verdi? (y/n)"
				@read -p "Enter choice: " choice; \
				if [ "$$choice" != "y" ]; then \
					echo "Aborting..."; \
					exit 1; \
				fi
				@echo "Proceeding with make verdi..."
				verdi \
				-sv \
				+v2k \
				$(tb_files) \
				-F ./filelist.f \
				-ssf *.fsdb\
				-nologo &

clean:
				rm -rf  *.key *.vpd DVEfiles coverage *.vdb  novas* verdiLog vfastLog *.mr *.pvl *.syn *.svf ./filelist.f simv.daidir *.log *.fsdb  **.vcd *.vvp simv vcs_lib 64

mklisti:
				rm -rf ./filelist.f
				touch ./filelist.f
				find  $(rtl_list) -type f \( -name "*.v" -o -name "*.sv" \) >> filelist.f

compile_iverilog:
				iverilog -g2012 -I $(include_list) -o "$(tc).vvp" $(vivado_lib) $(glbl_src) $(tb_files) $(i_source_file)

sim_iverilog:
				vvp "$(tc).vvp"

gtk:
				gtkwave "$(tc).vcd"

verdi_iverilog:
				@echo "Are you sure you want to run make verdi? (y/n)"
				@read -p "Enter choice: " choice; \
				if [ "$$choice" != "y" ]; then \
					echo "Aborting..."; \
					exit 1; \
				fi
				@echo "Proceeding with make verdi..."
				verdi \
				-sv \
				+v2k \
				+incdir+${include_list} \
				$(tb_files) \
				-F ./filelist.f \
				-ssf *.vcd\
				-nologo &


alli: mklisti compile_iverilog sim_iverilog

alliv:mklisti compile_iverilog sim_iverilog verdi_iverilog

allig:mklisti compile_iverilog sim_iverilog gtk
