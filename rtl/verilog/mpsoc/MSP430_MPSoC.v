//----------------------------------------------------------------------------
// Copyright (C) 2011 Authors
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
// *File Name: openMSP430_fpga.v
// 
// *Module Description:
//                      openMSP430 FPGA Top-level for the Avnet LX9 Microboard
//
// *Author(s):
//              - Ricardo Ribalda,    ricardo.ribalda@gmail.com
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
`include "openMSP430_defines.v"

module MSP430_MPSoC (

  //SoC 0

  //CORE 0
  // CPU registers
  output        [15:0] omsp00_r0,
  output        [15:0] omsp00_r1,
  output        [15:0] omsp00_r2,
  output        [15:0] omsp00_r3,
  output        [15:0] omsp00_r4,
  output        [15:0] omsp00_r5,
  output        [15:0] omsp00_r6,
  output        [15:0] omsp00_r7,
  output        [15:0] omsp00_r8,
  output        [15:0] omsp00_r9,
  output        [15:0] omsp00_r10,
  output        [15:0] omsp00_r11,
  output        [15:0] omsp00_r12,
  output        [15:0] omsp00_r13,
  output        [15:0] omsp00_r14,
  output        [15:0] omsp00_r15,

  // Debug interface
  output               omsp00_dbg_en,
  output               omsp00_dbg_clk,
  output               omsp00_dbg_rst,

  // Interrupt detection
  output               omsp00_irq_detect,
  output               omsp00_nmi_pnd,

  output        [ 2:0] omsp00_i_state,
  output        [ 3:0] omsp00_e_state,
  output               omsp00_decode,
  output        [15:0] omsp00_ir,
  output        [ 5:0] omsp00_irq_num,
  output        [15:0] omsp00_pc,

  // CPU internals
  output               omsp00_mclk,
  output               omsp00_puc_rst,

  //CORE 1
  // CPU registers
  output        [15:0] omsp01_r0,
  output        [15:0] omsp01_r1,
  output        [15:0] omsp01_r2,
  output        [15:0] omsp01_r3,
  output        [15:0] omsp01_r4,
  output        [15:0] omsp01_r5,
  output        [15:0] omsp01_r6,
  output        [15:0] omsp01_r7,
  output        [15:0] omsp01_r8,
  output        [15:0] omsp01_r9,
  output        [15:0] omsp01_r10,
  output        [15:0] omsp01_r11,
  output        [15:0] omsp01_r12,
  output        [15:0] omsp01_r13,
  output        [15:0] omsp01_r14,
  output        [15:0] omsp01_r15,

  // Debug interface
  output               omsp01_dbg_en,
  output               omsp01_dbg_clk,
  output               omsp01_dbg_rst,

  // Interrupt detection
  output               omsp01_irq_detect,
  output               omsp01_nmi_pnd,

  output        [ 2:0] omsp01_i_state,
  output        [ 3:0] omsp01_e_state,
  output               omsp01_decode,
  output        [15:0] omsp01_ir,
  output        [ 5:0] omsp01_irq_num,
  output        [15:0] omsp01_pc,

  // CPU internals
  output               omsp01_mclk,
  output               omsp01_puc_rst,

  // Data memory
  output [`DMEM_MSB:0] omsp00_dmem_addr,
  output               omsp00_dmem_cen_sp,
  output               omsp00_dmem_cen_dp,
  output        [15:0] omsp00_dmem_din,
  output        [ 1:0] omsp00_dmem_wen,
  input         [15:0] omsp00_dmem_dout_sp,
  input         [15:0] omsp00_dmem_dout_dp,

  output [`DMEM_MSB:0] omsp01_dmem_addr,
  output               omsp01_dmem_cen_sp,
  output               omsp01_dmem_cen_dp,
  output        [15:0] omsp01_dmem_din,
  output        [ 1:0] omsp01_dmem_wen,
  input         [15:0] omsp01_dmem_dout_sp,
  input         [15:0] omsp01_dmem_dout_dp,

  // Program memory
  output [`PMEM_MSB:0] omsp00_pmem_addr,
  output               omsp00_pmem_cen,
  output        [15:0] omsp00_pmem_din,
  output        [ 1:0] omsp00_pmem_wen,
  input         [15:0] omsp00_pmem_dout,

  output [`PMEM_MSB:0] omsp01_pmem_addr,
  output               omsp01_pmem_cen,
  output        [15:0] omsp01_pmem_din,
  output        [ 1:0] omsp01_pmem_wen,
  input         [15:0] omsp01_pmem_dout,

  output               dco_clk0,

  //----------------------------------------------
  // User LEDs    
  //----------------------------------------------
  output   GPIO_LED01,
  output   GPIO_LED02,
  output   GPIO_LED03,
  output   GPIO_LED04,

  //----------------------------------------------
  // Silicon Labs CP2102 USB-to-UART Bridge Chip
  //----------------------------------------------
  input    USB_RS232_RXD0,
  output   USB_RS232_TXD0,


  //SoC 1

  //CORE 0
  // CPU registers
  output        [15:0] omsp10_r0,
  output        [15:0] omsp10_r1,
  output        [15:0] omsp10_r2,
  output        [15:0] omsp10_r3,
  output        [15:0] omsp10_r4,
  output        [15:0] omsp10_r5,
  output        [15:0] omsp10_r6,
  output        [15:0] omsp10_r7,
  output        [15:0] omsp10_r8,
  output        [15:0] omsp10_r9,
  output        [15:0] omsp10_r10,
  output        [15:0] omsp10_r11,
  output        [15:0] omsp10_r12,
  output        [15:0] omsp10_r13,
  output        [15:0] omsp10_r14,
  output        [15:0] omsp10_r15,

  // Debug interface
  output               omsp10_dbg_en,
  output               omsp10_dbg_clk,
  output               omsp10_dbg_rst,

  // Interrupt detection
  output               omsp10_irq_detect,
  output               omsp10_nmi_pnd,

  output        [ 2:0] omsp10_i_state,
  output        [ 3:0] omsp10_e_state,
  output               omsp10_decode,
  output        [15:0] omsp10_ir,
  output        [ 5:0] omsp10_irq_num,
  output        [15:0] omsp10_pc,

  // CPU internals
  output               omsp10_mclk,
  output               omsp10_puc_rst,

  //CORE 1
  // CPU registers
  output        [15:0] omsp11_r0,
  output        [15:0] omsp11_r1,
  output        [15:0] omsp11_r2,
  output        [15:0] omsp11_r3,
  output        [15:0] omsp11_r4,
  output        [15:0] omsp11_r5,
  output        [15:0] omsp11_r6,
  output        [15:0] omsp11_r7,
  output        [15:0] omsp11_r8,
  output        [15:0] omsp11_r9,
  output        [15:0] omsp11_r10,
  output        [15:0] omsp11_r11,
  output        [15:0] omsp11_r12,
  output        [15:0] omsp11_r13,
  output        [15:0] omsp11_r14,
  output        [15:0] omsp11_r15,

  // Debug interface
  output               omsp11_dbg_en,
  output               omsp11_dbg_clk,
  output               omsp11_dbg_rst,

  // Interrupt detection
  output               omsp11_irq_detect,
  output               omsp11_nmi_pnd,

  output        [ 2:0] omsp11_i_state,
  output        [ 3:0] omsp11_e_state,
  output               omsp11_decode,
  output        [15:0] omsp11_ir,
  output        [ 5:0] omsp11_irq_num,
  output        [15:0] omsp11_pc,

  // CPU internals
  output               omsp11_mclk,
  output               omsp11_puc_rst,

  // Data memory
  output [`DMEM_MSB:0] omsp10_dmem_addr,
  output               omsp10_dmem_cen_sp,
  output               omsp10_dmem_cen_dp,
  output        [15:0] omsp10_dmem_din,
  output        [ 1:0] omsp10_dmem_wen,
  input         [15:0] omsp10_dmem_dout_sp,
  input         [15:0] omsp10_dmem_dout_dp,

  output [`DMEM_MSB:0] omsp11_dmem_addr,
  output               omsp11_dmem_cen_sp,
  output               omsp11_dmem_cen_dp,
  output        [15:0] omsp11_dmem_din,
  output        [ 1:0] omsp11_dmem_wen,
  input         [15:0] omsp11_dmem_dout_sp,
  input         [15:0] omsp11_dmem_dout_dp,

  // Program memory
  output [`PMEM_MSB:0] omsp10_pmem_addr,
  output               omsp10_pmem_cen,
  output        [15:0] omsp10_pmem_din,
  output        [ 1:0] omsp10_pmem_wen,
  input         [15:0] omsp10_pmem_dout,

  output [`PMEM_MSB:0] omsp11_pmem_addr,
  output               omsp11_pmem_cen,
  output        [15:0] omsp11_pmem_din,
  output        [ 1:0] omsp11_pmem_wen,
  input         [15:0] omsp11_pmem_dout,

  output               dco_clk1,

  //----------------------------------------------
  // User LEDs    
  //----------------------------------------------
  output   GPIO_LED11,
  output   GPIO_LED12,
  output   GPIO_LED13,
  output   GPIO_LED14,

  //----------------------------------------------
  // Silicon Labs CP2102 USB-to-UART Bridge Chip
  //----------------------------------------------
  input    USB_RS232_RXD1,
  output   USB_RS232_TXD1,



  //----------------------------------------------
  // User Reset Push Button
  //----------------------------------------------
  input    USER_RESET,

  //----------------------------------------------
  // TI CDCE913 Triple-Output PLL Clock Chip
  //   Y1: 40 MHz, USER_CLOCK can be used as
  //              external configuration clock
  //   Y2: 66.667 MHz
  //   Y3: 100 MHz 
  //----------------------------------------------
  input    USER_CLOCK,

  //----------------------------------------------
  // User DIP Switch x4
  //----------------------------------------------
  input    GPIO_DIP1,
  input    GPIO_DIP2,
  input    GPIO_DIP3,
  input    GPIO_DIP4,

  //----------------------------------------------
  // Peripheral Modules (PMODs) and GPIO
  //     https://www.digilentinc.com/PMODs
  //----------------------------------------------

  // Connector J5
  inout    PMOD1_P3,
  input    PMOD1_P4
);

  //=============================================================================
  // 1)  OPENMSP430 SYSTEM on CHIP 0
  //=============================================================================

  MSP430_SoC MSP430_SoC_0 (

    // CORE 0
    // CPU registers
    .omsp0_r0         (omsp00_r0),
    .omsp0_r1         (omsp00_r1),
    .omsp0_r2         (omsp00_r2),
    .omsp0_r3         (omsp00_r3),
    .omsp0_r4         (omsp00_r4),
    .omsp0_r5         (omsp00_r5),
    .omsp0_r6         (omsp00_r6),
    .omsp0_r7         (omsp00_r7),
    .omsp0_r8         (omsp00_r8),
    .omsp0_r9         (omsp00_r9),
    .omsp0_r10        (omsp00_r10),
    .omsp0_r11        (omsp00_r11),
    .omsp0_r12        (omsp00_r12),
    .omsp0_r13        (omsp00_r13),
    .omsp0_r14        (omsp00_r14),
    .omsp0_r15        (omsp00_r15),

    // Debug interface
    .omsp0_dbg_en     (omsp00_dbg_en),
    .omsp0_dbg_clk    (omsp00_dbg_clk),
    .omsp0_dbg_rst    (omsp00_dbg_rst),

    // Interrupt detection
    .omsp0_irq_detect (omsp00_irq_detect),
    .omsp0_nmi_pnd    (omsp00_nmi_pnd),

    .omsp0_i_state    (omsp00_i_state),
    .omsp0_e_state    (omsp00_e_state),
    .omsp0_decode     (omsp00_decode),
    .omsp0_ir         (omsp00_ir),
    .omsp0_irq_num    (omsp00_irq_num),
    .omsp0_pc         (omsp00_pc),

    // CPU internals
    .omsp0_mclk       (omsp00_mclk),
    .omsp0_puc_rst    (omsp00_puc_rst),

    // CORE 1
    // CPU registers
    .omsp1_r0         (omsp01_r0),
    .omsp1_r1         (omsp01_r1),
    .omsp1_r2         (omsp01_r2),
    .omsp1_r3         (omsp01_r3),
    .omsp1_r4         (omsp01_r4),
    .omsp1_r5         (omsp01_r5),
    .omsp1_r6         (omsp01_r6),
    .omsp1_r7         (omsp01_r7),
    .omsp1_r8         (omsp01_r8),
    .omsp1_r9         (omsp01_r9),
    .omsp1_r10        (omsp01_r10),
    .omsp1_r11        (omsp01_r11),
    .omsp1_r12        (omsp01_r12),
    .omsp1_r13        (omsp01_r13),
    .omsp1_r14        (omsp01_r14),
    .omsp1_r15        (omsp01_r15),

    // Debug interface
    .omsp1_dbg_en     (omsp01_dbg_en),
    .omsp1_dbg_clk    (omsp01_dbg_clk),
    .omsp1_dbg_rst    (omsp01_dbg_rst),

    // Interrupt detection
    .omsp1_irq_detect (omsp01_irq_detect),
    .omsp1_nmi_pnd    (omsp01_nmi_pnd),

    .omsp1_i_state    (omsp01_i_state),
    .omsp1_e_state    (omsp01_e_state),
    .omsp1_decode     (omsp01_decode),
    .omsp1_ir         (omsp01_ir),
    .omsp1_irq_num    (omsp01_irq_num),
    .omsp1_pc         (omsp01_pc),

    // CPU internals
    .omsp1_mclk       (omsp01_mclk),
    .omsp1_puc_rst    (omsp01_puc_rst),

    // Data memory
    .omsp0_dmem_addr    (omsp00_dmem_addr),
    .omsp0_dmem_cen_sp  (omsp00_dmem_cen_sp),
    .omsp0_dmem_cen_dp  (omsp00_dmem_cen_dp),
    .omsp0_dmem_din     (omsp00_dmem_din),
    .omsp0_dmem_wen     (omsp00_dmem_wen),
    .omsp0_dmem_dout_sp (omsp00_dmem_dout_sp),
    .omsp0_dmem_dout_dp (omsp00_dmem_dout_dp),

    .omsp1_dmem_addr    (omsp01_dmem_addr),
    .omsp1_dmem_cen_sp  (omsp01_dmem_cen_sp),
    .omsp1_dmem_cen_dp  (omsp01_dmem_cen_dp),
    .omsp1_dmem_din     (omsp01_dmem_din),
    .omsp1_dmem_wen     (omsp01_dmem_wen),
    .omsp1_dmem_dout_sp (omsp01_dmem_dout_sp),
    .omsp1_dmem_dout_dp (omsp01_dmem_dout_dp),

    // Program memory
    .omsp0_pmem_addr  (omsp00_pmem_addr),
    .omsp0_pmem_cen   (omsp00_pmem_cen),
    .omsp0_pmem_din   (omsp00_pmem_din),
    .omsp0_pmem_wen   (omsp00_pmem_wen),
    .omsp0_pmem_dout  (omsp00_pmem_dout),

    .omsp1_pmem_addr  (omsp01_pmem_addr),
    .omsp1_pmem_cen   (omsp01_pmem_cen),
    .omsp1_pmem_din   (omsp01_pmem_din),
    .omsp1_pmem_wen   (omsp01_pmem_wen),
    .omsp1_pmem_dout  (omsp01_pmem_dout),

    .dco_clk          (dco_clk0),

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
    // User LEDs			
    //----------------------------------------------
    .GPIO_LED1       (LED01),
    .GPIO_LED2       (LED02),
    .GPIO_LED3       (LED03),
    .GPIO_LED4       (LED04),

    //----------------------------------------------
    // Silicon Labs CP2102 USB-to-UART Bridge Chip
    //----------------------------------------------
    .USB_RS232_RXD   (USB_RS232_RXD0),
    .USB_RS232_TXD   (USB_RS232_TXD0),

    //----------------------------------------------
    // Peripheral Modules (PMODs) and GPIO
    //     https://www.digilentinc.com/PMODs
    //----------------------------------------------

    // Connector J5
    .PMOD1_P3        (PMOD1_P3),    // Serial Debug Interface TX
    .PMOD1_P4        (PMOD1_P4)     // Serial Debug Interface RX
  );

  //=============================================================================
  // 2)  OPENMSP430 OPENMSP430 SYSTEM on CHIP 1
  //=============================================================================

  MSP430_SoC MSP430_SoC_1 (

    // CORE 0
    // CPU registers
    .omsp0_r0         (omsp10_r0),
    .omsp0_r1         (omsp10_r1),
    .omsp0_r2         (omsp10_r2),
    .omsp0_r3         (omsp10_r3),
    .omsp0_r4         (omsp10_r4),
    .omsp0_r5         (omsp10_r5),
    .omsp0_r6         (omsp10_r6),
    .omsp0_r7         (omsp10_r7),
    .omsp0_r8         (omsp10_r8),
    .omsp0_r9         (omsp10_r9),
    .omsp0_r10        (omsp10_r10),
    .omsp0_r11        (omsp10_r11),
    .omsp0_r12        (omsp10_r12),
    .omsp0_r13        (omsp10_r13),
    .omsp0_r14        (omsp10_r14),
    .omsp0_r15        (omsp10_r15),

    // Debug interface
    .omsp0_dbg_en     (omsp10_dbg_en),
    .omsp0_dbg_clk    (omsp10_dbg_clk),
    .omsp0_dbg_rst    (omsp10_dbg_rst),

    // Interrupt detection
    .omsp0_irq_detect (omsp10_irq_detect),
    .omsp0_nmi_pnd    (omsp10_nmi_pnd),

    .omsp0_i_state    (omsp10_i_state),
    .omsp0_e_state    (omsp10_e_state),
    .omsp0_decode     (omsp10_decode),
    .omsp0_ir         (omsp10_ir),
    .omsp0_irq_num    (omsp10_irq_num),
    .omsp0_pc         (omsp10_pc),

    // CPU internals
    .omsp0_mclk       (omsp10_mclk),
    .omsp0_puc_rst    (omsp10_puc_rst),

    // CORE 1
    // CPU registers
    .omsp1_r0         (omsp11_r0),
    .omsp1_r1         (omsp11_r1),
    .omsp1_r2         (omsp11_r2),
    .omsp1_r3         (omsp11_r3),
    .omsp1_r4         (omsp11_r4),
    .omsp1_r5         (omsp11_r5),
    .omsp1_r6         (omsp11_r6),
    .omsp1_r7         (omsp11_r7),
    .omsp1_r8         (omsp11_r8),
    .omsp1_r9         (omsp11_r9),
    .omsp1_r10        (omsp11_r10),
    .omsp1_r11        (omsp11_r11),
    .omsp1_r12        (omsp11_r12),
    .omsp1_r13        (omsp11_r13),
    .omsp1_r14        (omsp11_r14),
    .omsp1_r15        (omsp11_r15),

    // Debug interface
    .omsp1_dbg_en     (omsp11_dbg_en),
    .omsp1_dbg_clk    (omsp11_dbg_clk),
    .omsp1_dbg_rst    (omsp11_dbg_rst),

    // Interrupt detection
    .omsp1_irq_detect (omsp11_irq_detect),
    .omsp1_nmi_pnd    (omsp11_nmi_pnd),

    .omsp1_i_state    (omsp11_i_state),
    .omsp1_e_state    (omsp11_e_state),
    .omsp1_decode     (omsp11_decode),
    .omsp1_ir         (omsp11_ir),
    .omsp1_irq_num    (omsp11_irq_num),
    .omsp1_pc         (omsp11_pc),

    // CPU internals
    .omsp1_mclk       (omsp11_mclk),
    .omsp1_puc_rst    (omsp11_puc_rst),

    // Data memory
    .omsp0_dmem_addr    (omsp10_dmem_addr),
    .omsp0_dmem_cen_sp  (omsp10_dmem_cen_sp),
    .omsp0_dmem_cen_dp  (omsp10_dmem_cen_dp),
    .omsp0_dmem_din     (omsp10_dmem_din),
    .omsp0_dmem_wen     (omsp10_dmem_wen),
    .omsp0_dmem_dout_sp (omsp10_dmem_dout_sp),
    .omsp0_dmem_dout_dp (omsp10_dmem_dout_dp),

    .omsp1_dmem_addr    (omsp11_dmem_addr),
    .omsp1_dmem_cen_sp  (omsp11_dmem_cen_sp),
    .omsp1_dmem_cen_dp  (omsp11_dmem_cen_dp),
    .omsp1_dmem_din     (omsp11_dmem_din),
    .omsp1_dmem_wen     (omsp11_dmem_wen),
    .omsp1_dmem_dout_sp (omsp11_dmem_dout_sp),
    .omsp1_dmem_dout_dp (omsp11_dmem_dout_dp),

    // Program memory
    .omsp0_pmem_addr  (omsp10_pmem_addr),
    .omsp0_pmem_cen   (omsp10_pmem_cen),
    .omsp0_pmem_din   (omsp10_pmem_din),
    .omsp0_pmem_wen   (omsp10_pmem_wen),
    .omsp0_pmem_dout  (omsp10_pmem_dout),

    .omsp1_pmem_addr  (omsp11_pmem_addr),
    .omsp1_pmem_cen   (omsp11_pmem_cen),
    .omsp1_pmem_din   (omsp11_pmem_din),
    .omsp1_pmem_wen   (omsp11_pmem_wen),
    .omsp1_pmem_dout  (omsp11_pmem_dout),

    .dco_clk          (dco_clk1),

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
    // User LEDs			
    //----------------------------------------------
    .GPIO_LED1       (GPIO_LED11),
    .GPIO_LED2       (GPIO_LED12),
    .GPIO_LED3       (GPIO_LED13),
    .GPIO_LED4       (GPIO_LED14),

    //----------------------------------------------
    // Silicon Labs CP2102 USB-to-UART Bridge Chip
    //----------------------------------------------
    .USB_RS232_RXD   (USB_RS232_RXD1),
    .USB_RS232_TXD   (USB_RS232_TXD1),

    //----------------------------------------------
    // Peripheral Modules (PMODs) and GPIO
    //     https://www.digilentinc.com/PMODs
    //----------------------------------------------

    // Connector J5
    .PMOD1_P3        (PMOD1_P3),    // Serial Debug Interface TX
    .PMOD1_P4        (PMOD1_P4)     // Serial Debug Interface RX
  );
endmodule // MSP430_MPSoC
