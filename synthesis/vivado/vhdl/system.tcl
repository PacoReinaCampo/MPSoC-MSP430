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
##              MPSoC-SPRAM CPU                                                  ##
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

read_vhdl -vhdl2008 ../../../rtl/vhdl/pkg/mpsoc_noc_pkg.vhd

read_vhdl -vhdl2008 ../../../rtl/vhdl/core/arb_rr.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/core/noc_buffer.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/core/noc_demux.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/core/noc_mux.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/core/noc_vchannel_mux.vhd

read_vhdl -vhdl2008 ../../../rtl/vhdl/router/noc_router_input.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/router/noc_router_lookup_slice.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/router/noc_router_lookup.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/router/noc_router_output.vhd
read_vhdl -vhdl2008 ../../../rtl/vhdl/router/noc_router.vhd

read_vhdl -vhdl2008 ../../../rtl/vhdl/topology/noc_mesh2d.vhd

read_vhdl -vhdl2008 mpsoc_noc_wrapper.vhd

read_xdc system.xdc

synth_design -part xc7z020-clg484-1 -top mpsoc_noc_wrapper

opt_design
place_design
route_design

report_utilization
report_timing

write_vhdl -force system.vhd
write_bitstream -force system.bit