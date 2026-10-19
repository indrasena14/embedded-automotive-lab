#!/usr/bin/env bash
# Runs each build stage separately so you can open every intermediate file.
# Usage (WSL Ubuntu): bash build.sh
set -e
cd "$(dirname "$0")"
mkdir -p build
CFLAGS="-mcpu=cortex-m7 -mthumb -O1 -ffreestanding"

echo "1. Preprocess   main.c -> build/main.i"
arm-none-eabi-gcc $CFLAGS -E main.c -o build/main.i

echo "2. Compile      main.i -> build/main.s"
arm-none-eabi-gcc $CFLAGS -S build/main.i -o build/main.s

echo "3. Assemble     main.s -> build/main.o"
arm-none-eabi-gcc $CFLAGS -c build/main.s -o build/main.o
arm-none-eabi-gcc $CFLAGS -c startup.c -o build/startup.o

echo "4. Link         *.o + h735_min.ld -> build/firmware.elf (+ firmware.map)"
arm-none-eabi-gcc $CFLAGS -nostdlib -T h735_min.ld \
    build/startup.o build/main.o -o build/firmware.elf -Wl,-Map=build/firmware.map

echo "5. Convert      firmware.elf -> build/firmware.bin, build/firmware.hex"
arm-none-eabi-objcopy -O binary build/firmware.elf build/firmware.bin
arm-none-eabi-objcopy -O ihex   build/firmware.elf build/firmware.hex

echo "6. Inspect      build/firmware.list (disassembly)"
arm-none-eabi-objdump -d -h build/firmware.elf > build/firmware.list
arm-none-eabi-size build/firmware.elf
