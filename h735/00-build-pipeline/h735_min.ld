/* Minimal linker script for the STM32H735 (cut down from CubeIDE's stm32h735xg_flash.ld). */
ENTRY(Reset_Handler)

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM   (xrw) : ORIGIN = 0x24000000, LENGTH = 320K   /* AXI SRAM (RAM_D1) */
}

_estack = ORIGIN(RAM) + LENGTH(RAM);                /* stack starts at the top of RAM */

SECTIONS
{
  .isr_vector : { KEEP(*(.isr_vector)) } >FLASH     /* must be first in flash */

  .text   : { . = ALIGN(4); *(.text*)   . = ALIGN(4); } >FLASH
  .rodata : { . = ALIGN(4); *(.rodata*) . = ALIGN(4); } >FLASH

  _sidata = LOADADDR(.data);                         /* where .data's initial values sit in flash */
  .data : {
    . = ALIGN(4); _sdata = .;
    *(.data*)
    . = ALIGN(4); _edata = .;
  } >RAM AT>FLASH                                    /* runs in RAM, stored in flash */

  .bss (NOLOAD) : {
    . = ALIGN(4); _sbss = .;
    *(.bss*) *(COMMON)
    . = ALIGN(4); _ebss = .;
  } >RAM                                             /* RAM only, nothing stored in flash */
}
