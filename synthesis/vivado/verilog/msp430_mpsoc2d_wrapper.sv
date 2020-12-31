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
//              MPSoC-RISCV CPU                                               //
//              Multi Processor System on Chip                                //
//              AMBA3 AHB-Lite Bus Interface                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2019-2020 by the author(s)
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * =============================================================================
 * Author(s):
 *   Paco Reina Campo <pacoreinacampo@queenfield.tech>
 */

import dii_package::dii_flit;
import opensocdebug::mmsp430_trace_exec;
import optimsoc_config::*;
import optimsoc_functions::*;

module msp430_mpsoc2d_wrapper #(
  parameter AW = 32,
  parameter DW = 32,

  parameter X = 2,
  parameter Y = 2,

  localparam NODES = X*Y
)
  (
    input clk,
    input rst
  );

  ////////////////////////////////////////////////////////////////
  //
  // Constans
  //

  parameter USE_DEBUG        = 0;
  parameter ENABLE_VCHANNELS = 1*1;

  parameter integer NUM_CORES = 1*1; // bug in verilator would give a warning
  parameter integer LMEM_SIZE = 32*1024*1024;

  localparam base_config_t
  BASE_CONFIG = '{NUMTILES: 4,
                  NUMCTS: 4,
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

  ////////////////////////////////////////////////////////////////
  //
  // Variables
  //

  genvar i;
  
  logic [NODES-1:0][AW-1:0] spram_addr_i;
  logic [NODES-1:0][DW-1:0] spram_din_i;
  logic [NODES-1:0]         spram_en_i;
  logic [NODES-1:0]         spram_we_i;

  logic [NODES-1:0][DW-1:0] spram_dout_o;

  glip_channel c_glip_in  (.*);
  glip_channel c_glip_out (.*);

  ////////////////////////////////////////////////////////////////
  //
  // Module Body
  //

  generate
    for (i=0; i<NODES; i=i+1) begin : gen_ct
      msp430_ram #(
        .MEM_SIZE ( 256 ),
        .AW       ( AW ),
        .DW       ( DW )
      )
      ram (
        .ram_clk ( clk ),

        .ram_addr ( spram_addr_i [i] ),
        .ram_din  ( spram_din_i  [i] ),
        .ram_cen  ( spram_en_i   [i] ),
        
        .ram_dout ( spram_dout_o [i] )
      );
    end
  endgenerate

  msp430_mpsoc2d #(
    .CONFIG (CONFIG)
  )
  mpsoc2d (
    .clk        (clk),
    .rst        (rst),

    .c_glip_in  (c_glip_in),
    .c_glip_out (c_glip_out),

    .bb_ext_addr_i ( spram_addr_i ),
    .bb_ext_din_i  ( spram_din_i  ),
    .bb_ext_en_i   ( spram_en_i   ),
    .bb_ext_we_i   ( spram_we_i   ),

    .bb_ext_dout_o ( spram_dout_o )
  );
endmodule
