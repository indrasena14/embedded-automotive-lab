# Hardware Documents

Official ST documents for both boards, stored in the folders below.

> PDFs are **git-ignored**. They are ST's copyrighted documents, and some are very large (RM0457 is 122 MB). This page and the folders are tracked; the PDFs stay on this laptop. To fetch them again on a new machine, use the links below.

## STM32H735G-DK → `docs/hardware/h735/`

| Document | File | Source |
|---|---|---|
| **Board user manual** (UM2679) | `um2679-discovery-kit-with-stm32h735ig-mcu-stmicroelectronics.pdf` | [st.com](https://www.st.com/resource/en/user_manual/um2679-discovery-kit-with-stm32h735ig-mcu-stmicroelectronics.pdf) |
| **Board schematic** (MB1520 rev C03) | `mb1520-h735i-c03-schematic.pdf` | [st.com](https://st.com/resource/en/schematic_pack/mb1520-h735i-c03-schematic.pdf) |
| **MCU datasheet** (DS13312 Rev 4, STM32H735xG) | `DS_stm32h735ig.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **MCU reference manual** (RM0468) | `rm0468-stm32h723733-stm32h725735-and-stm32h730-value-line-advanced-armbased-32bit-mcus-stmicroelectronics.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **Errata sheet** (ES0491) | `es0491-stm32h72xx73xx-device-errata-stmicroelectronics.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| **Cortex-M7 programming manual** (PM0253) | `pm0253-stm32f7-series-and-stm32h7-series-cortexm7-processor-programming-manual-stmicroelectronics.pdf` | [Product page](https://www.st.com/en/microcontrollers-microprocessors/stm32h735ig.html) |
| Safety manual, single-core H7 (UM2331) | `um2331-stm32h7-singlecore-series-safety-manual-stmicroelectronics.pdf` | Functional safety; later reading |
| Self-test library guide (UM3252) | `um3252-stm32h7-series-ulcsaiec-...-selftest-library-user-guide-stmicroelectronics.pdf` | Functional safety; later reading |
| Functional safety packages overview | `stm32_stm8_functional-safety-packages.pdf` | Functional safety; later reading |
| Safety manual, dual-core H7 (UM2840) | `um2840-stm32h7-dualcore-series-safety-manual-stmicroelectronics.pdf` | ⚠️ Not applicable: the H735 is single-core, so use UM2331 |

Board page (BOM, Gerbers, schematic revisions): [STM32H735G-DK](https://www.st.com/en/evaluation-tools/stm32h735g-dk.html)

## STM32MP257F-DK → `docs/hardware/mp257/`

| Document | File | Source |
|---|---|---|
| **Board user manual** (UM3385) | `um3385-discovery-kit-with-stm32mp257f-mpu-stmicroelectronics.pdf` | [st.com](https://www.st.com/resource/en/user_manual/um3385-discovery-kit-with-stm32mp257f-mpu-stmicroelectronics.pdf) |
| **Board schematic** (MB1605 rev C01) | `mb1605-mp257f-c01-schematic.pdf` | [st.com](https://www.st.com/resource/en/schematic_pack/mb1605-mp257f-c01-schematic.pdf) |
| **MPU datasheet**, C/F variants, includes STM32MP257F (Apr 2025) | `DS_stm32mp257c.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **MPU reference manual** (RM0457) | `rm0457-stm32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **Errata sheet** (ES0598) | `es0598-stm32mp251x3x5x7x-device-errata-stmicroelectronics.pdf` | [ST wiki → STM32MP25 resources](https://wiki.st.com/stm32mpu/wiki/STM32MP25_resources) |
| **Cortex-M33 programming manual** (PM0264) | `pm0264-stm32-cortexm33-mcus-programming-manual-stmicroelectronics.pdf` | For the M33 co-processor |
| **PMIC datasheet** (STPMIC25, the power chip on this board) | `DS_stpmic25.pdf` | st.com |
| PMIC datasheet (STPMIC2L) | `DS_stpmic2l.pdf` | Different PMIC; check UM3385 for which one your board uses |
| MPU datasheet, A/D variants | `en.DM00969228.pdf` | ⚠️ Not your chip (STM32MP25xA/D); use `DS_stm32mp257c.pdf` |

Board page: [STM32MP257F-DK](https://www.st.com/en/evaluation-tools/stm32mp257f-dk.html)

## External modules → `docs/hardware/modules/`

| Module | What to get |
|---|---|
| SIM7600G-H | SIMCom hardware design manual + AT command manual |
| NEO-M8N | u-blox NEO-M8 datasheet + u-blox M8 receiver description (UBX protocol) |
| W25Q128 / W25Q256 | Winbond datasheet |
| CAN-FD transceiver | Datasheet for your transceiver part number |

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
