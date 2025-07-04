////////////////////////////////////////////////////////////////////////////////
//                                            __ _      _     _               //
//                                           / _(_)    | |   | |              //
//                __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |              //
//               / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |              //
//              | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |              //
//               \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|              //
//                  | |                                                       //
//                  |_|                                                       //
//                                                                            //
//                                                                            //
//              MPSoC-MSP430 CPU                                              //
//              Multi Processor System on Chip                                //
//              BackBone Bus Interface                                       //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2019-2020 by the author(s)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//
////////////////////////////////////////////////////////////////////////////////
// Author(s):
//   Paco Reina Campo <pacoreinacampo@queenfield.tech>

import peripheral_dbg_soc_dii_channel::dii_flit;
import opensocdebug::peripheral_dbg_soc_mmsp430_trace_exec;
import soc_optimsoc_configuration::*;
import soc_optimsoc_functions::*;

module mpsoc4d_msp430_testbench;

  //////////////////////////////////////////////////////////////////////////////
  // Constants
  //////////////////////////////////////////////////////////////////////////////

  parameter USE_DEBUG = 0;
  parameter ENABLE_VCHANNELS = 1 * 1;

  parameter integer NUM_CORES = 1 * 1;  // bug in verilator would give a warning
  parameter integer LMEM_SIZE = 32 * 1024 * 1024;

  localparam base_config_t BASE_CONFIG = '{
    NUMTILES: 16,
    NUMCTS: 16,
    CTLIST: {{60{16'hx}}, 16'h0, 16'h1, 16'h2, 16'h3},
    CORES_PER_TILE: NUM_CORES,
    GMEM_SIZE: 0,
    GMEM_TILE: 'x,
    NOC_ENABLE_VCHANNELS: ENABLE_VCHANNELS,
    LMEM_SIZE: LMEM_SIZE,
    LMEM_STYLE: PLAIN,
    ENABLE_BOOTROM: 0,
    BOOTROM_SIZE: 0,
    ENABLE_DM: 1,
    DM_BASE: 32'h0,
    DM_SIZE: LMEM_SIZE,
    ENABLE_PGAS: 0,
    PGAS_BASE: 0,
    PGAS_SIZE: 0,
    CORE_ENABLE_FPU: 0,
    CORE_ENABLE_PERFCOUNTERS: 0,
    NA_ENABLE_MPSIMPLE: 1,
    NA_ENABLE_DMA: 1,
    NA_DMA_GENIRQ: 1,
    NA_DMA_ENTRIES: 4,
    USE_DEBUG: 1'(USE_DEBUG),
    DEBUG_STM: 1,
    DEBUG_CTM: 1,
    DEBUG_DEM_UART: 0,
    DEBUG_SUBNET_BITS: 6,
    DEBUG_LOCAL_SUBNET: 0,
    DEBUG_ROUTER_BUFFER_SIZE: 4,
    DEBUG_MAX_PKT_LEN: 12
  };

  localparam config_t CONFIG = derive_config(BASE_CONFIG);

  //////////////////////////////////////////////////////////////////////////////
  // Variables
  //////////////////////////////////////////////////////////////////////////////

  soc_glip_channel c_glip_in (.*);
  soc_glip_channel c_glip_out (.*);

  logic clk;
  logic rst;

  logic logic_rst;

  //////////////////////////////////////////////////////////////////////////////
  // Body
  //////////////////////////////////////////////////////////////////////////////

  mpsoc4d_msp430 #(
    .CONFIG(CONFIG)
  ) u_system (
    .clk       (clk),
    .rst       (rst | logic_rst),
    .c_glip_in (c_glip_in),
    .c_glip_out(c_glip_out),

    .bb_ext_addr_i(),
    .bb_ext_din_i (),
    .bb_ext_en_i  (),
    .bb_ext_we_i  (),

    .bb_ext_dout_o('x)
  );
endmodule
