#!/bin/bash
iverilog *.v -y . -s testbench -o a.out && stdbuf -oL -eL vvp -n ./a.out
