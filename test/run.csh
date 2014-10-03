#! /bin/csh -f
vcs \
  -full64 \
  -sverilog \
  -debug_all \
  +incdir+../src \
  ../src/container_pkg.sv \
  test.sv
