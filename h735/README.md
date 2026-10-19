# STM32H735G-DK (Track B)

One folder per project, numbered in the order you build them, e.g.:

```
01-blink-hal/
02-blink-registers/
03-exti-button/
04-blink-makefile/      # command-line build, no IDE
05-uart-dma/
...
```

Each project folder gets a short `README.md` covering:
- What it does
- Peripherals and pins used
- How to build and flash it
- What you learned or what went wrong

## Board quick facts
- MCU: STM32H735IG, Cortex-M7 @ 550 MHz, 1 MB flash, 564 KB RAM
- 4.3" 480×272 touch LCD, OctoSPI flash + HyperRAM
- Ethernet, CAN FD, USB OTG, microSD, audio
- On-board STLINK-V3E (debugger + virtual COM port)

## References
- RM0468: reference manual
- UM2679: board user manual
- Board schematic (from the st.com board page)
