# Test program for the m68882 FPU
# Malcolm Harrow, March 2024
#
# Make rosco_m68k example program for C
#
# Copyright (c) 2020-2022 Xark and contributors
# MIT LICENSE

ROSCO_M68K_DEFAULT_DIR=../rosco_m68k

ROSCO_M68K_DIR=${HOME}/rosco_m68k

ifndef ROSCO_M68K_DIR
$(info NOTE: ROSCO_M68K_DIR not set, using libs: ../rosco_m68k/code/software/libs)
ROSCO_M68K_DIR=$(ROSCO_M68K_DEFAULT_DIR)
else
$(info NOTE: Using ROSCO_M68K_DIR libs in: $(ROSCO_M68K_DIR))
endif

-include $(ROSCO_M68K_DIR)/code/software/software.mk

# Changes to compile against 68020 and 68882
CPU=68020
EXTRA_CFLAGS=-m68881

EXTRA_LIBS+=-lsdfat -ldebug_stub -lheap
EXTRA_VASMFLAGS?=-m68882 #-showopt


