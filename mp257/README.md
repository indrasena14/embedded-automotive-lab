# STM32MP257F-DK (Track C)

| Folder | Contents |
|---|---|
| `apps/` | Userspace apps, cross-compiled with the Developer Package SDK |
| `drivers/` | Out-of-tree kernel modules and drivers |
| `device-tree/` | Device Tree changes (`.dts` / `.dtsi` / overlays) |
| `yocto/` | Your Yocto layer (e.g. `meta-eal`); keep build output out of git |
| `m33/` | Cortex-M33 co-processor firmware (remoteproc / RPMsg) |

## Boot chain
```
ROM code -> TF-A (BL2) -> TF-A BL31 + OP-TEE -> U-Boot -> Linux kernel -> rootfs (systemd)
```

## References
- https://wiki.st.com/stm32mpu (Starter / Developer / Distribution Packages)
- STM32CubeProgrammer: needs a version newer than 2.14 for STM32MP25
