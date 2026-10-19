# 00 · Memory sections

Shows where the compiler puts each kind of C object (`.text`, `.rodata`, `.data`, `.bss`, stack, heap). There's no board code here; it only compiles to an object file and inspects it.

## Run it (WSL Ubuntu)

```bash
bash show_sections.sh
```

This compiles `sections_demo.c` for the Cortex-M7 at `-O0` and prints each symbol's section, the section totals, and the stack frame `demo()` sets up.

## Result (arm-none-eabi-gcc 13.2, -O0)

| Symbol | Section | Size |
|---|---|---|
| `add`, `demo` | `.text` | 30 B, 74 B |
| `baud_rate`, `banner` | `.rodata` | 4 B, 11 B |
| `blink_ms`, `led_state`, `start` (static local) | `.data` | 4 B, 1 B, 4 B |
| `tick_count`, `rx_buf`, `error_count` (`= 0`), `calls` (static local) | `.bss` | 4 B, 256 B, 4 B, 4 B |

Totals: `.text` 104 B · `.rodata` 15 B · `.data` 12 B (9 B of variables plus alignment padding) · `.bss` 268 B.

Local variables (`sum`, `temp`, `p`) have no symbol. They live on the stack, and `demo()` reserves 24 bytes for them with `sub sp, #24`. The 64 bytes from `malloc()` come from the heap at run time.

## Where they end up on the H735

This comes from the CubeIDE 1.13.1 linker template (`stm32h735xg_flash.ld`):

| Section | Region |
|---|---|
| `.text`, `.rodata` | FLASH `0x0800 0000` |
| `.data` | RAM_D1 (AXI SRAM) `0x2400 0000`; startup code copies its initial values from FLASH |
| `.bss`, heap, stack | RAM_D1 (AXI SRAM); startup code zeroes `.bss` |

ITCM, DTCM, RAM_D2 and RAM_D3 are defined in the template but unused until you place something there yourself.

## What I learned

- `= 0` and no initializer both go to `.bss`, which costs no flash.
- `.data` costs flash (for the initial value) **and** RAM.
- `const` keeps data in flash; drop it and the data is copied to RAM.
- At `-O1`, `start` disappears: the compiler sees it never changes and folds it to the constant 7.

## Try

- Remove `const` from `baud_rate`, then rerun. It moves to `.data`.
- Change `error_count = 0` to `= 1`. It moves to `.bss` → `.data`.
- Add a local `uint8_t big[4096];` to `demo()` and watch the `sub sp, #...` value grow.

Study page: [H735 Memories](https://claude.ai/artifact/EeTwZtDSf1suXydwR3XbD6) (source: [docs/learning/02-h735-memories.html](../../docs/learning/02-h735-memories.html))
