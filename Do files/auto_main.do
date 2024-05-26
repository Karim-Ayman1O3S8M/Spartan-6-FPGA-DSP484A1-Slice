vlib work
vlog main.v pipeblock.v main_tb.v
vsim -voptargs=+acc work.tb_DSP_org
add wave *
run -all
