vlib work
vlog design2.v pipetest.v tb_M.v
vsim -voptargs=+acc work.tb_M
add wave -position insertpoint  \
sim:/tb_M/A \
sim:/tb_M/B \
sim:/tb_M/D \
sim:/tb_M/CLK \
sim:/tb_M/OPMODE \
sim:/tb_M/M \
sim:/tb_M/M_ref 
run -all
