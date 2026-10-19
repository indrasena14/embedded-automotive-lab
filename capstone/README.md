# Capstone: ECU + Telematics Control Unit

Starts in week 36. See the architecture diagram in the main [README](../README.md#capstone-ecu--telematics-control-unit).

Planned structure:
```
ecu-h735/        FreeRTOS firmware: sensors, J1939, UDS server, bootloader, TouchGFX
tcu-m33/         M33 firmware: CAN handling, RPMsg bridge
tcu-linux/       Linux services: GPS, LTE, MQTT, OTA, Qt dashboard
meta-tcu/        Yocto layer for the TCU image
docs/            Architecture, CAN database (DBC), UDS DID list
```
