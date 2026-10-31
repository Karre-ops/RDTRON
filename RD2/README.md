# H-Tron for RetroDesk 2

A port of H-TRON to **RetroDesk 2 (RD2)**, a graphical desktop for DOS PCs from the 8088 upwards.
It was rewritten from scratch against the RD2 API. Game rules, the playfield logic and the computer
player (`AIComputerPlayer`) follow the original by RobertK (2016) and the CGA/EGA/VGA/GEM version
by MRalser (2026).

## What is different from the DOS version

- Runs in an RD2 window instead of full screen, alongside other RD2 programs.
- Timing via RD2 timers (`M_TIMER`) instead of `delay()`; keys via RD2 messages instead of an own INT 9 handler.
- One program for every RD2 graphics mode: the playfield adapts to the screen (CGA 640x200, Hercules,
  EGA, VGA, VESA up to 1024x768) and respects the pixel aspect ratio. With 4 colours or fewer,
  player two draws filled blocks so both trails stay distinguishable (CGA, Hercules, VGA mono).
- Joystick via the PC game port (RD2 `JoyRead`): joystick A = player two, joystick B = player one.
  The raw Amstrad PC1512/1640 joystick codes are not available under RD2 (no own interrupt handlers);
  the Amstrad BIOS translation to cursor keys still works.
- Menu: demo, 1 or 2 players, speed (slow/normal/fast), sound. Settings are kept in `RD2.INI` section `[HTron]`.
- German and English texts (follows the RD2 language setting).

## Controls

| Key | Action |
|---|---|
| A / D | Player one turns left / right |
| Cursor left / right | Player two turns left / right (one-player mode: cursor keys or A/D) |
| Space, fire button, mouse click | Start round |
| P | Pause (any key continues) |
| F1 | Controls, F2 new game |
| Esc | Abort game, on the title screen: quit |

## Folder layout

    RD2/
      README.md       this file
      BIN/RDTRON.EXE   ready-built RD2 program: the only file you need to play
      SRC/RDTRON.C     source
      SRC/RDTRON.RC    texts and menus (German/English, code page 437)
      SRC/BAUEN.BAT   build script (Open Watcom, DOS)
      SDK/            parts of the RD2 SDK needed to build: RD2.H, RD2API.H, RD2START.ASM, RD2.LIB, RDRC.EXE

## Playing

The RD2 program is called `RDTRON.EXE` on purpose: DOS ignores upper/lower case, so `HTRON.EXE`
would clash with the DOS version `Htron.exe` in the main folder of this repo.


Requires RetroDesk 2 with API 2.0. Copy `BIN/RDTRON.EXE` into the RD2 folder (e.g. `C:\RD2\`)
and start it from the RD2 shell. All other files are only needed to build it yourself.

## Building

In `RD2\SRC` run `BAUEN.BAT`, it writes `RD2\BIN\RDTRON.EXE`:

    wcc -0 -mm -os -s -zl -bt=dos -i=..\SDK RDTRON.C
    wasm -0 -fo=RD2START.OBJ ..\SDK\RD2START.ASM
    wlink format dos name ..\BIN\RDTRON.EXE file RD2START,RDTRON library ..\SDK\RD2.LIB,clibm.lib option nodefaultlibs
    ..\SDK\RDRC RDTRON.RC ..\BIN\RDTRON.EXE "H-Tron"

`-0` produces 8086 code, `-mm` is the medium memory model. Started directly under DOS the program
reports that it needs RetroDesk 2.

Status: builds cleanly (10.5 KB, about 22 KB RAM); not yet tested on real hardware.
