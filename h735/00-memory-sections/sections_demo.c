#include <stdint.h>
#include <stdlib.h>

/* ---------- globals ---------- */
const uint32_t baud_rate = 115200;          /* const            -> .rodata */
const char     banner[]  = "Hello H735";    /* const string     -> .rodata */

uint32_t blink_ms   = 500;                  /* initialized      -> .data   */
uint8_t  led_state  = 1;                    /* initialized      -> .data   */

uint32_t tick_count;                        /* no initializer   -> .bss    */
uint8_t  rx_buf[256];                       /* no initializer   -> .bss    */
uint32_t error_count = 0;                   /* = 0 also         -> .bss    */

/* ---------- functions ---------- */
uint32_t add(uint32_t a, uint32_t b)        /* code             -> .text   */
{
    uint32_t sum = a + b;                   /* local            -> stack   */
    return sum;
}

void demo(void)                             /* code             -> .text   */
{
    static uint32_t calls;                  /* static local     -> .bss    */
    static uint32_t start = 7;              /* static local     -> .data   */
    uint8_t temp[16];                       /* local array      -> stack   */
    uint8_t *p = malloc(64);                /* p on stack, 64 bytes on heap */

    calls++;
    temp[0] = (uint8_t)(start + calls);
    p[0] = temp[0];
    free(p);
}
