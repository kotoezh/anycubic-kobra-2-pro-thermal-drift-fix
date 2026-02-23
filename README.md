# anycubic-kobra-2-pro-thermal-drift-fix
Start machine G-code to cool down inductive sensor before printing starts to get stable Z-axis zero

Custom Start G-Code for Anycubic Kobra 2 Pro(/Plus/Max?) to solve inconsistent Z-offset issues. 
**Problem**
During printing or fast restarts, the inductive sensor gets overheated by the bed and nozzle, causing it to trigger "high" and ruin the first layer. 
**Solution**
This script implements a "Cold Probe" strategy: it actively cools the sensor at 100mm height before homing, ensuring a stable and repeatable Z-offset regardless of machine temperature.
**Details**
The base start machine G-Code script is inherited from Anycubic Slicer Next 1.3.6.1 settings for Kobra 2 Pro
Added lines are marked with (+) so you can try implementing this strategy in any other start G-Code
