vlib work
vlog main.v pipeblock.v test_bcout.v
vsim -voptargs=+acc work.tb_DSP_bcout
add wave -position insertpoint  \
sim:/tb_DSP_bcout/B \
sim:/tb_DSP_bcout/D \
sim:/tb_DSP_bcout/CLK \
sim:/tb_DSP_bcout/OPMODE \
sim:/tb_DSP_bcout/BCOUT_000 \
sim:/tb_DSP_bcout/BCOUT_001 \
sim:/tb_DSP_bcout/BCOUT_010 \
sim:/tb_DSP_bcout/BCOUT_011 \
sim:/tb_DSP_bcout/BCOUT_100 \
sim:/tb_DSP_bcout/BCOUT_101 \
sim:/tb_DSP_bcout/BCOUT_110 \
sim:/tb_DSP_bcout/BCOUT_111 \
sim:/tb_DSP_bcout/test_flag
run -all
