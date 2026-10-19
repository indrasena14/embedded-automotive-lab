# Learning Library

One place for everything made while learning: study pages (Claude artifacts), flowcharts and diagrams, and design documents.

> **Artifact links are private.** They open only for your claude.ai account. To share one, use the **Share** menu on the page. The HTML source for each page is saved in this folder, so you can also open it locally in a browser.

## Study pages

| # | Topic | Week | Artifact | Source |
|---|---|---|---|---|
| 01 | Cortex-M7 core: CPU, Arm families, FPU, cache, MPU vs MMU, DMIPS, DSP | 1 | [Cortex-M7 Core](https://claude.ai/artifact/CFJY3hw8TaLYpdDibc7jom) | [01-cortex-m7-core.html](01-cortex-m7-core.html) |
| 02 | Memories: flash, SRAM regions, TCM, memory map, cache hit/miss, linker placement, C sections | 1 | [H735 Memories](https://claude.ai/artifact/EeTwZtDSf1suXydwR3XbD6) | [02-h735-memories.html](02-h735-memories.html) · demo [h735/00-memory-sections](../../h735/00-memory-sections/) |

## Flowcharts and diagrams

| Diagram | What it shows | Where |
|---|---|---|
| Capstone architecture | H735 ECU ↔ CAN FD ↔ MP257 TCU (M33 + Linux), GPS, LTE, MQTT, OTA | [README.md → Capstone](../../README.md#capstone-ecu--telematics-control-unit) |
| Chip vs core block diagram | Cortex-M7 core inside the STM32H735, with ST's peripherals around it | [Cortex-M7 Core § 01](https://claude.ai/artifact/CFJY3hw8TaLYpdDibc7jom) |
| H735 memory map | ITCM, flash, DTCM, AXI SRAM, SRAM1–4, backup SRAM, peripherals, Octo-SPI | [H735 Memories → memory map](https://claude.ai/artifact/EeTwZtDSf1suXydwR3XbD6) |
| Compile → link flow | .c → compiler → sections → linker + .ld → .elf / .map | [H735 Memories → who decides](https://claude.ai/artifact/EeTwZtDSf1suXydwR3XbD6) |

Write new diagrams as Mermaid blocks (```` ```mermaid ````) in Markdown files here. GitHub renders them directly.

## Design documents

| Document | Status | Where |
|---|---|---|
| Capstone architecture doc | Planned (week 35) | `capstone/` |
| CAN database (DBC) and UDS DID list | Planned (weeks 21–24) | `capstone/docs/` |

## Adding a new entry

1. Save the source in this folder as `NN-topic.html` (or `.md`), numbered in the order you learn it.
2. Add a row to the right table above with the artifact link.
3. Commit both files together.
