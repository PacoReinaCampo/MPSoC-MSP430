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
##              Architecture                                                     ##
##              QueenField                                                       ##
##                                                                               ##
###################################################################################

###################################################################################
##                                                                               ##
## Copyright (c) 2019-2020 by the author(s)                                      ##
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
##   Paco Reina Campo <pacoreinacampo@queenfield.tech>                           ##
##                                                                               ##
###################################################################################

+incdir+../../../../../../soc/rtl/verilog/soc/bootrom
+incdir+../../../../../../soc/bench/cpp/verilator/inc
+incdir+../../../../../../soc/bench/cpp/glip

+incdir+../../../../../../soc/pu/rtl/verilog/pkg

../../../../../../soc/peripheral/dma/rtl/verilog/code/pkg/core/peripheral_dma_pkg.sv

../../../../../../soc/rtl/verilog/pkg/arbiter/soc_arbiter_rr.sv
../../../../../../soc/rtl/verilog/pkg/functions/soc_optimsoc_functions.sv
../../../../../../soc/rtl/verilog/pkg/configuration/soc_optimsoc_configuration.sv
../../../../../../soc/rtl/verilog/pkg/constants/soc_optimsoc_constants.sv

../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel_flat.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/common/peripheral_dbg_soc_dii_channel.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interfaces/msp430/peripheral_dbg_soc_mmsp430_trace_exec.sv

../../../../../../soc/bench/verilog/glip/soc_glip_channel.sv

../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_dii_buffer.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/buffer/peripheral_dbg_soc_osd_fifo.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization_fixedwidth.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/eventpacket/peripheral_dbg_soc_osd_event_packetization.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_demux.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess_layer.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/regaccess/peripheral_dbg_soc_osd_regaccess.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/timestamp/peripheral_dbg_soc_osd_timestamp.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/blocks/tracesample/peripheral_dbg_soc_osd_tracesample.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring_expand.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_debug_ring.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_demux.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_demux.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway_mux.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_gateway.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux_rr.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router_mux.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/interconnect/peripheral_dbg_soc_ring_router.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/common/peripheral_dbg_soc_osd_ctm.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/ctm/msp430/peripheral_dbg_soc_osd_ctm_mmsp430.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_16550.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/dem_uart/peripheral_dbg_soc_osd_dem_uart_bb.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/him/peripheral_dbg_soc_osd_him.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/common/peripheral_dbg_soc_osd_mam.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/blackbone/peripheral_dbg_soc_mam_adapter_bb.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/blackbone/peripheral_dbg_soc_osd_mam_if_bb.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/mam/blackbone/peripheral_dbg_soc_osd_mam_bb.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/scm/peripheral_dbg_soc_osd_scm.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/stm/common/peripheral_dbg_soc_osd_stm.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/modules/stm/msp430/mmsp430/peripheral_dbg_soc_osd_stm_mmsp430.sv
../../../../../../soc/peripheral/dbg/rtl/soc/verilog/code/peripheral/top/peripheral_dbg_soc_interface.sv

../../../../../../soc/peripheral/dma/rtl/verilog/code/core/peripheral_dma_initiator_nocreq.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/core/peripheral_dma_packet_buffer.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/core/peripheral_dma_request_table.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_nocres_bb.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_req_bb.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_initiator_bb.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_interface_bb.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_target_bb.sv
../../../../../../soc/peripheral/dma/rtl/verilog/code/peripheral/bb/peripheral_dma_top_bb.sv

../../../../../../soc/peripheral/mpi/rtl/verilog/code/core/peripheral_mpi_buffer.sv
../../../../../../soc/peripheral/mpi/rtl/verilog/code/core/peripheral_mpi_buffer_endpoint.sv
../../../../../../soc/peripheral/mpi/rtl/verilog/code/peripheral/bb/peripheral_mpi_bb.sv

../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/main/peripheral_arbiter_rr.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/main/peripheral_noc_buffer.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/main/peripheral_noc_demux.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/main/peripheral_noc_mux.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/main/peripheral_noc_vchannel_mux.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_input.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_lookup_slice.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_lookup.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router_output.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/router/peripheral_noc_router.sv
../../../../../../soc/peripheral/noc/rtl/verilog/code/peripheral/topology/peripheral_noc_mesh4d.sv

../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_and_gate.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_clock_gate.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_clock_mux.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_scan_mux.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_sync_cell.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_sync_reset.sv
../../../../../../soc/pu/rtl/verilog/core/fuse/pu_msp430_wakeup_cell.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_bcm.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_dac.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_dbg.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_execution.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_frontend.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_gpio.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_memory.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_multiplier.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_sfr.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_ta.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_template08.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_template16.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_uart.sv
../../../../../../soc/pu/rtl/verilog/core/main/pu_msp430_watchdog.sv
../../../../../../soc/pu/rtl/verilog/core/omsp/pu_msp430_alu.sv
../../../../../../soc/pu/rtl/verilog/core/omsp/pu_msp430_dbg_hwbrk.sv
../../../../../../soc/pu/rtl/verilog/core/omsp/pu_msp430_dbg_i2c.sv
../../../../../../soc/pu/rtl/verilog/core/omsp/pu_msp430_dbg_uart.sv
../../../../../../soc/pu/rtl/verilog/core/omsp/pu_msp430_register_file.sv
../../../../../../soc/pu/rtl/verilog/pu/pu_msp430_core.sv
../../../../../../soc/pu/rtl/verilog/pu/pu_msp430_pu0.sv
../../../../../../soc/pu/rtl/verilog/pu/pu_msp430_pu1.sv
../../../../../../soc/pu/rtl/verilog/soc/pu_msp430_io_cell.sv
../../../../../../soc/pu/rtl/verilog/soc/pu_msp430_soc.sv

../../../../../../soc/rtl/verilog/soc/adapter/soc_network_adapter_configuration.sv
../../../../../../soc/rtl/verilog/soc/adapter/soc_network_adapter_ct.sv
../../../../../../soc/rtl/verilog/soc/bootrom/soc_bootrom.sv
../../../../../../soc/rtl/verilog/soc/interconnection/bus/soc_b3_bb.sv
../../../../../../soc/rtl/verilog/soc/interconnection/decode/soc_decode_bb.sv
../../../../../../soc/rtl/verilog/soc/interconnection/mux/soc_mux_bb.sv
../../../../../../soc/rtl/verilog/soc/main/soc_msp430_tile.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp_impl_plain.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_sram_sp_bb.sv
../../../../../../soc/rtl/verilog/soc/spram/soc_bb2sram.sv

../../../../../../rtl/verilog/mpsoc/mpsoc4d_msp430.sv

../../../../../../bench/verilog/main/mpsoc4d_msp430_testbench.sv
