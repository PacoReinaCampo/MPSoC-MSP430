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
//              MSP430 CPU                                                    //
//              Processing Unit                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/* Copyright (c) 2015-2016 by the author(s)
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
 *   Francisco Javier Reina Campo <frareicam@gmail.com>
 */

+incdir+../../../rtl/verilog/pkg/

//=============================================================================
// Testbench related
//=============================================================================

../../../bench/verilog/RAM_D1.v
../../../bench/verilog/RAM_D2.v
../../../bench/verilog/RAM_P2.v
../../../bench/verilog/glbl.v
../../../bench/verilog/msp_debug.v
../../../bench/verilog/RAM_DP.v
../../../bench/verilog/RAM_SP.v
../../../bench/verilog/tb_openMSP430.v


//=============================================================================
// MPSoC-MSP430
//=============================================================================



//=============================================================================
// SoC-MSP430
//=============================================================================

../../../soc/rtl/verilog/soc/MSP430_CORE0.v
../../../soc/rtl/verilog/soc/MSP430_CORE1.v
../../../soc/rtl/verilog/soc/MSP430_SoC.v
../../../soc/rtl/verilog/soc/io_cell.v

//=============================================================================
// PU-MSP430
//=============================================================================

../../../soc/pu/rtl/verilog/core/MSP430_CORE.v

../../../soc/pu/rtl/verilog/core/main/BCM.v
../../../soc/pu/rtl/verilog/core/main/DBG.v
../../../soc/pu/rtl/verilog/core/main/EXECUTION.v
../../../soc/pu/rtl/verilog/core/main/FRONTEND.v
../../../soc/pu/rtl/verilog/core/main/GPIO.v
../../../soc/pu/rtl/verilog/core/main/MEMORY.v
../../../soc/pu/rtl/verilog/core/main/MULTIPLIER.v
../../../soc/pu/rtl/verilog/core/main/SFR.v
../../../soc/pu/rtl/verilog/core/main/T_A.v
../../../soc/pu/rtl/verilog/core/main/T_WATCHDOG.v
../../../soc/pu/rtl/verilog/core/main/TEMPLATE_08.v
../../../soc/pu/rtl/verilog/core/main/TEMPLATE_16.v
../../../soc/pu/rtl/verilog/core/main/UART.v

../../../soc/pu/rtl/verilog/core/fuse/omsp_and_gate.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_clock_gate.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_clock_mux.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_scan_mux.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_sync_cell.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_sync_reset.v
../../../soc/pu/rtl/verilog/core/fuse/omsp_wakeup_cell.v

../../../soc/pu/rtl/verilog/core/omsp/omsp_alu.v
../../../soc/pu/rtl/verilog/core/omsp/omsp_dbg_hwbrk.v
../../../soc/pu/rtl/verilog/core/omsp/omsp_dbg_i2c.v
../../../soc/pu/rtl/verilog/core/omsp/omsp_dbg_uart.v
../../../soc/pu/rtl/verilog/core/omsp/omsp_register_file.v

