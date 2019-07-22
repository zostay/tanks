# Tank Autonomic/Rule Enforcement System (ARES) Firmware

Each tank receives this firmware running on a Raspberry Pi-based computer brain
thing. The goal of this firmware is as follows:

1. Communicate with Crickit Hat, to drive the speaker, NeoPixels, motors, servo,
   tachometers, IR receivers, and IR transmitter.
   
2. Process image data from the camera.

3. Receive and apply OTA updates to this firmware and reboot the firmware.

4. Receive and apply OTA updates for the CPX firmware for the tank master
   computer.

5. Communicate over serial to the attached CPX tank master computer, react to
   commands sent from the MCU.
