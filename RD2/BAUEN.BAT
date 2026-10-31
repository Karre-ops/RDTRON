@echo off
rem H-Tron fuer RetroDesk 2 bauen (Open Watcom 1.9 oder 2.0, DOS)
wcc -0 -mm -os -s -zl -bt=dos -iSDK HTRON.C
wasm -0 SDK\RD2START.ASM
wlink format dos name HTRON file RD2START,HTRON library SDK\RD2.LIB,clibm.lib option nodefaultlibs
SDK\RDRC HTRON.RC HTRON.EXE "H-Tron"
