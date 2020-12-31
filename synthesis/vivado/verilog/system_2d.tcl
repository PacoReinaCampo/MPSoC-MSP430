###################################################################################
##                                            __ _      _     _                  ##
##                                           / _(_)    | |   | |                 ##
##                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |                 ##
##               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |                 ##
##              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |                 ##
##               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|                 ##
##                  | |                                                          ##
##                  |_|                                                          ##
##                                                                               ##
##                                                                               ##
##              MPSoC-MSP430 CPU                                                 ##
##              Synthesis Test Makefile                                          ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2018-2019 by the author(s)                                      ##
##                                                                               ##
## Permission is hereby granted, free of charge, to any person obtaining a copy  ##
## of this software and associated documentation files (the "Software"), to deal ##
## in the Software without restriction, including without limitation the rights  ##
## to use, copy, modify, merge, publish, distribute, sublicense, and/or sell     ##
## copies of the Software, and to permit persons to whom the Software is         ##
## furnished to do so, subject to the following conditions:                      ##
##                                                                               ##
## The above copyright notice and this permission notice shall be included in    ##
## all copies or substantial portions of the Software.                           ##
##                                                                               ##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR    ##
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,      ##
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE   ##
## AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER        ##
## LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, ##
## OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN     ##
## THE SOFTWARE.                                                                 ##
##                                                                               ##
## ============================================================================= ##
## Author(s):                                                                    ##
##   Francisco Javier Reina Campo <frareicam@gmail.com>                          ##
##                                                                               ##
###################################################################################

read_verilog -sv ../../../rtl/verilog/pkg/arbiter/arb_rr.sv
read_verilog -sv ../../../rtl/verilog/pkg/functions/optimsoc_functions.sv
read_verilog -sv ../../../rtl/verilog/pkg/config/optimsoc_config.sv
read_verilog -sv ../../../rtl/verilog/pkg/constants/optimsoc_constants.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/msp430/mmsp430_trace_exec.sv
read_verilog -sv ../../../bench/verilog/glip/glip_channel.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/common/dii_channel_flat.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interfaces/common/dii_channel.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/debug_interface.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/buffer/dii_buffer.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/buffer/osd_fifo.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/ctm/common/osd_ctm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/ctm/msp430/mmsp430/osd_ctm_mmsp430.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/eventpacket/osd_event_packetization_fixedwidth.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/him/osd_him.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/blackbone/mam_bb_adapter.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/blackbone/osd_mam_bb_if.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/blackbone/osd_mam_bb.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/mam/common/osd_mam.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/eventpacket/osd_event_packetization.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess_layer.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/regaccess/osd_regaccess.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/tracesample/osd_tracesample.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/scm/osd_scm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/stm/common/osd_stm.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/stm/msp430/mmsp430/osd_stm_mmsp430.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/blocks/timestamp/osd_timestamp.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart_16550.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/modules/dem_uart/osd_dem_uart_bb.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/debug_ring_expand.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/debug_ring.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway_demux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway_mux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_gateway.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_mux_rr.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router_mux.sv
read_verilog -sv ../../../soc/dbg/rtl/verilog/soc/interconnect/ring_router.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/core/mpsoc_dma_initiator_nocreq.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/core/mpsoc_dma_packet_buffer.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/core/mpsoc_dma_request_table.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_initiator.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_initiator_nocres.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_initiator_req.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_interface.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_target.sv
read_verilog -sv ../../../soc/dma/rtl/verilog/bb/bb/mpsoc_dma_bb_top.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/bb/core/mpi_buffer.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/bb/core/mpi_buffer_endpoint.sv
read_verilog -sv ../../../soc/mpi/rtl/verilog/bb/bb/mpi_bb.sv
read_verilog -sv ../../../rtl/verilog/mpsoc/msp430_mpsoc2d.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_buffer.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_demux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_mux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/core/noc_vchannel_mux.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_input.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_lookup.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_lookup_slice.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/router/noc_router_output.sv
read_verilog -sv ../../../soc/noc/rtl/verilog/topology/noc_mesh2d.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_and_gate.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_clock_gate.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_clock_mux.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_scan_mux.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_sync_cell.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_sync_reset.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/fuse/msp430_wakeup_cell.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/omsp/msp430_alu.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/omsp/msp430_dbg_hwbrk.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/omsp/msp430_dbg_i2c.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/omsp/msp430_dbg_uart.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/omsp/msp430_register_file.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_bcm.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_dbg.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_execution.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_frontend.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_gpio.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_memory.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_multiplier.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_sfr.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_ta.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_watchdog.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_template08.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_template16.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/core/main/msp430_uart.sv
read_verilog -sv ../../../soc/pu/rtl/verilog/pu/msp430_core.sv
read_verilog -sv ../../../rtl/verilog/soc/adapter/networkadapter_conf.sv
read_verilog -sv ../../../rtl/verilog/soc/adapter/networkadapter_ct.sv
read_verilog -sv ../../../rtl/verilog/soc/bootrom/bootrom.sv
read_verilog -sv ../../../rtl/verilog/soc/interconnection/bus/bb_bus_b3.sv
read_verilog -sv ../../../rtl/verilog/soc/interconnection/decode/bb_decode.sv
read_verilog -sv ../../../rtl/verilog/soc/interconnection/mux/bb_mux.sv
read_verilog -sv ../../../rtl/verilog/soc/spram/sram_sp_impl_plain.sv
read_verilog -sv ../../../rtl/verilog/soc/spram/sram_sp.sv
read_verilog -sv ../../../rtl/verilog/soc/spram/bb_sram_sp.sv
read_verilog -sv ../../../rtl/verilog/soc/spram/bb2sram.sv
read_verilog -sv ../../../rtl/verilog/soc/msp430_tile.sv
read_verilog -sv ../../../soc/spram/rtl/verilog/bb/core/msp430_ram.sv

read_verilog -sv msp430_mpsoc2d_wrapper.sv

read_xdc system_2d.xdc

synth_design -part xc7z020-clg484-1 \
-include_dirs ../../../soc/pu/rtl/verilog/pkg \
-include_dirs ../../../rtl/verilog/soc/bootrom \
-include_dirs ../../../bench/cpp/verilator/inc \
-include_dirs ../../../bench/cpp/glip \
-include_dirs ../../../soc/dma/rtl/verilog/bb/pkg \
-top msp430_mpsoc2d_wrapper

opt_design
place_design
route_design

report_utilization
report_timing

write_verilog -force system_2d.v
write_bitstream -force system_2d.bit
