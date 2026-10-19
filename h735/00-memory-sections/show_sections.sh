cd "$(dirname "$0")"
arm-none-eabi-gcc -mcpu=cortex-m7 -mthumb -O0 -fno-common -c sections_demo.c -o sections_demo.o || exit 1
echo '=== symbol -> section ==='
arm-none-eabi-objdump -t sections_demo.o \
  | awk 'NF>=5 && $(NF-2) ~ /^\.(text|rodata|data|bss)$/ && $(NF) !~ /^\./ {printf "%-12s %-8s 0x%s\n", $(NF), $(NF-2), $(NF-1)}' \
  | sort -k2 -s
echo '=== section totals ==='
arm-none-eabi-size -A sections_demo.o | awk '$1 ~ /^\.(text|rodata|data|bss)$/'
echo '=== start of demo(): stack frame setup ==='
arm-none-eabi-objdump -d sections_demo.o | awk '/<demo>:/{f=1} f&&n<4{print;n++}'
