vlib work
vlog main.v pipeblock.v test_self_bcout.v
vsim -voptargs=+acc work.tb_DSP_bcout_self
add wave -position insertpoint  \
sim:/tb_DSP_bcout_self/CLK \
sim:/tb_DSP_bcout_self/D \
sim:/tb_DSP_bcout_self/B \
sim:/tb_DSP_bcout_self/OPMODE \
sim:/tb_DSP_bcout_self/test_flag \
sim:/tb_DSP_bcout_self/BCOUT_000 \
sim:/tb_DSP_bcout_self/BCOUT_001 \
sim:/tb_DSP_bcout_self/BCOUT_010 \
sim:/tb_DSP_bcout_self/BCOUT_011 \
sim:/tb_DSP_bcout_self/BCOUT_100 \
sim:/tb_DSP_bcout_self/BCOUT_101 \
sim:/tb_DSP_bcout_self/BCOUT_110 \
sim:/tb_DSP_bcout_self/BCOUT_111 \
sim:/tb_DSP_bcout_self/expected \
sim:/tb_DSP_bcout_self/success \
sim:/tb_DSP_bcout_self/failed \
run -all


