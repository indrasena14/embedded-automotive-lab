# Laptop Setup

Host: Windows 11, i7-11800H (8C/16T), 16 GB RAM.

## Windows
| Tool | Version | Notes |
|---|---|---|
| STM32CubeIDE | 1.13.1 | ⚠️ Update to latest (needed for MP2 M33 support) |
| STM32CubeProgrammer | 2.14.0 | ⚠️ Update before week 8 (2.14 does not support STM32MP25) |
| TouchGFX Designer | — | ☐ Install before week 15 |
| Tera Term / PuTTY | 5.5.2 / 0.83 | Serial console |
| Saleae Logic 2 | 2.4.44 | Logic analyzer software |
| MQTT Explorer / MQTTX | — | MQTT testing |
| usbipd-win | 5.3.0 | Share USB devices (ST-Link, serial) with WSL |
| Git, VS Code, Qt | — | |

## WSL2: Ubuntu 24.04
Installed: `gcc`, `make`, `git`, `python3`, `picocom`, `minicom`,
`gcc-arm-none-eabi` (13.2.1), `gdb-multiarch`, `can-utils`.

`%USERPROFILE%\.wslconfig`:
```ini
[wsl2]
memory=12GB
swap=16GB
```
Apply changes with `wsl --shutdown`.

**Yocto:** build inside the Linux filesystem (`~/`), never under `/mnt/c` (very slow).

## Passing a USB device to WSL (usbipd)
In an admin PowerShell:
```
usbipd list
usbipd bind --busid <BUSID>
usbipd attach --wsl --busid <BUSID>
```
The device then appears in Ubuntu as e.g. `/dev/ttyACM0`. Open it with `picocom -b 115200 /dev/ttyACM0`.
