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

module mpsoc2d_msp430_tile_testbench (
`ifdef verilator
  input clk,
  input rst
`endif
);

  //////////////////////////////////////////////////////////////////////////////
  // Constants
  //////////////////////////////////////////////////////////////////////////////

  parameter USE_DEBUG = 0;
  parameter ENABLE_VCHANNELS = 1 * 1;

  parameter integer NUM_CORES = 1 * 1;  // bug in verilator would give a warning
  parameter integer LMEM_SIZE = 32 * 1024 * 1024;

  localparam base_config_t BASE_CONFIG = '{
    NUMTILES: 4,
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

  //////////////////////////////////////////////////////////////////////////////
  // Variables
  //////////////////////////////////////////////////////////////////////////////

  logic rst_sys;
  logic rst_cpu;

  logic cpu_stall;

  // In Verilator, we feed clk and rst from the C++ toplevel, in ModelSim & Co.
  // these signals are generated inside this testbench.
`ifndef verilator
  reg clk;
  reg rst;
`endif

  soc_glip_channel c_glip_in (.*);
  soc_glip_channel c_glip_out (.*);

  logic                                           com_rst;
  logic                                           logic_rst;

  wire  [CONFIG.NUMCTS*CONFIG.CORES_PER_TILE-1:0] termination;

  // Monitor system behavior in simulation
  genvar t;
  genvar i;

  //////////////////////////////////////////////////////////////////////////////
  // Body
  //////////////////////////////////////////////////////////////////////////////

  assign cpu_stall = 0;

  // Reset signals
  // In simulations with debug system, these signals can be triggered through
  // the host software. In simulations without debug systems, we only rely on
  // the global reset signal.
  generate
    if (CONFIG.USE_DEBUG == 0) begin : gen_use_debug_rst
      assign rst_sys = rst;
      assign rst_cpu = rst;
    end
  endgenerate

  if (CONFIG.USE_DEBUG == 1) begin : gen_use_debug_glip
    // TCP communication interface (simulation only)
    soc_glip_tcp_top u_glip (
      .*,
      .clk_io   (clk),
      .clk_logic(clk),
      .fifo_in  (c_glip_in),
      .fifo_out (c_glip_out)
    );
  end

  generate
    for (t = 0; t < CONFIG.NUMCTS; t = t + 1) begin : gen_tracemon_ct

      logic                [31:0]                           trace_r3[0:CONFIG.CORES_PER_TILE-1];
      peripheral_dbg_soc_mmsp430_trace_exec [       CONFIG.CORES_PER_TILE-1:0] trace;
      assign trace = u_system.gen_ct[t].u_ct.trace;

      for (i = 0; i < CONFIG.CORES_PER_TILE; i = i + 1) begin : gen_tracemon_core
        soc_r3_checker u_r3_checker (
          .clk  (clk),
          .valid(trace[i].valid),
          .we   (trace[i].wben),
          .addr (trace[i].wbreg),
          .data (trace[i].wbdata),
          .r3   (trace_r3[i])
        );

        soc_trace_monitor #(
          .STDOUT_FILENAME   ({"stdout.", index2string((t * CONFIG.CORES_PER_TILE) + i)}),
          .TRACEFILE_FILENAME({"trace.", index2string((t * CONFIG.CORES_PER_TILE) + i)}),
          .ENABLE_TRACE      (0),
          .ID                ((t * CONFIG.CORES_PER_TILE) + i),
          .TERM_CROSS_NUM    (CONFIG.NUMCTS * CONFIG.CORES_PER_TILE)
        ) u_mon0 (
          .termination    (termination[(t*CONFIG.CORES_PER_TILE)+i]),
          .clk            (clk),
          .enable         (trace[i].valid),
          .wb_pc          (trace[i].pc),
          .wb_insn        (trace[i].insn),
          .r3             (trace_r3[i]),
          .termination_all(termination)
        );
      end
    end
  endgenerate

  mpsoc2d_msp430 #(
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

  // Generate testbench signals.
  // In Verilator, these signals are generated in the C++ toplevel testbench
`ifndef verilator
  initial begin
    clk = 1'b1;
    rst = 1'b1;
    #15;
    rst = 1'b0;
  end

  always clk = #1.25 ~clk;
`endif
endmodule
