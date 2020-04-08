--============================================================================--
--==                                          __ _      _     _             ==--
--==                                         / _(_)    | |   | |            ==--
--==              __ _ _   _  ___  ___ _ __ | |_ _  ___| | __| |            ==--
--==             / _` | | | |/ _ \/ _ \ '_ \|  _| |/ _ \ |/ _` |            ==--
--==            | (_| | |_| |  __/  __/ | | | | | |  __/ | (_| |            ==--
--==             \__, |\__,_|\___|\___|_| |_|_| |_|\___|_|\__,_|            ==--
--==                | |                                                     ==--
--==                |_|                                                     ==--
--==                                                                        ==--
--==                                                                        ==--
--==            MSP430 CPU                                                  ==--
--==            Processing Unit                                             ==--
--==                                                                        ==--
--============================================================================--

-- Copyright (c) 2015-2016 by the author(s)
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--
-- =============================================================================
-- Author(s):
--   Francisco Javier Reina Campo <frareicam@gmail.com>
--

library IEEE;
use IEEE.STD_LOGIC_1164 .all;
use IEEE.NUMERIC_STD .all;
use WORK.MSP430_PACK .all;

entity MSP430_MPSoC is
  port (
    --SoC 0

    --CORE 0
    -- CPU registers
    omsp00_r0  : out std_logic_vector(15 downto 0);
    omsp00_r1  : out std_logic_vector(15 downto 0);
    omsp00_r2  : out std_logic_vector(15 downto 0);
    omsp00_r3  : out std_logic_vector(15 downto 0);
    omsp00_r4  : out std_logic_vector(15 downto 0);
    omsp00_r5  : out std_logic_vector(15 downto 0);
    omsp00_r6  : out std_logic_vector(15 downto 0);
    omsp00_r7  : out std_logic_vector(15 downto 0);
    omsp00_r8  : out std_logic_vector(15 downto 0);
    omsp00_r9  : out std_logic_vector(15 downto 0);
    omsp00_r10 : out std_logic_vector(15 downto 0);
    omsp00_r11 : out std_logic_vector(15 downto 0);
    omsp00_r12 : out std_logic_vector(15 downto 0);
    omsp00_r13 : out std_logic_vector(15 downto 0);
    omsp00_r14 : out std_logic_vector(15 downto 0);
    omsp00_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp00_dbg_en  : out std_logic;
    omsp00_dbg_clk : out std_logic;
    omsp00_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp00_irq_detect : out std_logic;
    omsp00_nmi_pnd    : out std_logic;

    omsp00_i_state : out std_logic_vector(2 downto 0);
    omsp00_e_state : out std_logic_vector(3 downto 0);
    omsp00_decode  : out std_logic;
    omsp00_ir      : out std_logic_vector(15 downto 0);
    omsp00_irq_num : out std_logic_vector(5 downto 0);
    omsp00_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp00_mclk    : out std_logic;
    omsp00_puc_rst : out std_logic;

    --CORE 1
    -- CPU registers
    omsp01_r0  : out std_logic_vector(15 downto 0);
    omsp01_r1  : out std_logic_vector(15 downto 0);
    omsp01_r2  : out std_logic_vector(15 downto 0);
    omsp01_r3  : out std_logic_vector(15 downto 0);
    omsp01_r4  : out std_logic_vector(15 downto 0);
    omsp01_r5  : out std_logic_vector(15 downto 0);
    omsp01_r6  : out std_logic_vector(15 downto 0);
    omsp01_r7  : out std_logic_vector(15 downto 0);
    omsp01_r8  : out std_logic_vector(15 downto 0);
    omsp01_r9  : out std_logic_vector(15 downto 0);
    omsp01_r10 : out std_logic_vector(15 downto 0);
    omsp01_r11 : out std_logic_vector(15 downto 0);
    omsp01_r12 : out std_logic_vector(15 downto 0);
    omsp01_r13 : out std_logic_vector(15 downto 0);
    omsp01_r14 : out std_logic_vector(15 downto 0);
    omsp01_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp01_dbg_en  : out std_logic;
    omsp01_dbg_clk : out std_logic;
    omsp01_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp01_irq_detect : out std_logic;
    omsp01_nmi_pnd    : out std_logic;

    omsp01_i_state : out std_logic_vector(2 downto 0);
    omsp01_e_state : out std_logic_vector(3 downto 0);
    omsp01_decode  : out std_logic;
    omsp01_ir      : out std_logic_vector(15 downto 0);
    omsp01_irq_num : out std_logic_vector(5 downto 0);
    omsp01_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp01_mclk    : out std_logic;
    omsp01_puc_rst : out std_logic;

    -- Data memory
    omsp00_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp00_dmem_cen_sp  : out std_logic;
    omsp00_dmem_cen_dp  : out std_logic;
    omsp00_dmem_din     : out std_logic_vector(15 downto 0);
    omsp00_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp00_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp00_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    omsp01_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp01_dmem_cen_sp  : out std_logic;
    omsp01_dmem_cen_dp  : out std_logic;
    omsp01_dmem_din     : out std_logic_vector(15 downto 0);
    omsp01_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp01_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp01_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    -- Program memory
    omsp00_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp00_pmem_cen  : out std_logic;
    omsp00_pmem_din  : out std_logic_vector(15 downto 0);
    omsp00_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp00_pmem_dout : in  std_logic_vector(15 downto 0);

    omsp01_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp01_pmem_cen  : out std_logic;
    omsp01_pmem_din  : out std_logic_vector(15 downto 0);
    omsp01_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp01_pmem_dout : in  std_logic_vector(15 downto 0);

    dco_clk0 : out std_logic;

    ------------------------------------------------
    -- User LEDs    
    ------------------------------------------------
    GPIO_LED01 : out std_logic;
    GPIO_LED02 : out std_logic;
    GPIO_LED03 : out std_logic;
    GPIO_LED04 : out std_logic;

    ------------------------------------------------
    -- Silicon Labs CP2102 USB-to-UART Bridge Chip
    ------------------------------------------------
    USB_RS232_RXD0 : in  std_logic;
    USB_RS232_TXD0 : out std_logic;

    --SoC 1

    --CORE 0
    -- CPU registers
    omsp10_r0  : out std_logic_vector(15 downto 0);
    omsp10_r1  : out std_logic_vector(15 downto 0);
    omsp10_r2  : out std_logic_vector(15 downto 0);
    omsp10_r3  : out std_logic_vector(15 downto 0);
    omsp10_r4  : out std_logic_vector(15 downto 0);
    omsp10_r5  : out std_logic_vector(15 downto 0);
    omsp10_r6  : out std_logic_vector(15 downto 0);
    omsp10_r7  : out std_logic_vector(15 downto 0);
    omsp10_r8  : out std_logic_vector(15 downto 0);
    omsp10_r9  : out std_logic_vector(15 downto 0);
    omsp10_r10 : out std_logic_vector(15 downto 0);
    omsp10_r11 : out std_logic_vector(15 downto 0);
    omsp10_r12 : out std_logic_vector(15 downto 0);
    omsp10_r13 : out std_logic_vector(15 downto 0);
    omsp10_r14 : out std_logic_vector(15 downto 0);
    omsp10_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp10_dbg_en  : out std_logic;
    omsp10_dbg_clk : out std_logic;
    omsp10_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp10_irq_detect : out std_logic;
    omsp10_nmi_pnd    : out std_logic;

    omsp10_i_state : out std_logic_vector(2 downto 0);
    omsp10_e_state : out std_logic_vector(3 downto 0);
    omsp10_decode  : out std_logic;
    omsp10_ir      : out std_logic_vector(15 downto 0);
    omsp10_irq_num : out std_logic_vector(5 downto 0);
    omsp10_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp10_mclk    : out std_logic;
    omsp10_puc_rst : out std_logic;

    --CORE 1
    -- CPU registers
    omsp11_r0  : out std_logic_vector(15 downto 0);
    omsp11_r1  : out std_logic_vector(15 downto 0);
    omsp11_r2  : out std_logic_vector(15 downto 0);
    omsp11_r3  : out std_logic_vector(15 downto 0);
    omsp11_r4  : out std_logic_vector(15 downto 0);
    omsp11_r5  : out std_logic_vector(15 downto 0);
    omsp11_r6  : out std_logic_vector(15 downto 0);
    omsp11_r7  : out std_logic_vector(15 downto 0);
    omsp11_r8  : out std_logic_vector(15 downto 0);
    omsp11_r9  : out std_logic_vector(15 downto 0);
    omsp11_r10 : out std_logic_vector(15 downto 0);
    omsp11_r11 : out std_logic_vector(15 downto 0);
    omsp11_r12 : out std_logic_vector(15 downto 0);
    omsp11_r13 : out std_logic_vector(15 downto 0);
    omsp11_r14 : out std_logic_vector(15 downto 0);
    omsp11_r15 : out std_logic_vector(15 downto 0);

    -- Debug interface
    omsp11_dbg_en  : out std_logic;
    omsp11_dbg_clk : out std_logic;
    omsp11_dbg_rst : out std_logic;

    -- Interrupt detection
    omsp11_irq_detect : out std_logic;
    omsp11_nmi_pnd    : out std_logic;

    omsp11_i_state : out std_logic_vector(2 downto 0);
    omsp11_e_state : out std_logic_vector(3 downto 0);
    omsp11_decode  : out std_logic;
    omsp11_ir      : out std_logic_vector(15 downto 0);
    omsp11_irq_num : out std_logic_vector(5 downto 0);
    omsp11_pc      : out std_logic_vector(15 downto 0);

    -- CPU internals
    omsp11_mclk    : out std_logic;
    omsp11_puc_rst : out std_logic;

    -- Data memory
    omsp10_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp10_dmem_cen_sp  : out std_logic;
    omsp10_dmem_cen_dp  : out std_logic;
    omsp10_dmem_din     : out std_logic_vector(15 downto 0);
    omsp10_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp10_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp10_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    omsp11_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
    omsp11_dmem_cen_sp  : out std_logic;
    omsp11_dmem_cen_dp  : out std_logic;
    omsp11_dmem_din     : out std_logic_vector(15 downto 0);
    omsp11_dmem_wen     : out std_logic_vector(1 downto 0);
    omsp11_dmem_dout_sp : in  std_logic_vector(15 downto 0);
    omsp11_dmem_dout_dp : in  std_logic_vector(15 downto 0);

    -- Program memory
    omsp10_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp10_pmem_cen  : out std_logic;
    omsp10_pmem_din  : out std_logic_vector(15 downto 0);
    omsp10_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp10_pmem_dout : in  std_logic_vector(15 downto 0);

    omsp11_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
    omsp11_pmem_cen  : out std_logic;
    omsp11_pmem_din  : out std_logic_vector(15 downto 0);
    omsp11_pmem_wen  : out std_logic_vector(1 downto 0);
    omsp11_pmem_dout : in  std_logic_vector(15 downto 0);

    dco_clk1 : out std_logic;

    ------------------------------------------------
    -- User LEDs    
    ------------------------------------------------
    GPIO_LED11 : out std_logic;
    GPIO_LED12 : out std_logic;
    GPIO_LED13 : out std_logic;
    GPIO_LED14 : out std_logic;

    ------------------------------------------------
    -- Silicon Labs CP2102 USB-to-UART Bridge Chip
    ------------------------------------------------
    USB_RS232_RXD1 : in  std_logic;
    USB_RS232_TXD1 : out std_logic;

    ------------------------------------------------
    -- User Reset Push Button
    ------------------------------------------------
    USER_RESET : in std_logic;

    ------------------------------------------------
    -- TI CDCE913 Triple-Output PLL Clock Chip
    --   Y1: 40 MHz, USER_CLOCK can be used as
    --              external configuration clock
    --   Y2: 66.667 MHz
    --   Y3: 100 MHz 
    ------------------------------------------------
    USER_CLOCK : in std_logic;

    ------------------------------------------------
    -- User DIP Switch x4
    ------------------------------------------------
    GPIO_DIP1 : in std_logic;
    GPIO_DIP2 : in std_logic;
    GPIO_DIP3 : in std_logic;
    GPIO_DIP4 : in std_logic;

    ------------------------------------------------
    -- Peripheral Modules (PMODs) and GPIO
    --     https://www.digilentinc.com/PMODs
    ------------------------------------------------

    -- Connector J5
    PMOD1_P3 : inout std_logic;
    PMOD1_P4 : in    std_logic);
end MSP430_MPSoC;

architecture RTL of MSP430_MPSoC is
  component MSP430_SoC
    port (
      --CORE 0
      -- CPU registers
      omsp0_r0  : out std_logic_vector(15 downto 0);
      omsp0_r1  : out std_logic_vector(15 downto 0);
      omsp0_r2  : out std_logic_vector(15 downto 0);
      omsp0_r3  : out std_logic_vector(15 downto 0);
      omsp0_r4  : out std_logic_vector(15 downto 0);
      omsp0_r5  : out std_logic_vector(15 downto 0);
      omsp0_r6  : out std_logic_vector(15 downto 0);
      omsp0_r7  : out std_logic_vector(15 downto 0);
      omsp0_r8  : out std_logic_vector(15 downto 0);
      omsp0_r9  : out std_logic_vector(15 downto 0);
      omsp0_r10 : out std_logic_vector(15 downto 0);
      omsp0_r11 : out std_logic_vector(15 downto 0);
      omsp0_r12 : out std_logic_vector(15 downto 0);
      omsp0_r13 : out std_logic_vector(15 downto 0);
      omsp0_r14 : out std_logic_vector(15 downto 0);
      omsp0_r15 : out std_logic_vector(15 downto 0);

      -- Debug interface
      omsp0_dbg_en  : out std_logic;
      omsp0_dbg_clk : out std_logic;
      omsp0_dbg_rst : out std_logic;

      -- Interrupt detection
      omsp0_irq_detect : out std_logic;
      omsp0_nmi_pnd    : out std_logic;

      omsp0_i_state : out std_logic_vector(2 downto 0);
      omsp0_e_state : out std_logic_vector(3 downto 0);
      omsp0_decode  : out std_logic;
      omsp0_ir      : out std_logic_vector(15 downto 0);
      omsp0_irq_num : out std_logic_vector(5 downto 0);
      omsp0_pc      : out std_logic_vector(15 downto 0);

      -- CPU internals
      omsp0_mclk    : out std_logic;
      omsp0_puc_rst : out std_logic;

      --CORE 1
      -- CPU registers
      omsp1_r0  : out std_logic_vector(15 downto 0);
      omsp1_r1  : out std_logic_vector(15 downto 0);
      omsp1_r2  : out std_logic_vector(15 downto 0);
      omsp1_r3  : out std_logic_vector(15 downto 0);
      omsp1_r4  : out std_logic_vector(15 downto 0);
      omsp1_r5  : out std_logic_vector(15 downto 0);
      omsp1_r6  : out std_logic_vector(15 downto 0);
      omsp1_r7  : out std_logic_vector(15 downto 0);
      omsp1_r8  : out std_logic_vector(15 downto 0);
      omsp1_r9  : out std_logic_vector(15 downto 0);
      omsp1_r10 : out std_logic_vector(15 downto 0);
      omsp1_r11 : out std_logic_vector(15 downto 0);
      omsp1_r12 : out std_logic_vector(15 downto 0);
      omsp1_r13 : out std_logic_vector(15 downto 0);
      omsp1_r14 : out std_logic_vector(15 downto 0);
      omsp1_r15 : out std_logic_vector(15 downto 0);

      -- Debug interface
      omsp1_dbg_en  : out std_logic;
      omsp1_dbg_clk : out std_logic;
      omsp1_dbg_rst : out std_logic;

      -- Interrupt detection
      omsp1_irq_detect : out std_logic;
      omsp1_nmi_pnd    : out std_logic;

      omsp1_i_state : out std_logic_vector(2 downto 0);
      omsp1_e_state : out std_logic_vector(3 downto 0);
      omsp1_decode  : out std_logic;
      omsp1_ir      : out std_logic_vector(15 downto 0);
      omsp1_irq_num : out std_logic_vector(5 downto 0);
      omsp1_pc      : out std_logic_vector(15 downto 0);

      -- CPU internals
      omsp1_mclk    : out std_logic;
      omsp1_puc_rst : out std_logic;

      -- Data memory
      omsp0_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
      omsp0_dmem_cen_sp  : out std_logic;
      omsp0_dmem_cen_dp  : out std_logic;
      omsp0_dmem_din     : out std_logic_vector(15 downto 0);
      omsp0_dmem_wen     : out std_logic_vector(1 downto 0);
      omsp0_dmem_dout_sp : in  std_logic_vector(15 downto 0);
      omsp0_dmem_dout_dp : in  std_logic_vector(15 downto 0);

      omsp1_dmem_addr    : out std_logic_vector(DMEM_MSB downto 0);
      omsp1_dmem_cen_sp  : out std_logic;
      omsp1_dmem_cen_dp  : out std_logic;
      omsp1_dmem_din     : out std_logic_vector(15 downto 0);
      omsp1_dmem_wen     : out std_logic_vector(1 downto 0);
      omsp1_dmem_dout_sp : in  std_logic_vector(15 downto 0);
      omsp1_dmem_dout_dp : in  std_logic_vector(15 downto 0);

      -- Program memory
      omsp0_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
      omsp0_pmem_cen  : out std_logic;
      omsp0_pmem_din  : out std_logic_vector(15 downto 0);
      omsp0_pmem_wen  : out std_logic_vector(1 downto 0);
      omsp0_pmem_dout : in  std_logic_vector(15 downto 0);

      omsp1_pmem_addr : out std_logic_vector(PMEM_MSB downto 0);
      omsp1_pmem_cen  : out std_logic;
      omsp1_pmem_din  : out std_logic_vector(15 downto 0);
      omsp1_pmem_wen  : out std_logic_vector(1 downto 0);
      omsp1_pmem_dout : in  std_logic_vector(15 downto 0);

      dco_clk : out std_logic;

      ------------------------------------------------
      -- User Reset Push Button
      ------------------------------------------------
      USER_RESET : in std_logic;

      ------------------------------------------------
      -- TI CDCE913 Triple-Output PLL Clock Chip
      --   Y1: 40 MHz; USER_CLOCK can be used as
      --              external configuration clock
      --   Y2: 66.667 MHz
      --   Y3: 100 MHz 
      ------------------------------------------------
      USER_CLOCK : in std_logic;

      ------------------------------------------------
      -- User DIP Switch x4
      ------------------------------------------------
      GPIO_DIP1 : in std_logic;
      GPIO_DIP2 : in std_logic;
      GPIO_DIP3 : in std_logic;
      GPIO_DIP4 : in std_logic;

      ------------------------------------------------
      -- User LEDs    
      ------------------------------------------------
      GPIO_LED1 : out std_logic;
      GPIO_LED2 : out std_logic;
      GPIO_LED3 : out std_logic;
      GPIO_LED4 : out std_logic;

      ------------------------------------------------
      -- Silicon Labs CP2102 USB-to-UART Bridge Chip
      ------------------------------------------------
      USB_RS232_RXD : in  std_logic;
      USB_RS232_TXD : out std_logic;

      ------------------------------------------------
      -- Peripheral Modules (PMODs) and GPIO
      --     https://www.digilentinc.com/PMODs
      ------------------------------------------------

      -- Connector J5
      PMOD1_P3 : inout std_logic;
      PMOD1_P4 : in    std_logic);
  end component MSP430_SoC;

begin
  --=============================================================================
  -- 1)  OPENMSP430 SYSTEM on CHIP 0
  --=============================================================================
  MSP430_SoC_0 : MSP430_SoC
    port map (
      -- CORE 0
      -- CPU registers
      omsp0_r0  => omsp00_r0,
      omsp0_r1  => omsp00_r1,
      omsp0_r2  => omsp00_r2,
      omsp0_r3  => omsp00_r3,
      omsp0_r4  => omsp00_r4,
      omsp0_r5  => omsp00_r5,
      omsp0_r6  => omsp00_r6,
      omsp0_r7  => omsp00_r7,
      omsp0_r8  => omsp00_r8,
      omsp0_r9  => omsp00_r9,
      omsp0_r10 => omsp00_r10,
      omsp0_r11 => omsp00_r11,
      omsp0_r12 => omsp00_r12,
      omsp0_r13 => omsp00_r13,
      omsp0_r14 => omsp00_r14,
      omsp0_r15 => omsp00_r15,

      -- Debug interface
      omsp0_dbg_en  => omsp00_dbg_en,
      omsp0_dbg_clk => omsp00_dbg_clk,
      omsp0_dbg_rst => omsp00_dbg_rst,

      -- Interrupt detection
      omsp0_irq_detect => omsp00_irq_detect,
      omsp0_nmi_pnd    => omsp00_nmi_pnd,

      omsp0_i_state => omsp00_i_state,
      omsp0_e_state => omsp00_e_state,
      omsp0_decode  => omsp00_decode,
      omsp0_ir      => omsp00_ir,
      omsp0_irq_num => omsp00_irq_num,
      omsp0_pc      => omsp00_pc,

      -- CPU internals
      omsp0_mclk    => omsp00_mclk,
      omsp0_puc_rst => omsp00_puc_rst,

      -- CORE 1
      -- CPU registers
      omsp1_r0  => omsp01_r0,
      omsp1_r1  => omsp01_r1,
      omsp1_r2  => omsp01_r2,
      omsp1_r3  => omsp01_r3,
      omsp1_r4  => omsp01_r4,
      omsp1_r5  => omsp01_r5,
      omsp1_r6  => omsp01_r6,
      omsp1_r7  => omsp01_r7,
      omsp1_r8  => omsp01_r8,
      omsp1_r9  => omsp01_r9,
      omsp1_r10 => omsp01_r10,
      omsp1_r11 => omsp01_r11,
      omsp1_r12 => omsp01_r12,
      omsp1_r13 => omsp01_r13,
      omsp1_r14 => omsp01_r14,
      omsp1_r15 => omsp01_r15,

      -- Debug interface
      omsp1_dbg_en  => omsp01_dbg_en,
      omsp1_dbg_clk => omsp01_dbg_clk,
      omsp1_dbg_rst => omsp01_dbg_rst,

      -- Interrupt detection
      omsp1_irq_detect => omsp01_irq_detect,
      omsp1_nmi_pnd    => omsp01_nmi_pnd,

      omsp1_i_state => omsp01_i_state,
      omsp1_e_state => omsp01_e_state,
      omsp1_decode  => omsp01_decode,
      omsp1_ir      => omsp01_ir,
      omsp1_irq_num => omsp01_irq_num,
      omsp1_pc      => omsp01_pc,

      -- CPU internals
      omsp1_mclk    => omsp01_mclk,
      omsp1_puc_rst => omsp01_puc_rst,

      -- Data memory
      omsp0_dmem_addr    => omsp00_dmem_addr,
      omsp0_dmem_cen_sp  => omsp00_dmem_cen_sp,
      omsp0_dmem_cen_dp  => omsp00_dmem_cen_dp,
      omsp0_dmem_din     => omsp00_dmem_din,
      omsp0_dmem_wen     => omsp00_dmem_wen,
      omsp0_dmem_dout_sp => omsp00_dmem_dout_sp,
      omsp0_dmem_dout_dp => omsp00_dmem_dout_dp,

      omsp1_dmem_addr    => omsp01_dmem_addr,
      omsp1_dmem_cen_sp  => omsp01_dmem_cen_sp,
      omsp1_dmem_cen_dp  => omsp01_dmem_cen_dp,
      omsp1_dmem_din     => omsp01_dmem_din,
      omsp1_dmem_wen     => omsp01_dmem_wen,
      omsp1_dmem_dout_sp => omsp01_dmem_dout_sp,
      omsp1_dmem_dout_dp => omsp01_dmem_dout_dp,

      -- Program memory
      omsp0_pmem_addr => omsp00_pmem_addr,
      omsp0_pmem_cen  => omsp00_pmem_cen,
      omsp0_pmem_din  => omsp00_pmem_din,
      omsp0_pmem_wen  => omsp00_pmem_wen,
      omsp0_pmem_dout => omsp00_pmem_dout,

      omsp1_pmem_addr => omsp01_pmem_addr,
      omsp1_pmem_cen  => omsp01_pmem_cen,
      omsp1_pmem_din  => omsp01_pmem_din,
      omsp1_pmem_wen  => omsp01_pmem_wen,
      omsp1_pmem_dout => omsp01_pmem_dout,

      dco_clk => dco_clk0,

      ------------------------------------------------
      -- User Reset Push Button
      ------------------------------------------------
      USER_RESET => USER_RESET,

      ------------------------------------------------
      -- TI CDCE913 Triple-Output PLL Clock Chip
      --   Y1: 40 MHz, USER_CLOCK can be used as
      --              external configuration clock
      --   Y2: 66.667 MHz
      --   Y3: 100 MHz 
      ------------------------------------------------
      USER_CLOCK => USER_CLOCK,

      ------------------------------------------------
      -- User DIP Switch x4
      ------------------------------------------------
      GPIO_DIP1 => GPIO_DIP1,
      GPIO_DIP2 => GPIO_DIP2,
      GPIO_DIP3 => GPIO_DIP3,
      GPIO_DIP4 => GPIO_DIP4,

      ------------------------------------------------
      -- User LEDs                      
      ------------------------------------------------
      GPIO_LED1 => GPIO_LED01,
      GPIO_LED2 => GPIO_LED02,
      GPIO_LED3 => GPIO_LED03,
      GPIO_LED4 => GPIO_LED04,

      ------------------------------------------------
      -- Silicon Labs CP2102 USB-to-UART Bridge Chip
      ------------------------------------------------
      USB_RS232_RXD => USB_RS232_RXD0,
      USB_RS232_TXD => USB_RS232_TXD0,

      ------------------------------------------------
      -- Peripheral Modules (PMODs) and GPIO
      --     https://www.digilentinc.com/PMODs
      ------------------------------------------------

      -- Connector J5
      PMOD1_P3 => PMOD1_P3,             -- Serial Debug Interface TX
      PMOD1_P4 => PMOD1_P4              -- Serial Debug Interface RX
      );

  --=============================================================================
  -- 2)  OPENMSP430 OPENMSP430 SYSTEM on CHIP 1
  --=============================================================================
  MSP430_SoC_1 : MSP430_SoC
    port map (
      -- CORE 0
      -- CPU registers
      omsp0_r0  => omsp10_r0,
      omsp0_r1  => omsp10_r1,
      omsp0_r2  => omsp10_r2,
      omsp0_r3  => omsp10_r3,
      omsp0_r4  => omsp10_r4,
      omsp0_r5  => omsp10_r5,
      omsp0_r6  => omsp10_r6,
      omsp0_r7  => omsp10_r7,
      omsp0_r8  => omsp10_r8,
      omsp0_r9  => omsp10_r9,
      omsp0_r10 => omsp10_r10,
      omsp0_r11 => omsp10_r11,
      omsp0_r12 => omsp10_r12,
      omsp0_r13 => omsp10_r13,
      omsp0_r14 => omsp10_r14,
      omsp0_r15 => omsp10_r15,

      -- Debug interface
      omsp0_dbg_en  => omsp10_dbg_en,
      omsp0_dbg_clk => omsp10_dbg_clk,
      omsp0_dbg_rst => omsp10_dbg_rst,

      -- Interrupt detection
      omsp0_irq_detect => omsp10_irq_detect,
      omsp0_nmi_pnd    => omsp10_nmi_pnd,

      omsp0_i_state => omsp10_i_state,
      omsp0_e_state => omsp10_e_state,
      omsp0_decode  => omsp10_decode,
      omsp0_ir      => omsp10_ir,
      omsp0_irq_num => omsp10_irq_num,
      omsp0_pc      => omsp10_pc,

      -- CPU internals
      omsp0_mclk    => omsp10_mclk,
      omsp0_puc_rst => omsp10_puc_rst,

      -- CORE 1
      -- CPU registers
      omsp1_r0  => omsp11_r0,
      omsp1_r1  => omsp11_r1,
      omsp1_r2  => omsp11_r2,
      omsp1_r3  => omsp11_r3,
      omsp1_r4  => omsp11_r4,
      omsp1_r5  => omsp11_r5,
      omsp1_r6  => omsp11_r6,
      omsp1_r7  => omsp11_r7,
      omsp1_r8  => omsp11_r8,
      omsp1_r9  => omsp11_r9,
      omsp1_r10 => omsp11_r10,
      omsp1_r11 => omsp11_r11,
      omsp1_r12 => omsp11_r12,
      omsp1_r13 => omsp11_r13,
      omsp1_r14 => omsp11_r14,
      omsp1_r15 => omsp11_r15,

      -- Debug interface
      omsp1_dbg_en  => omsp11_dbg_en,
      omsp1_dbg_clk => omsp11_dbg_clk,
      omsp1_dbg_rst => omsp11_dbg_rst,

      -- Interrupt detection
      omsp1_irq_detect => omsp11_irq_detect,
      omsp1_nmi_pnd    => omsp11_nmi_pnd,

      omsp1_i_state => omsp11_i_state,
      omsp1_e_state => omsp11_e_state,
      omsp1_decode  => omsp11_decode,
      omsp1_ir      => omsp11_ir,
      omsp1_irq_num => omsp11_irq_num,
      omsp1_pc      => omsp11_pc,

      -- CPU internals
      omsp1_mclk    => omsp11_mclk,
      omsp1_puc_rst => omsp11_puc_rst,

      -- Data memory
      omsp0_dmem_addr    => omsp10_dmem_addr,
      omsp0_dmem_cen_sp  => omsp10_dmem_cen_sp,
      omsp0_dmem_cen_dp  => omsp10_dmem_cen_dp,
      omsp0_dmem_din     => omsp10_dmem_din,
      omsp0_dmem_wen     => omsp10_dmem_wen,
      omsp0_dmem_dout_sp => omsp10_dmem_dout_sp,
      omsp0_dmem_dout_dp => omsp10_dmem_dout_dp,

      omsp1_dmem_addr    => omsp11_dmem_addr,
      omsp1_dmem_cen_sp  => omsp11_dmem_cen_sp,
      omsp1_dmem_cen_dp  => omsp11_dmem_cen_dp,
      omsp1_dmem_din     => omsp11_dmem_din,
      omsp1_dmem_wen     => omsp11_dmem_wen,
      omsp1_dmem_dout_sp => omsp11_dmem_dout_sp,
      omsp1_dmem_dout_dp => omsp11_dmem_dout_dp,

      -- Program memory
      omsp0_pmem_addr => omsp10_pmem_addr,
      omsp0_pmem_cen  => omsp10_pmem_cen,
      omsp0_pmem_din  => omsp10_pmem_din,
      omsp0_pmem_wen  => omsp10_pmem_wen,
      omsp0_pmem_dout => omsp10_pmem_dout,

      omsp1_pmem_addr => omsp11_pmem_addr,
      omsp1_pmem_cen  => omsp11_pmem_cen,
      omsp1_pmem_din  => omsp11_pmem_din,
      omsp1_pmem_wen  => omsp11_pmem_wen,
      omsp1_pmem_dout => omsp11_pmem_dout,

      dco_clk => dco_clk1,

      ------------------------------------------------
      -- User Reset Push Button
      ------------------------------------------------
      USER_RESET => USER_RESET,

      ------------------------------------------------
      -- TI CDCE913 Triple-Output PLL Clock Chip
      --   Y1: 40 MHz, USER_CLOCK can be used as
      --              external configuration clock
      --   Y2: 66.667 MHz
      --   Y3: 100 MHz 
      ------------------------------------------------
      USER_CLOCK => USER_CLOCK,

      ------------------------------------------------
      -- User DIP Switch x4
      ------------------------------------------------
      GPIO_DIP1 => GPIO_DIP1,
      GPIO_DIP2 => GPIO_DIP2,
      GPIO_DIP3 => GPIO_DIP3,
      GPIO_DIP4 => GPIO_DIP4,

      ------------------------------------------------
      -- User LEDs                      
      ------------------------------------------------
      GPIO_LED1 => GPIO_LED11,
      GPIO_LED2 => GPIO_LED12,
      GPIO_LED3 => GPIO_LED13,
      GPIO_LED4 => GPIO_LED14,

      ------------------------------------------------
      -- Silicon Labs CP2102 USB-to-UART Bridge Chip
      ------------------------------------------------
      USB_RS232_RXD => USB_RS232_RXD1,
      USB_RS232_TXD => USB_RS232_TXD1,

      ------------------------------------------------
      -- Peripheral Modules (PMODs) and GPIO
      --     https://www.digilentinc.com/PMODs
      ------------------------------------------------

      -- Connector J5
      PMOD1_P3 => PMOD1_P3,  -- Serial Debug Interface TX
      PMOD1_P4 => PMOD1_P4); -- Serial Debug Interface RX
end RTL;
