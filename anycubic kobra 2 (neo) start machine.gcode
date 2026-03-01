; --- ANYCUBIC KOBRA 2 PRO THERMAL DRIFT FIX ---
; Logic: Rough Home -> Cool sensor at 100mm height -> Heat Bed -> Probe Z (Cold Sensor) -> Heat Nozzle -> Print

G90 ; Use absolute coordinates
M83 ; Extruder relative mode

; --- STEP 1: ROUGH HOMING ---
M106 S255 ; (+) Turn on part cooling fan 100%
G28 ; Home all axes (Note: Firmware turns off the fan after G28)

; --- STEP 2: ELEVATE & HEAT SOAK ---
M106 S255 ; (+) FORCE FAN ON AGAIN (Firmware disabled it during G28). Crucial for cooling!
G1 Z100 F1200 ; (+) Lift print head 100mm away from the heat of the bed

M140 S[first_layer_bed_temperature] ; Set bed temp (start heating)
G4 S60 ; (+) WAIT 60 SECONDS. Allows sensor to cool down while bed heats up.
M190 S[first_layer_bed_temperature] ; Wait for bed to reach target temp completely

; --- STEP 3: ORIGINAL KOBRA HOMING AND SETTING ZERO ---
; (+) Probing is done with a HOT BED (thermal expansion accounted for)
; (+) but with a COLD SENSOR (fan cooled) and COLD NOZZLE (no oozing)
G28;Move X/Y/Z to min endstops
G1 Z0.28 ;Lift nozzle a bit
G92 E0 ;Specify current extruder position as zero
M107 ;(+) Turn off fan (no longer needed)


; --- STEP 4: HEAT NOZZLE & PREPARE ---
M104 S[first_layer_temperature] ; Set extruder temp
M109 S[first_layer_temperature] ; Wait for extruder temp

; --- STEP 5: ORIGINAL K2(NEO) PURGE LINE ---
G1 Y3 F1800                            ; zero the extruded length 
G1 X60  E25 F500                       ; Extrude 25mm of filament in a 5cm line. 
G92 E0                                 ; zero the extruded length again 
G1 E-2 F500                            ; Retract a little 
G1 X70 F4000                           ; Quickly wipe away from the filament line
M117