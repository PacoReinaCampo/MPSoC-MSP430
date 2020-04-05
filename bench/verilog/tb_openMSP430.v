//----------------------------------------------------------------------------
// Copyright (C) 2001 Authors
//
// This source file may be used and distributed without restriction provided
// that this copyright statement is not removed from the file and that any
// derivative work contains the original copyright notice and the associated
// disclaimer.
//
// This source file is free software; you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published
// by the Free Software Foundation; either version 2.1 of the License, or
// (at your option) any later version.
//
// This source is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public
// License for more details.
//
// You should have received a copy of the GNU Lesser General Public License
// along with this source; if not, write to the Free Software Foundation,
// Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
//
//----------------------------------------------------------------------------
// 
// *File Name: tb_openMSP430.v
// 
// *Module Description:
//                      openMSP430 FPGA testbench
//
// *Author(s):
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
// $Rev: 111 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2011-05-20 22:39:02 +0200 (Fri, 20 May 2011) $
//----------------------------------------------------------------------------
`include "timescale.v"
`ifdef OMSP_NO_INCLUDE
`else
`include "openMSP430_defines.v"
`endif

module tb_openMSP430;

  //
  // Wire & Register definition
  //------------------------------

  // Clock & Reset
  reg               CLK_40MHz;
  reg               USER_RESET;

  // Slide Switches
  reg               SW4;
  reg               SW3;
  reg               SW2;
  reg               SW1;

  // LEDs
  wire              LED04;
  wire              LED03;
  wire              LED02;
  wire              LED01;

  wire              LED14;
  wire              LED13;
  wire              LED12;
  wire              LED11;

  // UART
  reg               UART_RXD1;
  wire              UART_TXD1;

  reg               UART_RXD0;
  wire              UART_TXD0;

  // I2C
  wire 	            PMOD1_P3;
  reg               PMOD1_P4;

  // Core debug signals
  wire   [8*32-1:0] omsp00_i_state;
  wire   [8*32-1:0] omsp00_e_state;
  wire   [    31:0] omsp00_inst_cycle;
  wire   [8*32-1:0] omsp00_inst_full;
  wire   [    31:0] omsp00_inst_number;
  wire   [    15:0] omsp00_inst_pc;
  wire   [8*32-1:0] omsp00_inst_short;

  wire   [8*32-1:0] omsp01_i_state;
  wire   [8*32-1:0] omsp01_e_state;
  wire   [    31:0] omsp01_inst_cycle;
  wire   [8*32-1:0] omsp01_inst_full;
  wire   [    31:0] omsp01_inst_number;
  wire   [    15:0] omsp01_inst_pc;
  wire   [8*32-1:0] omsp01_inst_short;

  wire   [8*32-1:0] omsp10_i_state;
  wire   [8*32-1:0] omsp10_e_state;
  wire   [    31:0] omsp10_inst_cycle;
  wire   [8*32-1:0] omsp10_inst_full;
  wire   [    31:0] omsp10_inst_number;
  wire   [    15:0] omsp10_inst_pc;
  wire   [8*32-1:0] omsp10_inst_short;

  wire   [8*32-1:0] omsp11_i_state;
  wire   [8*32-1:0] omsp11_e_state;
  wire   [    31:0] omsp11_inst_cycle;
  wire   [8*32-1:0] omsp11_inst_full;
  wire   [    31:0] omsp11_inst_number;
  wire   [    15:0] omsp11_inst_pc;
  wire   [8*32-1:0] omsp11_inst_short;

  // Testbench variables
  integer           i;
  integer           error;
  reg               stimulus_done;


  // SoC 0

  // CORE 0
  // CPU registers
  wire       [15:0] omsp00_r0;
  wire       [15:0] omsp00_r1;
  wire       [15:0] omsp00_r2;
  wire       [15:0] omsp00_r3;
  wire       [15:0] omsp00_r4;
  wire       [15:0] omsp00_r5;
  wire       [15:0] omsp00_r6;
  wire       [15:0] omsp00_r7;
  wire       [15:0] omsp00_r8;
  wire       [15:0] omsp00_r9;
  wire       [15:0] omsp00_r10;
  wire       [15:0] omsp00_r11;
  wire       [15:0] omsp00_r12;
  wire       [15:0] omsp00_r13;
  wire       [15:0] omsp00_r14;
  wire       [15:0] omsp00_r15;

  // Debug interface
  wire              omsp00_dbg_en;
  wire              omsp00_dbg_clk;
  wire              omsp00_dbg_rst;

  // Interrupt detection
  wire              omsp00_irq_detect;
  wire              omsp00_nmi_detect;

  wire        [2:0] omsp00_i_state_bin;
  wire        [3:0] omsp00_e_state_bin;
  wire              omsp00_decode;
  wire       [15:0] omsp00_ir;
  wire       [ 5:0] omsp00_irq_num;
  wire       [15:0] omsp00_pc;

  // CPU internals
  wire              omsp00_mclk;
  wire              omsp00_puc_rst;


  // CORE 1
  // CPU registers
  wire       [15:0] omsp01_r0;
  wire       [15:0] omsp01_r1;
  wire       [15:0] omsp01_r2;
  wire       [15:0] omsp01_r3;
  wire       [15:0] omsp01_r4;
  wire       [15:0] omsp01_r5;
  wire       [15:0] omsp01_r6;
  wire       [15:0] omsp01_r7;
  wire       [15:0] omsp01_r8;
  wire       [15:0] omsp01_r9;
  wire       [15:0] omsp01_r10;
  wire       [15:0] omsp01_r11;
  wire       [15:0] omsp01_r12;
  wire       [15:0] omsp01_r13;
  wire       [15:0] omsp01_r14;
  wire       [15:0] omsp01_r15;

  // Debug interface
  wire              omsp01_dbg_en;
  wire              omsp01_dbg_clk;
  wire              omsp01_dbg_rst;


  // Interrupt detection
  wire              omsp01_irq_detect;
  wire              omsp01_nmi_detect;

  wire        [2:0] omsp01_i_state_bin;
  wire        [3:0] omsp01_e_state_bin;
  wire              omsp01_decode;
  wire       [15:0] omsp01_ir;
  wire       [ 5:0] omsp01_irq_num;
  wire       [15:0] omsp01_pc;

  // CPU internals
  wire              omsp01_mclk;
  wire              omsp01_puc_rst;


  // Data memory
  wire [`DMEM_MSB:0] omsp00_dmem_addr;
  wire               omsp00_dmem_cen_sp;
  wire               omsp00_dmem_cen_dp;
  wire        [15:0] omsp00_dmem_din;
  wire        [ 1:0] omsp00_dmem_wen;
  wire        [15:0] omsp00_dmem_dout_sp;
  wire        [15:0] omsp00_dmem_dout_dp;

  wire [`DMEM_MSB:0] omsp01_dmem_addr;
  wire               omsp01_dmem_cen_sp;
  wire               omsp01_dmem_cen_dp;
  wire        [15:0] omsp01_dmem_din;
  wire        [ 1:0] omsp01_dmem_wen;
  wire        [15:0] omsp01_dmem_dout_sp;
  wire        [15:0] omsp01_dmem_dout_dp;

  // Program memory
  wire [`PMEM_MSB:0] omsp00_pmem_addr;
  wire               omsp00_pmem_cen;
  wire        [15:0] omsp00_pmem_din;
  wire        [ 1:0] omsp00_pmem_wen;
  wire        [15:0] omsp00_pmem_dout;

  wire [`PMEM_MSB:0] omsp01_pmem_addr;
  wire               omsp01_pmem_cen;
  wire        [15:0] omsp01_pmem_din;
  wire        [ 1:0] omsp01_pmem_wen;
  wire        [15:0] omsp01_pmem_dout;

  wire               dco_clk0;


  // SoC 1

  // CORE 0
  // CPU registers
  wire       [15:0] omsp10_r0;
  wire       [15:0] omsp10_r1;
  wire       [15:0] omsp10_r2;
  wire       [15:0] omsp10_r3;
  wire       [15:0] omsp10_r4;
  wire       [15:0] omsp10_r5;
  wire       [15:0] omsp10_r6;
  wire       [15:0] omsp10_r7;
  wire       [15:0] omsp10_r8;
  wire       [15:0] omsp10_r9;
  wire       [15:0] omsp10_r10;
  wire       [15:0] omsp10_r11;
  wire       [15:0] omsp10_r12;
  wire       [15:0] omsp10_r13;
  wire       [15:0] omsp10_r14;
  wire       [15:0] omsp10_r15;

  // Debug interface
  wire              omsp10_dbg_en;
  wire              omsp10_dbg_clk;
  wire              omsp10_dbg_rst;

  // Interrupt detection
  wire              omsp10_irq_detect;
  wire              omsp10_nmi_detect;

  wire        [2:0] omsp10_i_state_bin;
  wire        [3:0] omsp10_e_state_bin;
  wire              omsp10_decode;
  wire       [15:0] omsp10_ir;
  wire       [ 5:0] omsp10_irq_num;
  wire       [15:0] omsp10_pc;

  // CPU internals
  wire              omsp10_mclk;
  wire              omsp10_puc_rst;


  // CORE 1
  // CPU registers
  wire       [15:0] omsp11_r0;
  wire       [15:0] omsp11_r1;
  wire       [15:0] omsp11_r2;
  wire       [15:0] omsp11_r3;
  wire       [15:0] omsp11_r4;
  wire       [15:0] omsp11_r5;
  wire       [15:0] omsp11_r6;
  wire       [15:0] omsp11_r7;
  wire       [15:0] omsp11_r8;
  wire       [15:0] omsp11_r9;
  wire       [15:0] omsp11_r10;
  wire       [15:0] omsp11_r11;
  wire       [15:0] omsp11_r12;
  wire       [15:0] omsp11_r13;
  wire       [15:0] omsp11_r14;
  wire       [15:0] omsp11_r15;

  // Debug interface
  wire              omsp11_dbg_en;
  wire              omsp11_dbg_clk;
  wire              omsp11_dbg_rst;


  // Interrupt detection
  wire              omsp11_irq_detect;
  wire              omsp11_nmi_detect;

  wire        [2:0] omsp11_i_state_bin;
  wire        [3:0] omsp11_e_state_bin;
  wire              omsp11_decode;
  wire       [15:0] omsp11_ir;
  wire       [ 5:0] omsp11_irq_num;
  wire       [15:0] omsp11_pc;

  // CPU internals
  wire              omsp11_mclk;
  wire              omsp11_puc_rst;


  // Data memory
  wire [`DMEM_MSB:0] omsp10_dmem_addr;
  wire               omsp10_dmem_cen_sp;
  wire               omsp10_dmem_cen_dp;
  wire        [15:0] omsp10_dmem_din;
  wire        [ 1:0] omsp10_dmem_wen;
  wire        [15:0] omsp10_dmem_dout_sp;
  wire        [15:0] omsp10_dmem_dout_dp;

  wire [`DMEM_MSB:0] omsp11_dmem_addr;
  wire               omsp11_dmem_cen_sp;
  wire               omsp11_dmem_cen_dp;
  wire        [15:0] omsp11_dmem_din;
  wire        [ 1:0] omsp11_dmem_wen;
  wire        [15:0] omsp11_dmem_dout_sp;
  wire        [15:0] omsp11_dmem_dout_dp;

  // Program memory
  wire [`PMEM_MSB:0] omsp10_pmem_addr;
  wire               omsp10_pmem_cen;
  wire        [15:0] omsp10_pmem_din;
  wire        [ 1:0] omsp10_pmem_wen;
  wire        [15:0] omsp10_pmem_dout;

  wire [`PMEM_MSB:0] omsp11_pmem_addr;
  wire               omsp11_pmem_cen;
  wire        [15:0] omsp11_pmem_din;
  wire        [ 1:0] omsp11_pmem_wen;
  wire        [15:0] omsp11_pmem_dout;

  wire               dco_clk1;


  //
  // Include files
  //------------------------------

  // CPU & Memory registers
  reg [15:0] pmem0 [0:8191];
  reg [15:0] pmem1 [0:8191];

  // Verilog stimulus
  `include "stimulus.v"

  //
  // Initialize Program Memory
  //------------------------------

  initial begin
    // Read memory file
    #10 $readmemh("./pmem.mem", pmem0);
    #10 $readmemh("./pmem.mem", pmem1);

    // Update Xilinx memory banks
    for (i=0; i<8192; i=i+1) begin
      RAM_P2_shared0.RAM_DP_inst.mem[i] = pmem0[i];
      RAM_P2_shared1.RAM_DP_inst.mem[i] = pmem1[i];
    end
  end

  //
  // Generate Clock & Reset
  //------------------------------
  initial begin
    CLK_40MHz = 1'b0;
    forever #12.5 CLK_40MHz <= ~CLK_40MHz; // 40 MHz
  end

  initial begin
    USER_RESET         = 1'b0;
    #100 USER_RESET    = 1'b1;
    #600 USER_RESET    = 1'b0;
  end

  //
  // Global initialization
  //------------------------------
  initial begin
    error         = 0;
    stimulus_done = 1;
    SW4           = 1'b0;  // Slide Switches
    SW3           = 1'b0;
    SW2           = 1'b0;
    SW1           = 1'b0;
    UART_RXD1     = 1'b1;  // UART
    UART_RXD0     = 1'b1;  // UART
    PMOD1_P4      = 1'b1;
  end

  //
  // openMSP430 FPGA Instance
  //----------------------------------

  MSP430_MPSoC DUT (

    //SoC 0

    // CORE 0
    // CPU registers
    .omsp00_r0         (omsp00_r0),
    .omsp00_r1         (omsp00_r1),
    .omsp00_r2         (omsp00_r2),
    .omsp00_r3         (omsp00_r3),
    .omsp00_r4         (omsp00_r4),
    .omsp00_r5         (omsp00_r5),
    .omsp00_r6         (omsp00_r6),
    .omsp00_r7         (omsp00_r7),
    .omsp00_r8         (omsp00_r8),
    .omsp00_r9         (omsp00_r9),
    .omsp00_r10        (omsp00_r10),
    .omsp00_r11        (omsp00_r11),
    .omsp00_r12        (omsp00_r12),
    .omsp00_r13        (omsp00_r13),
    .omsp00_r14        (omsp00_r14),
    .omsp00_r15        (omsp00_r15),

    // Debug interface
    .omsp00_dbg_en     (omsp00_dbg_en),
    .omsp00_dbg_clk    (omsp00_dbg_clk),
    .omsp00_dbg_rst    (omsp00_dbg_rst),

    // Interrupt detection
    .omsp00_irq_detect (omsp00_irq_detect),
    .omsp00_nmi_pnd    (omsp00_nmi_detect),

    .omsp00_i_state    (omsp00_i_state_bin),
    .omsp00_e_state    (omsp00_e_state_bin),
    .omsp00_decode     (omsp00_decode),
    .omsp00_ir         (omsp00_ir),
    .omsp00_irq_num    (omsp00_irq_num),
    .omsp00_pc         (omsp00_pc),

    // CPU internals
    .omsp00_mclk       (omsp00_mclk),
    .omsp00_puc_rst    (omsp00_puc_rst),

    // CORE 1
    // CPU registers
    .omsp01_r0         (omsp01_r0),
    .omsp01_r1         (omsp01_r1),
    .omsp01_r2         (omsp01_r2),
    .omsp01_r3         (omsp01_r3),
    .omsp01_r4         (omsp01_r4),
    .omsp01_r5         (omsp01_r5),
    .omsp01_r6         (omsp01_r6),
    .omsp01_r7         (omsp01_r7),
    .omsp01_r8         (omsp01_r8),
    .omsp01_r9         (omsp01_r9),
    .omsp01_r10        (omsp01_r10),
    .omsp01_r11        (omsp01_r11),
    .omsp01_r12        (omsp01_r12),
    .omsp01_r13        (omsp01_r13),
    .omsp01_r14        (omsp01_r14),
    .omsp01_r15        (omsp01_r15),

    // Debug interface
    .omsp01_dbg_en     (omsp01_dbg_en),
    .omsp01_dbg_clk    (omsp01_dbg_clk),
    .omsp01_dbg_rst    (omsp01_dbg_rst),

    // Interrupt detection
    .omsp01_irq_detect (omsp01_irq_detect),
    .omsp01_nmi_pnd    (omsp01_nmi_detect),

    .omsp01_i_state    (omsp01_i_state_bin),
    .omsp01_e_state    (omsp01_e_state_bin),
    .omsp01_decode     (omsp01_decode),
    .omsp01_ir         (omsp01_ir),
    .omsp01_irq_num    (omsp01_irq_num),
    .omsp01_pc         (omsp01_pc),

    // CPU internals
    .omsp01_mclk       (omsp01_mclk),
    .omsp01_puc_rst    (omsp01_puc_rst),

    // Data memory
    .omsp00_dmem_addr    (omsp00_dmem_addr),
    .omsp00_dmem_cen_sp  (omsp00_dmem_cen_sp),
    .omsp00_dmem_cen_dp  (omsp00_dmem_cen_dp),
    .omsp00_dmem_din     (omsp00_dmem_din),
    .omsp00_dmem_wen     (omsp00_dmem_wen),
    .omsp00_dmem_dout_sp (omsp00_dmem_dout_sp),
    .omsp00_dmem_dout_dp (omsp00_dmem_dout_dp),

    .omsp01_dmem_addr    (omsp01_dmem_addr),
    .omsp01_dmem_cen_sp  (omsp01_dmem_cen_sp),
    .omsp01_dmem_cen_dp  (omsp01_dmem_cen_dp),
    .omsp01_dmem_din     (omsp01_dmem_din),
    .omsp01_dmem_wen     (omsp01_dmem_wen),
    .omsp01_dmem_dout_sp (omsp01_dmem_dout_sp),
    .omsp01_dmem_dout_dp (omsp01_dmem_dout_dp),

    // Program memory
    .omsp00_pmem_addr  (omsp00_pmem_addr),
    .omsp00_pmem_cen   (omsp00_pmem_cen),
    .omsp00_pmem_din   (omsp00_pmem_din),
    .omsp00_pmem_wen   (omsp00_pmem_wen),
    .omsp00_pmem_dout  (omsp00_pmem_dout),

    .omsp01_pmem_addr  (omsp01_pmem_addr),
    .omsp01_pmem_cen   (omsp01_pmem_cen),
    .omsp01_pmem_din   (omsp01_pmem_din),
    .omsp01_pmem_wen   (omsp01_pmem_wen),
    .omsp01_pmem_dout  (omsp01_pmem_dout),

    .dco_clk0          (dco_clk0),

    //----------------------------------------------
    // User LEDs			
    //----------------------------------------------
    .GPIO_LED01       (LED01),
    .GPIO_LED02       (LED02),
    .GPIO_LED03       (LED03),
    .GPIO_LED04       (LED04),

    //----------------------------------------------
    // Silicon Labs CP2102 USB-to-UART Bridge Chip
    //----------------------------------------------
    .USB_RS232_RXD0   (UART_RXD0),
    .USB_RS232_TXD0   (UART_TXD0),

    //SoC 1

    // CORE 0
    // CPU registers
    .omsp10_r0         (omsp10_r0),
    .omsp10_r1         (omsp10_r1),
    .omsp10_r2         (omsp10_r2),
    .omsp10_r3         (omsp10_r3),
    .omsp10_r4         (omsp10_r4),
    .omsp10_r5         (omsp10_r5),
    .omsp10_r6         (omsp10_r6),
    .omsp10_r7         (omsp10_r7),
    .omsp10_r8         (omsp10_r8),
    .omsp10_r9         (omsp10_r9),
    .omsp10_r10        (omsp10_r10),
    .omsp10_r11        (omsp10_r11),
    .omsp10_r12        (omsp10_r12),
    .omsp10_r13        (omsp10_r13),
    .omsp10_r14        (omsp10_r14),
    .omsp10_r15        (omsp10_r15),

    // Debug interface
    .omsp10_dbg_en     (omsp10_dbg_en),
    .omsp10_dbg_clk    (omsp10_dbg_clk),
    .omsp10_dbg_rst    (omsp10_dbg_rst),

    // Interrupt detection
    .omsp10_irq_detect (omsp10_irq_detect),
    .omsp10_nmi_pnd    (omsp10_nmi_detect),

    .omsp10_i_state    (omsp10_i_state_bin),
    .omsp10_e_state    (omsp10_e_state_bin),
    .omsp10_decode     (omsp10_decode),
    .omsp10_ir         (omsp10_ir),
    .omsp10_irq_num    (omsp10_irq_num),
    .omsp10_pc         (omsp10_pc),

    // CPU internals
    .omsp10_mclk       (omsp10_mclk),
    .omsp10_puc_rst    (omsp10_puc_rst),

    // CORE 1
    // CPU registers
    .omsp11_r0         (omsp11_r0),
    .omsp11_r1         (omsp11_r1),
    .omsp11_r2         (omsp11_r2),
    .omsp11_r3         (omsp11_r3),
    .omsp11_r4         (omsp11_r4),
    .omsp11_r5         (omsp11_r5),
    .omsp11_r6         (omsp11_r6),
    .omsp11_r7         (omsp11_r7),
    .omsp11_r8         (omsp11_r8),
    .omsp11_r9         (omsp11_r9),
    .omsp11_r10        (omsp11_r10),
    .omsp11_r11        (omsp11_r11),
    .omsp11_r12        (omsp11_r12),
    .omsp11_r13        (omsp11_r13),
    .omsp11_r14        (omsp11_r14),
    .omsp11_r15        (omsp11_r15),

    // Debug interface
    .omsp11_dbg_en     (omsp11_dbg_en),
    .omsp11_dbg_clk    (omsp11_dbg_clk),
    .omsp11_dbg_rst    (omsp11_dbg_rst),

    // Interrupt detection
    .omsp11_irq_detect (omsp11_irq_detect),
    .omsp11_nmi_pnd    (omsp11_nmi_detect),

    .omsp11_i_state    (omsp11_i_state_bin),
    .omsp11_e_state    (omsp11_e_state_bin),
    .omsp11_decode     (omsp11_decode),
    .omsp11_ir         (omsp11_ir),
    .omsp11_irq_num    (omsp11_irq_num),
    .omsp11_pc         (omsp11_pc),

    // CPU internals
    .omsp11_mclk       (omsp11_mclk),
    .omsp11_puc_rst    (omsp11_puc_rst),

    // Data memory
    .omsp10_dmem_addr    (omsp10_dmem_addr),
    .omsp10_dmem_cen_sp  (omsp10_dmem_cen_sp),
    .omsp10_dmem_cen_dp  (omsp10_dmem_cen_dp),
    .omsp10_dmem_din     (omsp10_dmem_din),
    .omsp10_dmem_wen     (omsp10_dmem_wen),
    .omsp10_dmem_dout_sp (omsp10_dmem_dout_sp),
    .omsp10_dmem_dout_dp (omsp10_dmem_dout_dp),

    .omsp11_dmem_addr    (omsp11_dmem_addr),
    .omsp11_dmem_cen_sp  (omsp11_dmem_cen_sp),
    .omsp11_dmem_cen_dp  (omsp11_dmem_cen_dp),
    .omsp11_dmem_din     (omsp11_dmem_din),
    .omsp11_dmem_wen     (omsp11_dmem_wen),
    .omsp11_dmem_dout_sp (omsp11_dmem_dout_sp),
    .omsp11_dmem_dout_dp (omsp11_dmem_dout_dp),

    // Program memory
    .omsp10_pmem_addr  (omsp10_pmem_addr),
    .omsp10_pmem_cen   (omsp10_pmem_cen),
    .omsp10_pmem_din   (omsp10_pmem_din),
    .omsp10_pmem_wen   (omsp10_pmem_wen),
    .omsp10_pmem_dout  (omsp10_pmem_dout),

    .omsp11_pmem_addr  (omsp11_pmem_addr),
    .omsp11_pmem_cen   (omsp11_pmem_cen),
    .omsp11_pmem_din   (omsp11_pmem_din),
    .omsp11_pmem_wen   (omsp11_pmem_wen),
    .omsp11_pmem_dout  (omsp11_pmem_dout),

    .dco_clk1          (dco_clk1),

    //----------------------------------------------
    // User LEDs			
    //----------------------------------------------
    .GPIO_LED11       (LED11),
    .GPIO_LED12       (LED12),
    .GPIO_LED13       (LED13),
    .GPIO_LED14       (LED14),
    //----------------------------------------------
    // Silicon Labs CP2102 USB-to-UART Bridge Chip
    //----------------------------------------------
    .USB_RS232_RXD1   (UART_RXD1),
    .USB_RS232_TXD1   (UART_TXD1),


    //----------------------------------------------
    // User Reset Push Button
    //----------------------------------------------
    .USER_RESET      (USER_RESET),

    //----------------------------------------------
    // TI CDCE913 Triple-Output PLL Clock Chip
    //   Y1: 40 MHz, USER_CLOCK can be used as
    //              external configuration clock
    //   Y2: 66.667 MHz
    //   Y3: 100 MHz 
    //----------------------------------------------
    .USER_CLOCK      (CLK_40MHz),

    //----------------------------------------------
    // User DIP Switch x4
    //----------------------------------------------
    .GPIO_DIP1       (SW1),
    .GPIO_DIP2       (SW2),
    .GPIO_DIP3       (SW3),
    .GPIO_DIP4       (SW4),

    //----------------------------------------------
    // Peripheral Modules (PMODs) and GPIO
    //     https://www.digilentinc.com/PMODs
    //----------------------------------------------

    // Connector J5
    .PMOD1_P3        (PMOD1_P3),    // Serial Debug Interface TX
    .PMOD1_P4        (PMOD1_P4)     // Serial Debug Interface RX
  );


  // DATA MEMORIES
  // Data Memory (CPU 00)
  RAM_D1 RAM_D1_omsp00 (
    .clka           ( dco_clk0),
    .ena            (~omsp00_dmem_cen_sp),
    .wea            (~omsp00_dmem_wen),
    .addra          ( omsp00_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp00_dmem_din),
    .douta          ( omsp00_dmem_dout_sp)
  );

  // Data Memory (CPU 01)
  RAM_D1 RAM_D1_omsp01 (
    .clka           ( dco_clk0),
    .ena            (~omsp01_dmem_cen_sp),
    .wea            (~omsp01_dmem_wen),
    .addra          ( omsp01_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp01_dmem_din),
    .douta          ( omsp01_dmem_dout_sp)
  );

  // Data Memory (CPU 10)
  RAM_D1 RAM_D1_omsp10 (
    .clka           ( dco_clk1),
    .ena            (~omsp10_dmem_cen_sp),
    .wea            (~omsp10_dmem_wen),
    .addra          ( omsp10_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp10_dmem_din),
    .douta          ( omsp10_dmem_dout_sp)
  );

  // Data Memory (CPU 11)
  RAM_D1 RAM_D1_omsp11 (
    .clka           ( dco_clk1),
    .ena            (~omsp11_dmem_cen_sp),
    .wea            (~omsp11_dmem_wen),
    .addra          ( omsp11_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp11_dmem_din),
    .douta          ( omsp11_dmem_dout_sp)
  );

  // Shared Data Memory (CPU 00 - CPU 01)
  RAM_D2 RAM_D2_shared0 (
    .clka           ( dco_clk0),
    .ena            (~omsp00_dmem_cen_dp),
    .wea            (~omsp00_dmem_wen),
    .addra          ( omsp00_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp00_dmem_din),
    .douta          ( omsp00_dmem_dout_dp),
    .clkb           ( dco_clk1),
    .enb            (~omsp11_dmem_cen_dp),
    .web            (~omsp11_dmem_wen),
    .addrb          ( omsp11_dmem_addr[`DMEM_MSB-1:0]),
    .dinb           ( omsp11_dmem_din),
    .doutb          ( omsp11_dmem_dout_dp)
  );

  // Shared Data Memory (CPU 10 - CPU 11)
  RAM_D2 RAM_D2_shared1 (
    .clka           ( dco_clk1),
    .ena            (~omsp10_dmem_cen_dp),
    .wea            (~omsp10_dmem_wen),
    .addra          ( omsp10_dmem_addr[`DMEM_MSB-1:0]),
    .dina           ( omsp10_dmem_din),
    .douta          ( omsp10_dmem_dout_dp),
    .clkb           ( dco_clk1),
    .enb            (~omsp11_dmem_cen_dp),
    .web            (~omsp11_dmem_wen),
    .addrb          ( omsp11_dmem_addr[`DMEM_MSB-1:0]),
    .dinb           ( omsp11_dmem_din),
    .doutb          ( omsp11_dmem_dout_dp)
  );

  // PROGRAM MEMORIES
  // Shared Program Memory (CPU 00 - CPU 01)
  RAM_P2 RAM_P2_shared0 (
    .clka           ( dco_clk0),
    .ena            (~omsp00_pmem_cen),
    .wea            (~omsp00_pmem_wen),
    .addra          ( omsp00_pmem_addr),
    .dina           ( omsp00_pmem_din),
    .douta          ( omsp00_pmem_dout),
    .clkb           ( dco_clk0),
    .enb            (~omsp01_pmem_cen),
    .web            (~omsp01_pmem_wen),
    .addrb          ( omsp01_pmem_addr),
    .dinb           ( omsp01_pmem_din),
    .doutb          ( omsp01_pmem_dout)
  );

  // Shared Program Memory (CPU 10 - CPU 11)
  RAM_P2 RAM_P2_shared1 (
    .clka           ( dco_clk1),
    .ena            (~omsp10_pmem_cen),
    .wea            (~omsp10_pmem_wen),
    .addra          ( omsp10_pmem_addr),
    .dina           ( omsp10_pmem_din),
    .douta          ( omsp10_pmem_dout),
    .clkb           ( dco_clk1),
    .enb            (~omsp11_pmem_cen),
    .web            (~omsp11_pmem_wen),
    .addrb          ( omsp11_pmem_addr),
    .dinb           ( omsp11_pmem_din),
    .doutb          ( omsp11_pmem_dout)
  );


  // Debug utility signals
  //----------------------------------------
  msp_debug msp_debug_omsp0 (

    // OUTPUTs
    .e_state0      (omsp00_e_state),       // Execution state
    .i_state0      (omsp00_i_state),       // Instruction fetch state
    .inst_cycle0   (omsp00_inst_cycle),    // Cycle number within current instruction
    .inst_full0    (omsp00_inst_full),     // Currently executed instruction (full version)
    .inst_number0  (omsp00_inst_number),   // Instruction number since last system reset
    .inst_pc0      (omsp00_inst_pc),       // Instruction Program counter
    .inst_short0   (omsp00_inst_short),    // Currently executed instruction (short version)

    .e_state1      (omsp10_e_state),       // Execution state
    .i_state1      (omsp10_i_state),       // Instruction fetch state
    .inst_cycle1   (omsp10_inst_cycle),    // Cycle number within current instruction
    .inst_full1    (omsp10_inst_full),     // Currently executed instruction (full version)
    .inst_number1  (omsp10_inst_number),   // Instruction number since last system reset
    .inst_pc1      (omsp10_inst_pc),       // Instruction Program counter
    .inst_short1   (omsp10_inst_short),    // Currently executed instruction (short version)

    // INPUTs
    .core_select  (1'b0)                 // Core selection
  );

  msp_debug msp_debug_omsp1 (

    // OUTPUTs
    .e_state0      (omsp01_e_state),       // Execution state
    .i_state0      (omsp01_i_state),       // Instruction fetch state
    .inst_cycle0   (omsp01_inst_cycle),    // Cycle number within current instruction
    .inst_full0    (omsp01_inst_full),     // Currently executed instruction (full version)
    .inst_number0  (omsp01_inst_number),   // Instruction number since last system reset
    .inst_pc0      (omsp01_inst_pc),       // Instruction Program counter
    .inst_short0   (omsp01_inst_short),    // Currently executed instruction (short version)

    .e_state1      (omsp11_e_state),       // Execution state
    .i_state1      (omsp11_i_state),       // Instruction fetch state
    .inst_cycle1   (omsp11_inst_cycle),    // Cycle number within current instruction
    .inst_full1    (omsp11_inst_full),     // Currently executed instruction (full version)
    .inst_number1  (omsp11_inst_number),   // Instruction number since last system reset
    .inst_pc1      (omsp11_inst_pc),       // Instruction Program counter
    .inst_short1   (omsp11_inst_short),    // Currently executed instruction (short version)

    // INPUTs
    .core_select  (1'b1)                 // Core selection
  );

  //
  // Generate Waveform
  //----------------------------------------
  initial begin
    `ifdef VPD_FILE
    $vcdplusfile("tb_openMSP430.vpd");
    $vcdpluson();
    `else
    `ifdef TRN_FILE
    $recordfile ("tb_openMSP430.trn");
    $recordvars;
    `else
    $dumpfile("tb_openMSP430.vcd");
    $dumpvars(0, tb_openMSP430);
    `endif
    `endif
  end

  //
  // End of simulation
  //----------------------------------------

  initial begin // Timeout
    #500000;
    $display(" ===============================================");
    $display("|               SIMULATION FAILED               |");
    $display("|              (simulation Timeout)             |");
    $display(" ===============================================");
    $finish;
  end

  initial begin // Normal end of test
    @(omsp00_inst_pc===16'hffff && omsp10_inst_pc===16'hffff)
    $display(" ===============================================");
    if (error!=0) begin
      $display("|               SIMULATION FAILED               |");
      $display("|     (some verilog stimulus checks failed)     |");
    end
    else if (~stimulus_done) begin
      $display("|               SIMULATION FAILED               |");
      $display("|     (the verilog stimulus didn't complete)    |");
    end
    else begin
      $display("|               SIMULATION PASSED               |");
    end
    $display(" ===============================================");
    $finish;
  end


  //
  // Tasks Definition
  //------------------------------

  task tb_error;
    input [65*8:0] error_string;
    begin
      $display("ERROR: %s %t", error_string, $time);
      error = error+1;
    end
  endtask


endmodule
