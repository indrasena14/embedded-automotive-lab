# Hardware Documents

Official ST documents for both boards, stored in the folders below. Files are named `<doc number>-<subject>-<type>.pdf`; keep that pattern for new downloads.

> PDFs are **git-ignored**. They are ST's copyrighted documents, and some are very large (RM0457 is 122 MB). This page and the folders are tracked; the PDFs stay on this laptop. To fetch them again on a new machine, use the links below.

## STM32H735G-DK → `docs/hardware/h735/`

| Document | File | Source |
|---|---|---|
| **Board user manual** (UM2679) | `UM2679-STM32H735G-DK-user-manual.pdf` | [st.com](https://www.st.com/resource/en/user_manual/um2679-discovery-kit-with-stm32h735ig-mcu-stmicroelectronics.pdf) |
| **Board schematic** (MB1520 rev C03) | `MB1520-C03-STM32H735G-DK-schematic.pdf` | [st.com](https://st.com/resource/en/schematic_pack/mb1520-h735i-c03-schematic.pdf) |
| **MCU datasheet** (DS13312 Rev 4, STM32H735xG) | `DS13312-STM32H735xG-datasheet.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **MCU reference manual** (RM0468) | `RM0468-STM32H723-735-reference-manual.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **Errata sheet** (ES0491) | `ES0491-STM32H72x-73x-errata.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **Cortex-M7 programming manual** (PM0253) | `PM0253-Cortex-M7-programming-manual.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **HAL & LL driver manual** (UM2217 Rev 6) | `UM2217-STM32H7-HAL-LL-drivers.pdf` | [STM32CubeH7 → Documentation](https://www.st.com/en/embedded-software/stm32cubeh7.html) |
| Safety manual, single-core H7 (UM2331) | `UM2331-STM32H7-single-core-safety-manual.pdf` | Functional safety; later reading |
| Self-test library guide (UM3252) | `UM3252-STM32H7-self-test-library-guide.pdf` | Functional safety; later reading |
| Functional safety packages overview | `STM32-functional-safety-packages.pdf` | Functional safety; later reading |

Board page (BOM, Gerbers, schematic revisions): [STM32H735G-DK](https://www.st.com/en/evaluation-tools/stm32h735g-dk.html)

## STM32MP257F-DK → `docs/hardware/mp257/`

| Document | File | Source |
|---|---|---|
| **Board user manual** (UM3385) | `UM3385-STM32MP257F-DK-user-manual.pdf` | [st.com](https://www.st.com/resource/en/user_manual/um3385-discovery-kit-with-stm32mp257f-mpu-stmicroelectronics.pdf) |
| **Board schematic** (MB1605 rev C01) | `MB1605-C01-STM32MP257F-DK-schematic.pdf` | [st.com](https://www.st.com/resource/en/schematic_pack/mb1605-mp257f-c01-schematic.pdf) |
| **MPU datasheet** (DS14284, STM32MP25xC/F, includes your MP257F) | `DS14284-STM32MP25xC-F-datasheet.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **MPU reference manual** (RM0457) | `RM0457-STM32MP23-25-reference-manual.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **Errata sheet** (ES0598) | `ES0598-STM32MP25-errata.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **Cortex-M33 programming manual** (PM0264) | `PM0264-Cortex-M33-programming-manual.pdf` | For the M33 co-processor |
| **PMIC datasheet** (DS14278, STPMIC25, the power chip on this board) | `DS14278-STPMIC25-PMIC-datasheet.pdf` | st.com |

Board page: [STM32MP257F-DK](https://www.st.com/en/evaluation-tools/stm32mp257f-dk.html)

## CAN hardware on the boards

- **STM32H735G-DK** has an on-board CAN FD transceiver, the **Microchip MCP2562FD**. It's wired to FDCAN3 (PF7 = TX, PF6 = RX) through solder bridges SB29 and SB30 (UM2679 p.18). FDCAN3 shares pins with SPI5 and UART7, and PF7 also drives the Arduino LED LD8.
- **STM32MP257F-DK** has **no CAN transceiver**. Use your external CAN-FD transceiver module on the expansion header.

## Still to download

| Folder | Document | Needed by |
|---|---|---|
| `h735/` | Microchip **MCP2562FD** datasheet (on-board CAN FD transceiver) | Week 19 |
| `h735/` | **AN4839**: Level 1 cache on STM32F7 and STM32H7 | Week 9 |
| `h735/` | **AN4838**: Managing memory protection unit in STM32 MCUs | Week 9 |
| `modules/` | **W25Q128JV** / **W25Q256JV** datasheet (Winbond) | Week 8 |
| `modules/` | **NEO-M8** datasheet + **u-blox M8 receiver description** (NMEA/UBX protocol) | Week 11 |
| `modules/` | Datasheet for **your CAN-FD transceiver module's** chip (part number is printed on the chip) | Week 19 |
| `modules/` | **SIM7600 series AT command manual** + **SIM7600 hardware design** (SIMCom) | Week 30 |

The MP257 software docs (Starter / Developer / Distribution Packages, Device Tree, RPMsg) live on the [ST wiki](https://wiki.st.com/stm32mpu), not in PDFs, so there's nothing more to download for that board.

## Which document answers what

| Question | Look in |
|---|---|
| Which pin is the LED / UART / CAN connected to? | Board **schematic**, then board **user manual** (pin assignment tables) |
| Jumper and solder-bridge settings, power options | Board **user manual** |
| Which alternate function (AF) number puts a peripheral on a pin? | **Datasheet** → alternate function tables |
| Electrical limits, pin voltages, clock limits | **Datasheet** |
| How a peripheral works, its register bits | **Reference manual** |
| NVIC, SysTick, MPU, cache control (Cortex-M7 core) | **PM0253** programming manual |
| "My code is correct but the hardware misbehaves" | **Errata sheet** |
