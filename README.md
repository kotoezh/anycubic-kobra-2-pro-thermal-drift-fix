# anycubic-kobra-2-pro-thermal-drift-fix
Custom Start G-Code for Anycubic Kobra 2 Pro to solve inconsistent Z-offset issues by cooling down inductive sensor before printing starts. 
New Update: Added a hardware-assisted calibration method (the "Tape Hack") to improve bed auto-leveling results and test models to verify Z-offset consistency across the entire bed.


## Problem
1) During printing, the inductive sensor gets overheated by the bed and the nozzle. This causes the sensor to trigger "too high" (too early), resulting in a failed first layer if the sensor is not cooled down before the next print. This is especially critical when restarting a print immediately after a previous one.
2) The same 


## Solution
This script implements a "Cold Probe" strategy: it actively cools the sensor at 100mm height before homing, ensuring a stable and repeatable Z-offset regardless of machine temperature.
The base start machine G-Code script is inherited from Anycubic Slicer Next 1.3.6.1 settings for Kobra 2 Pro
Added lines are marked with (+) so you can try implementing this strategy in any other start G-Code

## How to use

### Option 1: Direct Replace (Easiest)
If you are using **Anycubic Slicer Next** (or Orca Slicer), follow these steps:
1. Open your slicer and go to **Printer Settings**.
2. Navigate to the **Machine G-code** tab.
3. Locate the **Machine start G-code** field.
4. Delete the existing code and paste the content of [anycubic kobra 2 pro start machine.gcode](https://github.com/kotoezh/anycubic-kobra-2-pro-thermal-drift-fix/blob/main/anycubic%20kobra%202%20pro%20start%20machine.gcode) from this repository.
5. **Important:** Run a test print and re-calibrate your Z-offset once. Since the homing is now "cold", your previous "hot" Z-offset value may be incorrect.

### Option 2: Manual Modification
If you have a custom start G-code and want to keep it:
1. Find the lines marked with `(+)` in the provided script.
2. Integrate them into your script, ensuring that `G28` (homing) occurs while the sensor is cooled and the nozzle is cold.
3. Make sure to include the `M106 S255` command after the first homing, as the printer firmware may automatically disable the fan.

## Safety Note
Always stay near the printer during the first run after applying this G-code. Ensure the Z-offset is adjusted correctly to prevent the nozzle from touching the print bed.


## Improved Auto-Leveling Method (The "Tape Hack")
Through testing, I discovered that the standard Auto-Leveling process on the Kobra 2 series also suffers from **cumulative sensor heating**. As the probe moves from point 1 (bottom-left) to point 25 (top-right), it stays close to the heated bed and gradually warms up. This causes the sensor to trigger higher towards the top right corner and is misinterpreted as a higher plate there, even if the plate is totally flat. This may results in an inaccurate "warped" mesh and inconsistent first layer across the plate.

### The Solution:
The print head has a "secret" internal vent designed to cool the inductive sensor (see photo in `/images`). By redirecting all airflow to this vent during calibration, we improve precision of the measurements, even if we cannot change the hardware leveling sequence. 

**Instructions:**
1. **Seal the main vents:** Use masking tape to cover the bottom part-cooling outlets (see photo in `/images`).
3. **Run Calibration:** Start the "Auto-Leveling" from the printer menu. After each measurement firmware forces fan on. Due to sealing main outlets the sensor is cooled more effectively. You can also consider putting a sheet of white paper on the plate to decrease IR radiation effect during the calibration.
4. **Remove Tape:** Once finished, remove the tape, adjust Z-offset and print tests.

*This may allow you to use the entire bed surface with a single, consistent Z-offset.*
