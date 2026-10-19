# Embedded Automotive Lab

A hands-on learning journey from Linux and bare-metal MCU basics to a complete
automotive **ECU + telematics unit** built on two STM32 boards.

- **Start:** 19 Oct 2026 · **Pace:** 12 hrs/week · **Target finish:** Aug 2027 (~42 weeks)
- **Progress tracker:** [PROGRESS.md](PROGRESS.md)
- **Laptop setup:** [docs/setup.md](docs/setup.md)

## Objective

Develop hands-on expertise in:

| Area | Topics |
|---|---|
| MCU peripherals | GPIO, UART, SPI, I2C, ADC, DAC, DMA, RTC, PWM, USB |
| Automotive networks | CAN, CAN-FD, ISO-TP, UDS, J1939 |
| Firmware | Flash drivers, bootloaders, FreeRTOS, cache/MPU, TouchGFX |
| Embedded Linux | Boot chain (TF-A, OP-TEE, U-Boot), Device Tree, kernel drivers, Yocto, eMMC, remoteproc/RPMsg, Qt |
| Connectivity | Ethernet, TCP/IP, MQTT, GPS, LTE |
| Systems | Automotive telematics, OTA updates |

## Hardware

| Role | Board / module | Notes |
|---|---|---|
| MCU platform | **STM32H735G-DK** | Cortex-M7 @ 550 MHz, 4.3" touch LCD, OctoSPI flash + HyperRAM, Ethernet, CAN FD |
| MPU platform | **STM32MP257F-DK** | 2× Cortex-A35 + Cortex-M33, GPU, NPU, runs OpenSTLinux |
| LTE modem | SIM7600G-H | AT commands, data via PPP / ModemManager |
| GPS | NEO-M8N | UART, NMEA / UBX |
| External flash | W25Q128 / W25Q256 | SPI NOR flash driver |
| CAN | CAN-FD transceivers | Link between H735 and MP257 |

## Repository layout

```
linux-basics/   Track A - shell, scripting, C system programming on the PC
h735/           Track B - STM32H735G-DK firmware projects (one folder per project)
mp257/          Track C - STM32MP257F-DK: apps, drivers, device tree, Yocto, M33
capstone/       Final ECU + telematics project using both boards
notes/          Weekly learning notes (copy notes/TEMPLATE.md)
docs/           Setup, hardware references, pinouts
```

## Roadmap

Three tracks run in parallel, then merge into the capstone.

| Phase | Weeks | Dates | Focus | Milestone |
|---|---|---|---|---|
| 1. Foundations | 1–6 | 19 Oct – 29 Nov 2026 | Linux shell & scripting · H735 GPIO, clocks, interrupts, UART, timers, PWM, RTC, DAC | Build & flash H7 firmware from the command line |
| 2. Both boards | 7–14 | 30 Nov 2026 – 24 Jan 2027 | MP257 first boot, boot chain, SDK, userspace I/O, kernel build, Device Tree · H735 ADC/DMA, W25Q flash driver, cache/MPU, FreeRTOS, GPS, USB, OctoSPI, TouchGFX | Own service on MP2; RTOS + GUI on H7 |
| 3. Kernel & CAN | 15–20 | 25 Jan – 7 Mar 2027 | Kernel modules, char & platform drivers · LwIP Ethernet · CAN FD + SocketCAN | Own driver via DT; boards talk over CAN |
| 4. Automotive & Yocto | 21–29 | 8 Mar – 9 May 2027 | UDS over ISO-TP · J1939 · Yocto layers & images · M33 remoteproc/RPMsg · UDS bootloader · Qt6 | Custom Yocto image; H7 flashed over UDS |
| 5. Connectivity | 30–34 | 10 May – 13 Jun 2027 | SIM7600 LTE · MQTT · secure boot / OTA | Telemetry reaches an MQTT broker over LTE |
| 6. Capstone | 35–42 | 14 Jun – 8 Aug 2027 | ECU + telematics unit | Full system demo |

Week-by-week tasks are in [PROGRESS.md](PROGRESS.md).

## Capstone: ECU + Telematics Control Unit

```
 +-------------------------+   CAN FD (J1939 + UDS)   +------------------------------+
 |  STM32H735G-DK  "ECU"   | <======================> |  STM32MP257F-DK  "TCU"       |
 |  - FreeRTOS             |                          |  M33: real-time CAN handling |
 |  - sensors, W25Q logs   |                          |   | RPMsg                    |
 |  - J1939 PGNs           |                          |  A35 Linux (own Yocto image) |
 |  - UDS server + bootldr |                          |  - GPS (NEO-M8N)             |
 |  - TouchGFX status UI   |                          |  - LTE (SIM7600) -> MQTT     |
 +-------------------------+                          |  - Qt dashboard              |
                                                      |  - OTA: flashes ECU over UDS |
                                                      +------------------------------+
```

## Key references

- [ST wiki – STM32 MPU](https://wiki.st.com/stm32mpu) — main MP257 documentation
- [Bootlin training materials](https://bootlin.com/docs/) — embedded Linux, kernel, Yocto
- *The Linux Command Line* — William Shotts
- *Mastering STM32* — Carmine Noviello
- *The Definitive Guide to ARM Cortex-M3/M4* — Joseph Yiu
- *Mastering Embedded Linux Programming* — Frank Vasquez & Chris Simmonds
- *Linux Kernel Programming* (Parts 1 & 2) — Kaiwan Billimoria
- RM0468 (STM32H723/733/725/735/730 reference manual), UM2679 (STM32H735G-DK user manual)
