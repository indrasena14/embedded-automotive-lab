/* Minimal startup for the STM32H735: vector table + Reset_Handler.
 * CubeIDE generates the full version as startup_stm32h735igkx.s. */
#include <stdint.h>

extern uint32_t _estack;                     /* from the linker script */
extern uint32_t _sidata, _sdata, _edata;     /* .data: load address in flash, run address in RAM */
extern uint32_t _sbss, _ebss;                /* .bss: RAM to zero */

int main(void);

void Reset_Handler(void)
{
    uint32_t *src = &_sidata;
    uint32_t *dst = &_sdata;

    while (dst < &_edata)                    /* copy .data initial values flash -> RAM */
        *dst++ = *src++;

    for (dst = &_sbss; dst < &_ebss; )       /* zero .bss */
        *dst++ = 0;

    main();
    while (1) { }
}

void Default_Handler(void)
{
    while (1) { }
}

/* The first two words of flash: initial stack pointer, then the reset address.
 * The CPU reads these two words at power-on before running any code. */
__attribute__((section(".isr_vector"), used))
void (* const vector_table[])(void) = {
    (void (*)(void))&_estack,                /* 0x0800 0000: initial SP */
    Reset_Handler,                           /* 0x0800 0004: reset      */
    Default_Handler,                         /* NMI                     */
    Default_Handler,                         /* HardFault               */
};
