vlog test_arch.sv

vsim -novopt top +UVM_VERBOSITY=UVM_LOW

add wave -position insertpoint sim:/top/intf/*
add wave -position insertpoint sim:/top/intf/drv_cb/*
add wave -position insertpoint sim:/top/intf/mon_cb/*

run -all
