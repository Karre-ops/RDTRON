@echo off
rem H-Tron fuer RetroDesk 2 bauen (Open Watcom 1.9 oder 2.0, DOS)
rem Aufruf im Ordner RD2\SRC, Ergebnis: RD2\BIN\RDTRON.EXE
wcc -0 -mm -os -s -zl -bt=dos -i=..\SDK RDTRON.C
if errorlevel 1 goto fehler
wasm -0 -fo=RD2START.OBJ ..\SDK\RD2START.ASM
if errorlevel 1 goto fehler
wlink format dos name ..\BIN\RDTRON.EXE file RD2START,RDTRON library ..\SDK\RD2.LIB,clibm.lib option nodefaultlibs
if errorlevel 1 goto fehler
..\SDK\RDRC RDTRON.RC ..\BIN\RDTRON.EXE "H-Tron"
if errorlevel 1 goto fehler
echo Fertig: ..\BIN\RDTRON.EXE
goto ende
:fehler
echo Fehler beim Bauen
:ende
