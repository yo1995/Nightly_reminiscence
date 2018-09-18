# 
# Synthesis run script generated by Vivado
# 

set_param gui.test TreeTableDev
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

create_project -in_memory -part xc7z010clg400-1
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Users/Administrator/Desktop/sellmach/sellmach.cache/wt [current_project]
set_property parent.project_path C:/Users/Administrator/Desktop/sellmach/sellmach.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib C:/Users/Administrator/Desktop/sellmach/sellmach.srcs/sources_1/imports/verilog/sell.v
read_xdc C:/Users/Administrator/Desktop/sellmach/sellmach.srcs/constrs_1/new/pinc.xdc
set_property used_in_implementation false [get_files C:/Users/Administrator/Desktop/sellmach/sellmach.srcs/constrs_1/new/pinc.xdc]

catch { write_hwdef -file sell.hwdef }
synth_design -top sell -part xc7z010clg400-1
write_checkpoint -noxdef sell.dcp
catch { report_utilization -file sell_utilization_synth.rpt -pb sell_utilization_synth.pb }