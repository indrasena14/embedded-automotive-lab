# Progress Tracker

Tick items as you finish them (`- [x]`). Each week: write a note in `notes/` and commit your code.

**Weekly rhythm (12 h):** Mon/Wed 1.5 h theory · Tue/Thu 1.5 h hands-on · Sat 4–5 h board project · Sun 1 h review + notes

Items marked 🔗 build on the Week 5 linker work.

---

## Phase 1 — Foundations (19 Oct – 6 Dec 2026)

### Week 1 · 19 Oct
- [ ] Linux: shell navigation, files & directories (*The Linux Command Line* ch. 1–3)
- [ ] H735: CubeIDE project, blink LED with HAL, UART "hello"
- [ ] H735: find the LED pin in the schematic, step through code in the debugger
- [ ] Note: what happens from power-on to `main()`

### Week 2 · 26 Oct
- [ ] Linux: permissions, pipes & redirection, grep/find, vim
- [ ] H735: blink with registers only (no HAL)
- [ ] H735: read RM0468 RCC + GPIO chapters

### Week 3 · 2 Nov
- [ ] Linux: processes, signals, systemd, journalctl
- [ ] H735: clock tree & PLLs, SysTick, button interrupt (EXTI/NVIC)

### Week 4 · 9 Nov
- [ ] Linux: bash scripting, Makefiles
- [ ] H735: read CubeIDE's startup file (`startup_stm32h735igkx.s`) and match it to `h735/00-build-pipeline/startup.c`
- [ ] H735: build blink from the command line (arm-none-eabi-gcc + Makefile in WSL), flash with STM32CubeProgrammer

### Week 5 · 16 Nov — Linker scripts and map files
- [ ] Mon: linker script syntax: `MEMORY`, `SECTIONS`, location counter `.`, `ALIGN`, `KEEP`, `>RAM AT>FLASH`, `LOADADDR`, `NOLOAD`, `ENTRY`, `PROVIDE`
- [ ] Tue: read CubeIDE's full `STM32H735IGKX_FLASH.ld` line by line against `h735/00-build-pipeline/h735_min.ld`
- [ ] Wed: read `.map` files: usage per memory region, where a symbol landed, what takes the most space
- [ ] Thu: stack and heap: `_Min_Stack_Size` / `_Min_Heap_Size`, measure real stack use with a fill pattern
- [ ] Sat: project `h735/05-linker-lab`:
  - [ ] DMA buffer placed in RAM_D2 with a custom section
  - [ ] a fast function running from ITCM (with its own copy loop in startup)
  - [ ] a variable in backup SRAM that survives a reset
  - [ ] a build that fails on purpose when RAM overflows
- [ ] Sun: notes + "Linker Scripts" study page

### Week 6 · 23 Nov
- [ ] Linux: networking (ip, ss, tcpdump), `/proc`, `/sys`, ssh
- [ ] H735: UART polling → interrupt → DMA, printf retarget
- [ ] 🔗 H735: UART DMA receive buffer in RAM_D2 using the Week 5 section

### Week 7 · 30 Nov
- [ ] Linux: C system programming (files, fork/exec)
- [ ] H735: timers, PWM, input capture
- [ ] H735: RTC (calendar + alarm), DAC output

**Milestone:** ☐ Comfortable in the terminal · ☐ H7 firmware built & flashed without the IDE · ☐ Can place any variable or function in any memory region

---

## Phase 2 — Both boards (7 Dec 2026 – 31 Jan 2027)

> Before Week 8: update STM32CubeProgrammer (2.14 does not support STM32MP25).

### Week 8 · 7 Dec
- [ ] MP257: flash Starter Package, serial console, explore the running system
- [ ] H735: ADC with DMA
- [ ] Linux: threads (pthreads)

### Week 9 · 14 Dec
- [ ] MP257: boot chain theory, partitions, U-Boot commands
- [ ] H735: SPI → **W25Q flash driver** (JEDEC ID, erase, program, read back)
- [ ] H735: I2C sensor

### Week 10 · 21 Dec
- [ ] MP257: read TF-A / OP-TEE / U-Boot boot logs end to end
- [ ] H735: I/D-cache, MPU, DMA cache coherency
- [ ] 🔗 H735: MPU non-cacheable region matching a linker section exactly

### Week 11 · 28 Dec
- [ ] MP257: install Developer Package SDK, cross-compile, remote debug with gdbserver
- [ ] H735: fault handlers, SWV/ITM debugging

### Week 12 · 4 Jan
- [ ] MP257: userspace GPIO & I2C (libgpiod, i2c-tools)
- [ ] H735: FreeRTOS tasks & queues
- [ ] H735: **NEO-M8N GPS** — UART DMA reception task

### Week 13 · 11 Jan
- [ ] MP257: run your app as a systemd service; socket programming
- [ ] H735: FreeRTOS mutexes, priority inversion, stack sizing
- [ ] H735: NMEA parser task (position, speed, time)

### Week 14 · 18 Jan
- [ ] MP257: rebuild the kernel from the Developer Package and deploy it
- [ ] H735: OctoSPI memory-mapped flash, HyperRAM
- [ ] 🔗 H735: external-flash linker section for large images and fonts (XiP)
- [ ] H735: **USB CDC** virtual COM port

### Week 15 · 25 Jan
- [ ] MP257: Device Tree basics, modify the DT (enable an LED or peripheral)
- [ ] H735: first TouchGFX screen (install TouchGFX Designer first)

**Milestone:** ☐ Own service running on MP2 · ☐ RTOS + GUI on H7

---

## Phase 3 — Kernel & CAN (1 Feb – 14 Mar 2027)

### Weeks 16–17 · 1 Feb
- [ ] MP257: kernel modules — hello world, module parameters, sysfs
- [ ] H735: TouchGFX showing live data (GPS speed/position) from an RTOS task

### Weeks 18–19 · 15 Feb
- [ ] MP257: char driver (file ops, ioctl)
- [ ] MP257: platform driver bound from the Device Tree
- [ ] H735: Ethernet with LwIP (simple web server)

### Weeks 20–21 · 1 Mar
- [ ] MP257: driver with interrupts; real I2C sensor driver
- [ ] MP257: SocketCAN (candump / cansend)
- [ ] H735: **CAN FD** — exchange frames with MP257 via transceivers

**Milestone:** ☐ Own driver via Device Tree · ☐ Boards talk over CAN FD

---

## Phase 4 — Automotive & Yocto (15 Mar – 16 May 2027)

### Weeks 22–23 · 15 Mar
- [ ] H735: **ISO-TP + UDS server** (DiagnosticSessionControl, ReadDataByIdentifier, DTCs)
- [ ] MP257: UDS client using Linux ISO-TP sockets (isotpsend / isotprecv, then C)
- [ ] MP257: Yocto — build the Distribution Package (first build overnight)

### Weeks 24–25 · 29 Mar
- [ ] H735: **J1939** — transmit PGNs (speed, temperature, GPS)
- [ ] MP257: receive with Linux J1939 sockets
- [ ] MP257: Yocto — own layer, recipe for your app & driver, custom image

### Weeks 26–28 · 12 Apr
- [ ] MP257: M33 firmware; **remoteproc + RPMsg** between A35 and M33
- [ ] H735: custom bootloader over UART
- [ ] 🔗 H735: two linker scripts (bootloader at `0x0800 0000`, app at an offset) + vector table relocation (VTOR)

### Weeks 29–30 · 3 May
- [ ] MP257: Weston/Wayland, **Qt6** app via meta-qt6
- [ ] H735: **UDS-based flashing** (0x34 RequestDownload, 0x36 TransferData, 0x37 RequestTransferExit)

**Milestone:** ☐ Custom Yocto image with own driver + Qt app + M33 firmware · ☐ H7 flashed over UDS

---

## Phase 5 — Connectivity (17 May – 20 Jun 2027)

### Weeks 31–33 · 17 May
- [ ] MP257: **SIM7600G-H** — AT commands (SIM, signal, network registration)
- [ ] MP257: LTE data connection (ModemManager or PPP)
- [ ] MP257: GPS on the TCU side (NEO-M8N or SIM7600 GNSS)
- [ ] MP257: **MQTT** with mosquitto / paho — publish telemetry, view in MQTT Explorer

### Weeks 34–35 · 7 Jun
- [ ] Pick 1–2: secure boot & signed images · OTA with SWUpdate or RAUC · NPU with X-LINUX-AI
- [ ] 🔗 H735: A/B firmware slots in flash (linker layout for two app images)

**Milestone:** ☐ Vehicle telemetry reaches an MQTT broker over LTE

---

## Phase 6 — Capstone (21 Jun – 15 Aug 2027)

### Weeks 36–43
- [ ] Architecture doc in `capstone/`
- [ ] ECU (H735): sensors, J1939 PGNs, UDS server + bootloader, TouchGFX status, logs in W25Q
- [ ] TCU M33: real-time CAN handling, RPMsg to Linux
- [ ] TCU Linux: GPS + LTE + MQTT telemetry, Qt dashboard
- [ ] OTA: new ECU firmware via MQTT → TCU → UDS flash
- [ ] Everything in your own Yocto image
- [ ] Demo video + write-up

**Milestone:** ☐ Full system demo
