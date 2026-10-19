#!/usr/bin/env bash
# Prints the interesting part of every file build.sh produced. Run build.sh first.
cd "$(dirname "$0")/build" || exit 1

echo "=== file sizes ==="
ls -l main.i main.s main.o startup.o firmware.elf firmware.bin firmware.hex firmware.map | awk '{printf "%-14s %7s bytes\n", $9, $5}'

echo; echo "=== 1. main.i: lines, and BLINK_MS replaced ==="
wc -l < main.i
grep -n 'blink_ms =' main.i

echo; echo "=== 2. main.s: assembly for main() ==="
awk '/^main:/{f=1} f{print} /\.size\s+main/{exit}' main.s | grep -v '^\s*\.\(cfi\|loc\)' | head -25

echo; echo "=== 3. main.o: sections and symbols (addresses still 0) ==="
arm-none-eabi-objdump -h main.o | awk '$2 ~ /^\.(text|data|bss|rodata)$/ {printf "%-8s size 0x%s  VMA 0x%s\n", $2, $3, $4}'
arm-none-eabi-nm main.o

echo; echo "=== 4a. firmware.elf: sections with run (VMA) and load (LMA) addresses ==="
arm-none-eabi-objdump -h firmware.elf | awk '$2 ~ /^\./ && $2 !~ /comment|ARM/ {printf "%-12s size 0x%s  VMA 0x%s  LMA 0x%s\n", $2, $3, $4, $5}'
echo; echo "=== 4b. symbols with final addresses ==="
arm-none-eabi-nm -n firmware.elf
echo; echo "=== 4c. firmware.map: memory configuration ==="
awk '/^Memory Configuration/{f=1} f{print} /^Linker script and memory map/{exit}' firmware.map | head -10

echo; echo "=== 5a. firmware.bin: first 16 bytes (vector table) ==="
od -A x -t x4 -N 16 firmware.bin
echo; echo "=== 5b. firmware.hex: first 3 and last 3 lines ==="
head -3 firmware.hex; echo ...; tail -3 firmware.hex
