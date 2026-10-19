/* Build-pipeline demo: one variable of each kind, so every section shows up
 * in the .o, .elf, .map, .bin and .hex files. It doesn't drive any hardware. */
#include <stdint.h>

#define BLINK_MS 500                         /* preprocessor: replaced before compiling */

const uint32_t baud_rate = 115200;           /* .rodata -> flash                  */
uint32_t blink_ms = BLINK_MS;                /* .data   -> RAM, initial value in flash */
uint32_t tick_count;                         /* .bss    -> RAM, zeroed at startup  */

static uint32_t add(uint32_t a, uint32_t b)  /* .text   -> flash                  */
{
    return a + b;
}

int main(void)                               /* .text   -> flash                  */
{
    uint32_t local = 3;                      /* stack                              */

    while (1) {
        tick_count = add(tick_count, local);
        if (tick_count > blink_ms * baud_rate)
            tick_count = 0;
    }
}
