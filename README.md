# Tanks

This is the robotics project I'm doing with my sons as a means of teaching
engineering principles, software development, mathematics, and whatever else
comes along for the ride.

## Components

The tanks have been designed to have these components in common:

1. ARES: The Autonomic and Rule Enforcement System. A Raspberry Pi Zero to
   provide the main functions for driving the robot. This is responsible for
   automatic functions and for directing low level operation of the robot. It
   also helps with rule enforcement, once the rules for the laser-tag-style game
   have been agreed upon. It will also provide the tooling for OTA updates to
   both the internal firmware and the firmware on the CPX systems. It does not
   provide any tools for directing the robot.

2. TBD: An Adafruit Circuit Playground Express, which provides high level direction
   to the robot. It receives input from the the ARES computer over a serial data
   and response via the same control line.

3. TBD: The Crickit Hat provides the lowest level control of most of the
   electronics. It is driven directly by the ARES computer and indirectly by the
   CPX.

4. Tamiya motors and gearboxes provide primary impulse for controlling the
   robot.

5. Proximity sensors at each wheel provide tachometer functions for each will to
   calculate approximate rotation and movement.

6. A servo provides the drive mechanism for rotating the top turret.

7. An IR LED and focusing lens send out firing signals.

8. Four (4) IR photoresisters receive signals to determine when a hit occurs.

9. A 6 chip LED array provides a status and health indicator.

10. A camera is used to provide computer vision features. The exact features
    provided are to be determined, but at least a primitive target tracking
    system is planned.

11. A speaker will provide audible feedback regarding events and status of the
    robot.

12. The chassis, wheels, and other hardware will be similar for all robots, with
    the largest pieces being 3D printed. But some metric screws, bearings, and
    other metal hardware also in use.

13. The boys may, optionally, attach additional panelling and body pieces to
    style their robot using 3D printed parts or any other material they want.
