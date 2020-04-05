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
// *File Name: msp_debug.v
// 
// *Module Description:
//                      MSP430 core debug utility signals
//
// *Author(s):
//              - Olivier Girard,    olgirard@gmail.com
//
//----------------------------------------------------------------------------
// $Rev: 136 $
// $LastChangedBy: olivier.girard $
// $LastChangedDate: 2012-03-22 22:14:16 +0100 (Thu, 22 Mar 2012) $
//----------------------------------------------------------------------------
`ifdef OMSP_NO_INCLUDE
`else
`include "openMSP430_defines.v"
`endif

module msp_debug (

  // OUTPUTs
  e_state0,                       // Execution state
  i_state0,                       // Instruction fetch state
  inst_cycle0,                    // Cycle number within current instruction
  inst_full0,                     // Currently executed instruction (full version)
  inst_number0,                   // Instruction number since last system reset
  inst_pc0,                       // Instruction Program counter
  inst_short0,                    // Currently executed instruction (short version)

  e_state1,                       // Execution state
  i_state1,                       // Instruction fetch state
  inst_cycle1,                    // Cycle number within current instruction
  inst_full1,                     // Currently executed instruction (full version)
  inst_number1,                   // Instruction number since last system reset
  inst_pc1,                       // Instruction Program counter
  inst_short1,                    // Currently executed instruction (short version)

  // INPUTs
  core_select                    // Core selection
);

  // OUTPUTs
  //============
  output  [8*32-1:0] e_state0;        // Execution state
  output  [8*32-1:0] i_state0;        // Instruction fetch state
  output      [31:0] inst_cycle0;     // Cycle number within current instruction
  output  [8*32-1:0] inst_full0;      // Currently executed instruction (full version)
  output      [31:0] inst_number0;    // Instruction number since last system reset
  output      [15:0] inst_pc0;        // Instruction Program counter
  output  [8*32-1:0] inst_short0;     // Currently executed instruction (short version)

  output  [8*32-1:0] e_state1;        // Execution state
  output  [8*32-1:0] i_state1;        // Instruction fetch state
  output      [31:0] inst_cycle1;     // Cycle number within current instruction
  output  [8*32-1:0] inst_full1;      // Currently executed instruction (full version)
  output      [31:0] inst_number1;    // Instruction number since last system reset
  output      [15:0] inst_pc1;        // Instruction Program counter
  output  [8*32-1:0] inst_short1;     // Currently executed instruction (short version)

  // INPUTs
  //============
  input              core_select;    // Core selection


  //=============================================================================
  // 1) ASCII FORMATING FUNCTIONS
  //=============================================================================

  // This function simply concatenates two strings together, ignorning the NULL
  // at the end of string2.
  // The specified number of space will be inserted between string1 and string2
  function [64*8-1:0] myFormat;

    input [32*8-1:0] string1;
    input [32*8-1:0] string2;
    input      [3:0] space;

    integer i,j;      
    begin
      myFormat = 0;
      `ifdef VXL			// no +:
      `else
      j        = 0;
      for ( i=0; i < 32; i=i+1) begin                // Copy string2
        myFormat[8*i +: 8] = string2[8*i +: 8];
        if ((string2[8*i +: 8] == 0) && (j == 0)) j=i;  
      end

      for ( i=0; i < space; i=i+1)                   // Add spaces
        myFormat[8*(j+i) +: 8] = " ";
      j=j+space;

      for ( i=0; i < 32; i=i+1)                      // Copy string1
        myFormat[8*(j+i) +: 8] = string1[8*i +: 8];
      `endif    
    end
  endfunction


  //=============================================================================
  // 2) CONNECTIONS TO MSP430 CORE INTERNALS
  //=============================================================================

  //-------------------------
  // SoC 0
  //-------------------------

  //-------------------------
  // CPU 0
  //-------------------------
  wire  [2:0] omsp00_i_state_bin = tb_openMSP430.omsp00_i_state_bin;
  wire  [3:0] omsp00_e_state_bin = tb_openMSP430.omsp00_e_state_bin;

  wire        omsp00_decode      = tb_openMSP430.omsp00_decode;
  wire [15:0] omsp00_ir          = tb_openMSP430.omsp00_ir;
  wire        omsp00_irq_detect  = tb_openMSP430.omsp00_irq_detect;
  wire  [3:0] omsp00_irq_num     = tb_openMSP430.omsp00_irq_num;
  wire [15:0] omsp00_pc          = tb_openMSP430.omsp00_pc;

  wire        omsp00_mclk        = tb_openMSP430.omsp00_mclk;
  wire        omsp00_puc_rst     = tb_openMSP430.omsp00_puc_rst;

  //-------------------------
  // CPU 1
  //-------------------------
  wire  [2:0] omsp01_i_state_bin = tb_openMSP430.omsp01_i_state_bin;
  wire  [3:0] omsp01_e_state_bin = tb_openMSP430.omsp01_e_state_bin;

  wire        omsp01_decode      = tb_openMSP430.omsp01_decode;
  wire [15:0] omsp01_ir          = tb_openMSP430.omsp01_ir;
  wire        omsp01_irq_detect  = tb_openMSP430.omsp01_irq_detect;
  wire  [3:0] omsp01_irq_num     = tb_openMSP430.omsp01_irq_num;
  wire [15:0] omsp01_pc          = tb_openMSP430.omsp01_pc;

  wire        omsp01_mclk        = tb_openMSP430.omsp01_mclk;
  wire        omsp01_puc_rst     = tb_openMSP430.omsp01_puc_rst;

  //-------------------------
  // SoC 1
  //-------------------------

  //-------------------------
  // CPU 0
  //-------------------------
  wire  [2:0] omsp10_i_state_bin = tb_openMSP430.omsp10_i_state_bin;
  wire  [3:0] omsp10_e_state_bin = tb_openMSP430.omsp10_e_state_bin;

  wire        omsp10_decode      = tb_openMSP430.omsp10_decode;
  wire [15:0] omsp10_ir          = tb_openMSP430.omsp10_ir;
  wire        omsp10_irq_detect  = tb_openMSP430.omsp10_irq_detect;
  wire  [3:0] omsp10_irq_num     = tb_openMSP430.omsp10_irq_num;
  wire [15:0] omsp10_pc          = tb_openMSP430.omsp10_pc;

  wire        omsp10_mclk        = tb_openMSP430.omsp10_mclk;
  wire        omsp10_puc_rst     = tb_openMSP430.omsp10_puc_rst;

  //-------------------------
  // CPU 1
  //-------------------------
  wire  [2:0] omsp11_i_state_bin = tb_openMSP430.omsp11_i_state_bin;
  wire  [3:0] omsp11_e_state_bin = tb_openMSP430.omsp11_e_state_bin;

  wire        omsp11_decode      = tb_openMSP430.omsp11_decode;
  wire [15:0] omsp11_ir          = tb_openMSP430.omsp11_ir;
  wire        omsp11_irq_detect  = tb_openMSP430.omsp11_irq_detect;
  wire  [3:0] omsp11_irq_num     = tb_openMSP430.omsp11_irq_num;
  wire [15:0] omsp11_pc          = tb_openMSP430.omsp11_pc;

  wire        omsp11_mclk        = tb_openMSP430.omsp11_mclk;
  wire        omsp11_puc_rst     = tb_openMSP430.omsp11_puc_rst;

  //-------------------------
  // CPU Selection 0
  //-------------------------
  wire  [2:0] i_state_bin0 = core_select ? omsp01_i_state_bin : omsp00_i_state_bin;
  wire  [3:0] e_state_bin0 = core_select ? omsp01_e_state_bin : omsp00_e_state_bin;

  wire        decode0      = core_select ? omsp01_decode      : omsp00_decode;
  wire [15:0] ir0          = core_select ? omsp01_ir          : omsp00_ir;
  wire        irq_detect0  = core_select ? omsp01_irq_detect  : omsp00_irq_detect;
  wire  [3:0] irq_num0     = core_select ? omsp01_irq_num     : omsp00_irq_num;
  wire [15:0] pc0          = core_select ? omsp01_pc          : omsp00_pc;

  wire        mclk0        = core_select ? omsp01_mclk        : omsp00_mclk;
  wire        puc_rst0     = core_select ? omsp01_puc_rst     : omsp00_puc_rst;

  //-------------------------
  // CPU Selection 1
  //-------------------------
  wire  [2:0] i_state_bin1 = core_select ? omsp11_i_state_bin : omsp10_i_state_bin;
  wire  [3:0] e_state_bin1 = core_select ? omsp11_e_state_bin : omsp10_e_state_bin;

  wire        decode1      = core_select ? omsp11_decode      : omsp10_decode;
  wire [15:0] ir1          = core_select ? omsp11_ir          : omsp10_ir;
  wire        irq_detect1  = core_select ? omsp11_irq_detect  : omsp10_irq_detect;
  wire  [3:0] irq_num1     = core_select ? omsp11_irq_num     : omsp10_irq_num;
  wire [15:0] pc1          = core_select ? omsp11_pc          : omsp10_pc;

  wire        mclk1        = core_select ? omsp11_mclk        : omsp10_mclk;
  wire        puc_rst1     = core_select ? omsp11_puc_rst     : omsp10_puc_rst;


  //=============================================================================
  // 3) GENERATE DEBUG SIGNALS 0
  //=============================================================================

  // Instruction fetch state
  //=========================
  reg [8*32-1:0] i_state0;

  always @(i_state_bin0) begin
    case(i_state_bin0)
      3'h0    : i_state0 =  "IRQ_FETCH";
      3'h1    : i_state0 =  "IRQ_DONE";
      3'h2    : i_state0 =  "DEC";
      3'h3    : i_state0 =  "EXT1";
      3'h4    : i_state0 =  "EXT2";
      3'h5    : i_state0 =  "IDLE";
      default : i_state0 =  "XXXXX";
    endcase
  end

  // Execution state
  //=========================

  reg [8*32-1:0] e_state0;

  always @(e_state_bin0) begin
    case(e_state_bin0)
      4'h2    : e_state0 =  "IRQ_0";
      4'h1    : e_state0 =  "IRQ_1";
      4'h0    : e_state0 =  "IRQ_2";
      4'h3    : e_state0 =  "IRQ_3";
      4'h4    : e_state0 =  "IRQ_4";
      4'h5    : e_state0 =  "SRC_AD";
      4'h6    : e_state0 =  "SRC_RD";
      4'h7    : e_state0 =  "SRC_WR";
      4'h8    : e_state0 =  "DST_AD";
      4'h9    : e_state0 =  "DST_RD";
      4'hA    : e_state0 =  "DST_WR";
      4'hB    : e_state0 =  "EXEC";
      4'hC    : e_state0 =  "JUMP";
      4'hD    : e_state0 =  "IDLE";
      default : e_state0 =  "xxxx";
    endcase
  end

  // Count instruction number & cycles
  //====================================

  reg [31:0]  inst_number0;
  always @(posedge mclk0 or posedge puc_rst0) begin
    if (puc_rst0)     inst_number0  <= 0;
    else if (decode0) inst_number0  <= inst_number0+1;
  end

  reg [31:0]  inst_cycle0;
  always @(posedge mclk0 or posedge puc_rst0) begin
    if (puc_rst0)     inst_cycle0 <= 0;
    else if (decode0) inst_cycle0 <= 0;
    else              inst_cycle0 <= inst_cycle0+1;
  end

  // Decode instruction
  //====================================

  // Buffer opcode0
  reg [15:0]  opcode0;
  always @(posedge mclk0 or posedge puc_rst0) begin
    if (puc_rst0)     opcode0  <= 0;
    else if (decode0) opcode0  <= ir0;
  end

  // Interrupts
  reg irq0;
  always @(posedge mclk0 or posedge puc_rst0) begin
    if (puc_rst0)     irq0     <= 1'b1;
    else if (decode0) irq0     <= irq_detect0;
  end

  // Instruction type
  reg [8*32-1:0] inst_type0;
  always @(opcode0 or irq0) begin
    if (irq0)
      inst_type0 =  "IRQ";
    else
      case(opcode0[15:13])
        3'b000  : inst_type0 =  "SIG-OP";
        3'b001  : inst_type0 =  "JUMP";
        default : inst_type0 =  "TWO-OP";
      endcase
  end

  // Instructions name
  reg [8*32-1:0] inst_name0;
  always @(opcode0 or inst_type0 or irq_num0) begin
    if (inst_type0=="IRQ")
      case(irq_num0[3:0])
        4'b0000        : inst_name0 =  "IRQ 0";
        4'b0001        : inst_name0 =  "IRQ 1";
        4'b0010        : inst_name0 =  "IRQ 2";
        4'b0011        : inst_name0 =  "IRQ 3";
        4'b0100        : inst_name0 =  "IRQ 4";
        4'b0101        : inst_name0 =  "IRQ 5";
        4'b0110        : inst_name0 =  "IRQ 6";
        4'b0111        : inst_name0 =  "IRQ 7";
        4'b1000        : inst_name0 =  "IRQ 8";
        4'b1001        : inst_name0 =  "IRQ 9";
        4'b1010        : inst_name0 =  "IRQ 10";
        4'b1011        : inst_name0 =  "IRQ 11";
        4'b1100        : inst_name0 =  "IRQ 12";
        4'b1101        : inst_name0 =  "IRQ 13";
        4'b1110        : inst_name0 =  "NMI";
        default        : inst_name0 =  "RESET";
      endcase
    else if (inst_type0=="SIG-OP")
      case(opcode0[15:7])
        9'b000100_000  : inst_name0 =  "RRC";
        9'b000100_001  : inst_name0 =  "SWPB";
        9'b000100_010  : inst_name0 =  "RRA";
        9'b000100_011  : inst_name0 =  "SXT";
        9'b000100_100  : inst_name0 =  "PUSH";
        9'b000100_101  : inst_name0 =  "CALL";
        9'b000100_110  : inst_name0 =  "RETI";
        default        : inst_name0 =  "xxxx";
      endcase
    else if (inst_type0=="JUMP")
      case(opcode0[15:10])
        6'b001_000     : inst_name0 =  "JNE";
        6'b001_001     : inst_name0 =  "JEQ";
        6'b001_010     : inst_name0 =  "JNC";
        6'b001_011     : inst_name0 =  "JC";
        6'b001_100     : inst_name0 =  "JN";
        6'b001_101     : inst_name0 =  "JGE";
        6'b001_110     : inst_name0 =  "JL";
        6'b001_111     : inst_name0 =  "JMP";
        default        : inst_name0 =  "xxxx";
      endcase
    else if (inst_type0=="TWO-OP")
      case(opcode0[15:12])
        4'b0100        : inst_name0 =  "MOV";
        4'b0101        : inst_name0 =  "ADD";
        4'b0110        : inst_name0 =  "ADDC";
        4'b0111        : inst_name0 =  "SUBC";
        4'b1000        : inst_name0 =  "SUB";
        4'b1001        : inst_name0 =  "CMP";
        4'b1010        : inst_name0 =  "DADD";
        4'b1011        : inst_name0 =  "BIT";
        4'b1100        : inst_name0 =  "BIC";
        4'b1101        : inst_name0 =  "BIS";
        4'b1110        : inst_name0 =  "XOR";
        4'b1111        : inst_name0 =  "AND";
        default        : inst_name0 =  "xxxx";
      endcase
  end

  // Instructions byte/word mode
  reg [8*32-1:0] inst_bw0;
  always @(opcode0 or inst_type0) begin
    if (inst_type0=="IRQ")
      inst_bw0 =  "";
    else if (inst_type0=="SIG-OP")
      inst_bw0 =  opcode0[6] ? ".B" : "";
    else if (inst_type0=="JUMP")
      inst_bw0 =  "";
    else if (inst_type0=="TWO-OP")
      inst_bw0 =  opcode0[6] ? ".B" : "";
  end

  // Source register
  reg [8*32-1:0] inst_src0;
  wire     [3:0] src_reg0 = (inst_type0=="SIG-OP") ? opcode0[3:0] : opcode0[11:8];

  always @(src_reg0 or inst_type0) begin
    if (inst_type0=="IRQ")
      inst_src0 =  "";
    else if (inst_type0=="JUMP")
      inst_src0 =  "";
    else if ((inst_type0=="SIG-OP") || (inst_type0=="TWO-OP"))
      case(src_reg0)
        4'b0000 : inst_src0 =  "r0";
        4'b0001 : inst_src0 =  "r1";
        4'b0010 : inst_src0 =  "r2";
        4'b0011 : inst_src0 =  "r3";
        4'b0100 : inst_src0 =  "r4";
        4'b0101 : inst_src0 =  "r5";
        4'b0110 : inst_src0 =  "r6";
        4'b0111 : inst_src0 =  "r7";
        4'b1000 : inst_src0 =  "r8";
        4'b1001 : inst_src0 =  "r9";
        4'b1010 : inst_src0 =  "r10";
        4'b1011 : inst_src0 =  "r11";
        4'b1100 : inst_src0 =  "r12";
        4'b1101 : inst_src0 =  "r13";
        4'b1110 : inst_src0 =  "r14";
        default : inst_src0 =  "r15";
      endcase
  end

  // Destination register
  reg [8*32-1:0] inst_dst0;
  always @(opcode0 or inst_type0) begin
    if (inst_type0=="IRQ")
      inst_dst0 =  "";
    else if (inst_type0=="SIG-OP")
      inst_dst0 =  "";
    else if (inst_type0=="JUMP")
      inst_dst0 =  "";
    else if (inst_type0=="TWO-OP")
      case(opcode0[3:0])
        4'b0000 : inst_dst0 =  "r0";
        4'b0001 : inst_dst0 =  "r1";
        4'b0010 : inst_dst0 =  "r2";
        4'b0011 : inst_dst0 =  "r3";
        4'b0100 : inst_dst0 =  "r4";
        4'b0101 : inst_dst0 =  "r5";
        4'b0110 : inst_dst0 =  "r6";
        4'b0111 : inst_dst0 =  "r7";
        4'b1000 : inst_dst0 =  "r8";
        4'b1001 : inst_dst0 =  "r9";
        4'b1010 : inst_dst0 =  "r10";
        4'b1011 : inst_dst0 =  "r11";
        4'b1100 : inst_dst0 =  "r12";
        4'b1101 : inst_dst0 =  "r13";
        4'b1110 : inst_dst0 =  "r14";
        default : inst_dst0 =  "r15";
      endcase
  end

  // Source Addressing mode
  reg [8*32-1:0] inst_as0;
  always @(inst_type0 or src_reg0 or opcode0 or inst_src0) begin
    if (inst_type0=="IRQ")
      inst_as0 =  "";
    else if (inst_type0=="JUMP")
      inst_as0 =  "";
    else if (src_reg0==4'h3) // Addressing mode using R3
      case (opcode0[5:4])
        2'b11  : inst_as0 =  "#-1";
        2'b10  : inst_as0 =  "#2";
        2'b01  : inst_as0 =  "#1";
        default: inst_as0 =  "#0";
      endcase
    else if (src_reg0==4'h2) // Addressing mode using R2
      case (opcode0[5:4])
        2'b11  : inst_as0 =  "#8";
        2'b10  : inst_as0 =  "#4";
        2'b01  : inst_as0 =  "&EDE";
        default: inst_as0 =  inst_src0;
      endcase
    else if (src_reg0==4'h0) // Addressing mode using R0
      case (opcode0[5:4])
        2'b11  : inst_as0 =  "#N";
        2'b10  : inst_as0 =  myFormat("@", inst_src0, 0);
        2'b01  : inst_as0 =  "EDE";
        default: inst_as0 =  inst_src0;
      endcase
    else                    // General Addressing mode
      case (opcode0[5:4])
        2'b11  : begin
          inst_as0 =  myFormat("@", inst_src0, 0);
          inst_as0 =  myFormat(inst_as0, "+", 0);
        end
        2'b10  : inst_as0 =  myFormat("@", inst_src0, 0);
        2'b01  : begin
          inst_as0 =  myFormat("x(", inst_src0, 0);
          inst_as0 =  myFormat(inst_as0, ")", 0);
        end
        default: inst_as0 =  inst_src0;
      endcase
  end

  // Destination Addressing mode
  reg [8*32-1:0] inst_ad0;
  always @(opcode0 or inst_type0 or inst_dst0) begin
    if (inst_type0!="TWO-OP")
      inst_ad0 =  "";
    else if (opcode0[3:0]==4'h2)   // Addressing mode using R2
      case (opcode0[7])
        1'b1   : inst_ad0 =  "&EDE";
        default: inst_ad0 =  inst_dst0;
      endcase
    else if (opcode0[3:0]==4'h0)   // Addressing mode using R0
      case (opcode0[7])
        2'b1   : inst_ad0 =  "EDE";
        default: inst_ad0 =  inst_dst0;
      endcase
    else                          // General Addressing mode
      case (opcode0[7])
        2'b1   : begin
          inst_ad0 =  myFormat("x(", inst_dst0, 0);
          inst_ad0 =  myFormat(inst_ad0, ")", 0);
        end
        default: inst_ad0 =  inst_dst0;
      endcase
  end

  // Currently executed instruction
  //================================

  wire [8*32-1:0] inst_short0 = inst_name0;

  reg  [8*32-1:0] inst_full0;
  always @(inst_type0 or inst_name0 or inst_bw0 or inst_as0 or inst_ad0) begin
    inst_full0   = myFormat(inst_name0, inst_bw0, 0);
    inst_full0   = myFormat(inst_full0, inst_as0, 1);
    if (inst_type0=="TWO-OP")
      inst_full0 = myFormat(inst_full0, ",",     0);
    inst_full0   = myFormat(inst_full0, inst_ad0, 1);
    if (opcode0==16'h4303)
      inst_full0 = "NOP";
    if (opcode0==`DBG_SWBRK_OP)
      inst_full0 = "SBREAK";
  end


  // Instruction program counter
  //================================

  reg  [15:0] inst_pc0;
  always @(posedge mclk0 or posedge puc_rst0) begin
    if (puc_rst0)     inst_pc0  <=  16'h0000;
    else if (decode0) inst_pc0  <=  pc0;
  end

  //=============================================================================
  // 4) GENERATE DEBUG SIGNALS 1
  //=============================================================================

  // Instruction fetch state
  //=========================
  reg [8*32-1:0] i_state1;

  always @(i_state_bin1) begin
    case(i_state_bin1)
      3'h0    : i_state1 =  "IRQ_FETCH";
      3'h1    : i_state1 =  "IRQ_DONE";
      3'h2    : i_state1 =  "DEC";
      3'h3    : i_state1 =  "EXT1";
      3'h4    : i_state1 =  "EXT2";
      3'h5    : i_state1 =  "IDLE";
      default : i_state1 =  "XXXXX";
    endcase
  end

  // Execution state
  //=========================

  reg [8*32-1:0] e_state1;

  always @(e_state_bin1) begin
    case(e_state_bin1)
      4'h2    : e_state1 =  "IRQ_0";
      4'h1    : e_state1 =  "IRQ_1";
      4'h0    : e_state1 =  "IRQ_2";
      4'h3    : e_state1 =  "IRQ_3";
      4'h4    : e_state1 =  "IRQ_4";
      4'h5    : e_state1 =  "SRC_AD";
      4'h6    : e_state1 =  "SRC_RD";
      4'h7    : e_state1 =  "SRC_WR";
      4'h8    : e_state1 =  "DST_AD";
      4'h9    : e_state1 =  "DST_RD";
      4'hA    : e_state1 =  "DST_WR";
      4'hB    : e_state1 =  "EXEC";
      4'hC    : e_state1 =  "JUMP";
      4'hD    : e_state1 =  "IDLE";
      default : e_state1 =  "xxxx";
    endcase
  end

  // Count instruction number & cycles
  //====================================

  reg [31:0]  inst_number1;
  always @(posedge mclk1 or posedge puc_rst1) begin
    if (puc_rst1)     inst_number1  <= 0;
    else if (decode1) inst_number1  <= inst_number1+1;
  end

  reg [31:0]  inst_cycle1;
  always @(posedge mclk1 or posedge puc_rst1) begin
    if (puc_rst1)     inst_cycle1 <= 0;
    else if (decode1) inst_cycle1 <= 0;
    else              inst_cycle1 <= inst_cycle1+1;
  end

  // Decode instruction
  //====================================

  // Buffer opcode1
  reg [15:0]  opcode1;
  always @(posedge mclk1 or posedge puc_rst1) begin
    if (puc_rst1)     opcode1  <= 0;
    else if (decode1) opcode1  <= ir1;
  end

  // Interrupts
  reg irq1;
  always @(posedge mclk1 or posedge puc_rst1) begin
    if (puc_rst1)     irq1     <= 1'b1;
    else if (decode1) irq1     <= irq_detect0;
  end

  // Instruction type
  reg [8*32-1:0] inst_type1;
  always @(opcode1 or irq1) begin
    if (irq1)
      inst_type1 =  "IRQ";
    else
      case(opcode1[15:13])
        3'b000  : inst_type1 =  "SIG-OP";
        3'b001  : inst_type1 =  "JUMP";
        default : inst_type1 =  "TWO-OP";
      endcase
  end

  // Instructions name
  reg [8*32-1:0] inst_name1;
  always @(opcode1 or inst_type1 or irq_num1) begin
    if (inst_type1=="IRQ")
      case(irq_num1[3:0])
        4'b0000        : inst_name1 =  "IRQ 0";
        4'b0001        : inst_name1 =  "IRQ 1";
        4'b0010        : inst_name1 =  "IRQ 2";
        4'b0011        : inst_name1 =  "IRQ 3";
        4'b0100        : inst_name1 =  "IRQ 4";
        4'b0101        : inst_name1 =  "IRQ 5";
        4'b0110        : inst_name1 =  "IRQ 6";
        4'b0111        : inst_name1 =  "IRQ 7";
        4'b1000        : inst_name1 =  "IRQ 8";
        4'b1001        : inst_name1 =  "IRQ 9";
        4'b1010        : inst_name1 =  "IRQ 10";
        4'b1011        : inst_name1 =  "IRQ 11";
        4'b1100        : inst_name1 =  "IRQ 12";
        4'b1101        : inst_name1 =  "IRQ 13";
        4'b1110        : inst_name1 =  "NMI";
        default        : inst_name1 =  "RESET";
      endcase
    else if (inst_type1=="SIG-OP")
      case(opcode1[15:7])
        9'b000100_000  : inst_name1 =  "RRC";
        9'b000100_001  : inst_name1 =  "SWPB";
        9'b000100_010  : inst_name1 =  "RRA";
        9'b000100_011  : inst_name1 =  "SXT";
        9'b000100_100  : inst_name1 =  "PUSH";
        9'b000100_101  : inst_name1 =  "CALL";
        9'b000100_110  : inst_name1 =  "RETI";
        default        : inst_name1 =  "xxxx";
      endcase
    else if (inst_type1=="JUMP")
      case(opcode1[15:10])
        6'b001_000     : inst_name1 =  "JNE";
        6'b001_001     : inst_name1 =  "JEQ";
        6'b001_010     : inst_name1 =  "JNC";
        6'b001_011     : inst_name1 =  "JC";
        6'b001_100     : inst_name1 =  "JN";
        6'b001_101     : inst_name1 =  "JGE";
        6'b001_110     : inst_name1 =  "JL";
        6'b001_111     : inst_name1 =  "JMP";
        default        : inst_name1 =  "xxxx";
      endcase
    else if (inst_type1=="TWO-OP")
      case(opcode1[15:12])
        4'b0100        : inst_name1 =  "MOV";
        4'b0101        : inst_name1 =  "ADD";
        4'b0110        : inst_name1 =  "ADDC";
        4'b0111        : inst_name1 =  "SUBC";
        4'b1000        : inst_name1 =  "SUB";
        4'b1001        : inst_name1 =  "CMP";
        4'b1010        : inst_name1 =  "DADD";
        4'b1011        : inst_name1 =  "BIT";
        4'b1100        : inst_name1 =  "BIC";
        4'b1101        : inst_name1 =  "BIS";
        4'b1110        : inst_name1 =  "XOR";
        4'b1111        : inst_name1 =  "AND";
        default        : inst_name1 =  "xxxx";
      endcase
  end

  // Instructions byte/word mode
  reg [8*32-1:0] inst_bw1;
  always @(opcode1 or inst_type1) begin
    if (inst_type1=="IRQ")
      inst_bw1 =  "";
    else if (inst_type1=="SIG-OP")
      inst_bw1 =  opcode1[6] ? ".B" : "";
    else if (inst_type1=="JUMP")
      inst_bw1 =  "";
    else if (inst_type1=="TWO-OP")
      inst_bw1 =  opcode1[6] ? ".B" : "";
  end

  // Source register
  reg [8*32-1:0] inst_src1;
  wire     [3:0] src_reg1 = (inst_type1=="SIG-OP") ? opcode1[3:0] : opcode1[11:8];

  always @(src_reg1 or inst_type1) begin
    if (inst_type1=="IRQ")
      inst_src1 =  "";
    else if (inst_type1=="JUMP")
      inst_src1 =  "";
    else if ((inst_type1=="SIG-OP") || (inst_type1=="TWO-OP"))
      case(src_reg1)
        4'b0000 : inst_src1 =  "r0";
        4'b0001 : inst_src1 =  "r1";
        4'b0010 : inst_src1 =  "r2";
        4'b0011 : inst_src1 =  "r3";
        4'b0100 : inst_src1 =  "r4";
        4'b0101 : inst_src1 =  "r5";
        4'b0110 : inst_src1 =  "r6";
        4'b0111 : inst_src1 =  "r7";
        4'b1000 : inst_src1 =  "r8";
        4'b1001 : inst_src1 =  "r9";
        4'b1010 : inst_src1 =  "r10";
        4'b1011 : inst_src1 =  "r11";
        4'b1100 : inst_src1 =  "r12";
        4'b1101 : inst_src1 =  "r13";
        4'b1110 : inst_src1 =  "r14";
        default : inst_src1 =  "r15";
      endcase
  end

  // Destination register
  reg [8*32-1:0] inst_dst1;
  always @(opcode1 or inst_type1) begin
    if (inst_type1=="IRQ")
      inst_dst1 =  "";
    else if (inst_type1=="SIG-OP")
      inst_dst1 =  "";
    else if (inst_type1=="JUMP")
      inst_dst1 =  "";
    else if (inst_type1=="TWO-OP")
      case(opcode1[3:0])
        4'b0000 : inst_dst1 =  "r0";
        4'b0001 : inst_dst1 =  "r1";
        4'b0010 : inst_dst1 =  "r2";
        4'b0011 : inst_dst1 =  "r3";
        4'b0100 : inst_dst1 =  "r4";
        4'b0101 : inst_dst1 =  "r5";
        4'b0110 : inst_dst1 =  "r6";
        4'b0111 : inst_dst1 =  "r7";
        4'b1000 : inst_dst1 =  "r8";
        4'b1001 : inst_dst1 =  "r9";
        4'b1010 : inst_dst1 =  "r10";
        4'b1011 : inst_dst1 =  "r11";
        4'b1100 : inst_dst1 =  "r12";
        4'b1101 : inst_dst1 =  "r13";
        4'b1110 : inst_dst1 =  "r14";
        default : inst_dst1 =  "r15";
      endcase
  end

  // Source Addressing mode
  reg [8*32-1:0] inst_as1;
  always @(inst_type1 or src_reg1 or opcode1 or inst_src1) begin
    if (inst_type1=="IRQ")
      inst_as1 =  "";
    else if (inst_type1=="JUMP")
      inst_as1 =  "";
    else if (src_reg1==4'h3) // Addressing mode using R3
      case (opcode1[5:4])
        2'b11  : inst_as1 =  "#-1";
        2'b10  : inst_as1 =  "#2";
        2'b01  : inst_as1 =  "#1";
        default: inst_as1 =  "#0";
      endcase
    else if (src_reg1==4'h2) // Addressing mode using R2
      case (opcode1[5:4])
        2'b11  : inst_as1 =  "#8";
        2'b10  : inst_as1 =  "#4";
        2'b01  : inst_as1 =  "&EDE";
        default: inst_as1 =  inst_src1;
      endcase
    else if (src_reg1==4'h0) // Addressing mode using R0
      case (opcode1[5:4])
        2'b11  : inst_as1 =  "#N";
        2'b10  : inst_as1 =  myFormat("@", inst_src1, 0);
        2'b01  : inst_as1 =  "EDE";
        default: inst_as1 =  inst_src1;
      endcase
    else                    // General Addressing mode
      case (opcode1[5:4])
        2'b11  : begin
          inst_as1 =  myFormat("@", inst_src1, 0);
          inst_as1 =  myFormat(inst_as1, "+", 0);
        end
        2'b10  : inst_as1 =  myFormat("@", inst_src1, 0);
        2'b01  : begin
          inst_as1 =  myFormat("x(", inst_src1, 0);
          inst_as1 =  myFormat(inst_as1, ")", 0);
        end
        default: inst_as1 =  inst_src1;
      endcase
  end

  // Destination Addressing mode
  reg [8*32-1:0] inst_ad1;
  always @(opcode1 or inst_type1 or inst_dst1) begin
    if (inst_type1!="TWO-OP")
      inst_ad1 =  "";
    else if (opcode1[3:0]==4'h2)   // Addressing mode using R2
      case (opcode1[7])
        1'b1   : inst_ad1 =  "&EDE";
        default: inst_ad1 =  inst_dst1;
      endcase
    else if (opcode1[3:0]==4'h0)   // Addressing mode using R0
      case (opcode1[7])
        2'b1   : inst_ad1 =  "EDE";
        default: inst_ad1 =  inst_dst1;
      endcase
    else                          // General Addressing mode
      case (opcode1[7])
        2'b1   : begin
          inst_ad1 =  myFormat("x(", inst_dst1, 0);
          inst_ad1 =  myFormat(inst_ad1, ")", 0);
        end
        default: inst_ad1 =  inst_dst1;
      endcase
  end

  // Currently executed instruction
  //================================

  wire [8*32-1:0] inst_short1 = inst_name1;

  reg  [8*32-1:0] inst_full1;
  always @(inst_type1 or inst_name1 or inst_bw1 or inst_as1 or inst_ad1) begin
    inst_full1   = myFormat(inst_name1, inst_bw1, 0);
    inst_full1   = myFormat(inst_full1, inst_as1, 1);
    if (inst_type1=="TWO-OP")
      inst_full1 = myFormat(inst_full1, ",",     0);
    inst_full1   = myFormat(inst_full1, inst_ad1, 1);
    if (opcode1==16'h4303)
      inst_full1 = "NOP";
    if (opcode1==`DBG_SWBRK_OP)
      inst_full1 = "SBREAK";
  end


  // Instruction program counter
  //================================

  reg  [15:0] inst_pc1;
  always @(posedge mclk1 or posedge puc_rst1) begin
    if (puc_rst1)     inst_pc1  <=  16'h0000;
    else if (decode1) inst_pc1  <=  pc1;
  end
endmodule // msp_debug

