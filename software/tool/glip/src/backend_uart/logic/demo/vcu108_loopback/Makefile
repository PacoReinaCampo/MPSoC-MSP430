all: vivado-project

vivado-project: vivado/vcu108_loopback.xpr

vivado/vcu108_loopback.xpr:
	vivado -mode batch -source vivado.tcl

clean: clean-vivado

clean-vivado:
	rm -rf vivado
	rm -f vivado_pid*
	rm -f vivado.jou vivado.log
	rm -f *.backup.jou
	rm -f *.backup.log
	rm -rf *.vcd .Xil
	rm -f ipc_tcp_xilinx_srv.log ipc_tcp_xilinx.log

