# 00 · Build pipeline: .c → .elf → .bin / .hex

A complete minimal firmware for the STM32H735 (vector table, startup code, linker script, `main`), built one stage at a time so you can open every intermediate file. It doesn't drive any hardware.

| File | What it is |
|---|---|
| `main.c` | One variable of each kind (`.rodata`, `.data`, `.bss`), a function, a local |
| `startup.c` | Vector table + `Reset_Handler` that copies `.data` and zeroes `.bss` (CubeIDE's version: `startup_stm32h735igkx.s`) |
| `h735_min.ld` | Linker script cut down from CubeIDE's `stm32h735xg_flash.ld`: FLASH + AXI SRAM |
| `build.sh` | Runs preprocess → compile → assemble → link → objcopy as separate commands |
| `inspect.sh` | Prints the interesting part of every output file |

## Run it (WSL Ubuntu)

```bash
bash build.sh && bash inspect.sh
```

Outputs go to `build/`, which git ignores.

## The stages

| # | Tool | In → out | What happens |
|---|---|---|---|
| 1 | Preprocessor (`gcc -E`) | `main.c` → `main.i` | `#include` pasted in, `#define` replaced (`BLINK_MS` → `500`). 25 lines → 94 |
| 2 | Compiler (`gcc -S`) | `main.i` → `main.s` | C → Cortex-M7 assembly, optimized; items sorted into sections |
| 3 | Assembler (`gcc -c`) | `main.s` → `main.o` | Assembly → machine code. Every address is still 0 |
| 4 | Linker (`gcc -T h735_min.ld`) | `*.o` → `firmware.elf` + `.map` | Places sections at real addresses, resolves symbols |
| 5 | objcopy | `firmware.elf` → `.bin` / `.hex` | Keeps only the bytes that go into flash |

## Results (arm-none-eabi-gcc 13.2, -O1)

| File | Size |
|---|---|
| `firmware.elf` | 9,452 B (headers, symbol tables, section info) |
| `firmware.bin` | **164 B** (exactly what goes into flash) |
| `firmware.hex` | 535 B (the same 164 B as text, with addresses and checksums) |

Final layout from `objdump -h firmware.elf`:

| Section | Runs at (VMA) | Stored at (LMA) | Size |
|---|---|---|---|
| `.isr_vector` | `0x0800 0000` | `0x0800 0000` | 16 B |
| `.text` | `0x0800 0010` | same | 140 B |
| `.rodata` | `0x0800 009C` | same | 4 B |
| `.data` | `0x2400 0000` (RAM) | `0x0800 00A0` (flash) | 4 B |
| `.bss` | `0x2400 0004` (RAM) | not stored | 4 B |

First 16 bytes of `firmware.bin` (the vector table):

```
24050000  08000013  08000011  08000011
initial SP  Reset    NMI       HardFault
```

`0x2405 0000` is `_estack`, the top of AXI SRAM. `0x0800 0013` is `Reset_Handler` (`0x0800 0012`) with bit 0 set, which marks it as Thumb code.

## What I learned

- `.data` has two addresses. It runs at `0x2400 0000` in RAM, but its initial value (`500` = `F4 01 00 00`) is stored in flash at `0x0800 00A0`. Look for `:0400A000F401000067` in the `.hex`. `Reset_Handler` copies it to RAM.
- `.bss` isn't in the `.bin` at all. It's only zeroed at startup.
- At `-O1`, `add()` was inlined and `local` became the constant `#3`.
- `tick_count` is never written back to RAM. The compiler keeps it in a register, because nothing else reads it. Hardware registers and variables shared with interrupts need `volatile` to prevent this.

Study page: [From .c to .hex](https://claude.ai/artifact/UiZ62CwCXJtp95PSFCEbxK) (source: [docs/learning/03-build-pipeline.html](../../docs/learning/03-build-pipeline.html)) · Related: [00-memory-sections](../00-memory-sections/)
