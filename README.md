# anycubic-kobra-2-pro-thermal-drift-fix
Custom Start G-Code for Anycubic Kobra 2 Pro to solve inconsistent Z-offset issues by cooling down inductive sensor before printing starts. 

## Problem
During printing, the inductive sensor gets overheated by the bed and the nozzle. This causes the sensor to trigger "too high" (too early), resulting in a failed first layer if the sensor is not cooled down before the next print. This is especially critical when restarting a print immediately after a previous one.

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
