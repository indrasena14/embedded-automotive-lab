# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal **learning repo**. The goal is to go from Linux and bare-metal basics to an automotive ECU + telematics system on two STM32 boards over ~42 weeks (started 19 Oct 2026, 12 h/week). The user is learning, so explain *why* things work (registers, reference manual sections, boot flow) instead of only producing code. Point to the relevant RM or datasheet chapter when possible.

- [README.md](README.md): objectives, hardware, 6-phase roadmap, capstone architecture
- [PROGRESS.md](PROGRESS.md): week-by-week checklist. When a task is finished, tick its box (`- [x]`)
- [docs/setup.md](docs/setup.md): laptop toolchain, WSL config, usbipd USB passthrough

## Hardware and tracks

| Track | Folder | Target |
|---|---|---|
| A | `linux-basics/` | PC Linux (WSL2 Ubuntu 24.04): shell, scripting, C system programming |
| B | `h735/` | **STM32H735G-DK**: Cortex-M7 MCU, bare-metal/HAL, FreeRTOS, TouchGFX, LwIP, CAN FD |
| C | `mp257/` | **STM32MP257F-DK**: 2× Cortex-A35 running OpenSTLinux, plus a Cortex-M33 co-processor |
| — | `capstone/` | Both boards together (weeks 35–42) |

External modules: SIM7600G-H (LTE), NEO-M8N (GPS), W25Q128/256 (SPI NOR flash), CAN-FD transceivers.

**Capstone architecture** (this ties the tracks together):
- The H735 is the "ECU". It runs FreeRTOS, sends J1939 PGNs, has a UDS server and bootloader, and shows a TouchGFX UI.
- The MP257 is the "TCU". Its M33 handles real-time CAN and passes data to Linux over RPMsg. Its A35 Linux runs GPS, LTE, MQTT, a Qt dashboard, and OTA updates that flash the ECU over UDS (0x34/0x36/0x37). Everything is built into a custom Yocto image.

## Repo conventions

- **`h735/`:** one numbered folder per project (`01-blink-hal/`, `02-blink-registers/`, ...). Each has a README covering what it does, the peripherals and pins it uses, how to build and flash it, and what was learned.
- **`mp257/`:** `apps/` (userspace, built with the Developer Package SDK), `drivers/` (out-of-tree kernel modules), `device-tree/`, `yocto/` (the user's own layer; build output is git-ignored), `m33/` (co-processor firmware).
- **Weekly notes:** copy [notes/TEMPLATE.md](notes/TEMPLATE.md) to `notes/week-NN.md`.
- **Build output stays out of git:** `Debug/`, `Release/`, `build/`, `*.elf`, `*.bin`, `*.hex`, TouchGFX `build/`, and Yocto `build*/`, `downloads/`, `sstate-cache/`. Keep CubeIDE `.settings/`, `.launch` files and TouchGFX `generated/` committed, because projects need them to build after cloning.

## Toolchain and commands

The host is Windows 11 with WSL2 Ubuntu 24.04 (12 GB RAM, 16 GB swap via `%USERPROFILE%\.wslconfig`).

- **H735 command-line builds** run in WSL with `arm-none-eabi-gcc` (13.2) and `make`. Debug with `gdb-multiarch`.
- **Flashing runs on Windows** with STM32CubeProgrammer. Its CLI is not on PATH:
  `"C:\Program Files\STMicroelectronics\STM32Cube\STM32CubeProgrammer\bin\STM32_Programmer_CLI.exe" -c port=SWD -w <file>.elf -v -rst`
- **IDE:** STM32CubeIDE 1.13.1 is in `C:\ST\`.
- **Serial console:** Tera Term or PuTTY on Windows. In WSL, use `picocom -b 115200 /dev/ttyACM0` after attaching the device with `usbipd attach --wsl --busid <id>`.
- **CAN:** `can-utils` is installed in WSL (`candump`, `cansend`, `isotpsend`/`isotprecv`).
- **Yocto and MP257 SDK builds** must run inside the WSL Linux filesystem (`~/`), never under `/mnt/c` (far too slow).

Known gaps, documented in [docs/setup.md](docs/setup.md):
- **STM32CubeProgrammer 2.14** cannot flash the STM32MP25; it needs updating before week 7.
- **TouchGFX Designer** is not installed yet.
- **CubeIDE** needs updating for MP2 M33 support.

## Git: personal account only

This laptop also has a work GitHub account (`ambati-indrasena-reddy-simpleenergy`), which is the default saved credential. This repo is pinned to the **personal** account:
- **Local commit identity:** `user.name=indrasena14`, `user.email=indrasenareddyambati@gmail.com`.
- **Remote URL** embeds the username: `https://indrasena14@github.com/indrasena14/embedded-automotive-lab.git`.

Don't change these settings, and never commit or push this repo with the work identity.
