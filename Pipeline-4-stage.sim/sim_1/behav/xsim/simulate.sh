#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2019.1 (64-bit)
#
# Filename    : simulate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for simulating the design by launching the simulator
#
# Generated by Vivado on Sat Oct 26 20:06:27 IST 2024
# SW Build 2552052 on Fri May 24 14:47:09 MDT 2019
#
# Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
#
# usage: simulate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xsim tb_controller_behav -key {Behavioral:sim_1:Functional:tb_controller} -tclbatch tb_controller.tcl -view /home/alphadelta1803/projects/RV32I-4Stage/waveforms/tb_controller.wcfg -log simulate.log"
xsim tb_controller_behav -key {Behavioral:sim_1:Functional:tb_controller} -tclbatch tb_controller.tcl -view /home/alphadelta1803/projects/RV32I-4Stage/waveforms/tb_controller.wcfg -log simulate.log

