#!/bin/zsh

echo '>>> Init ...'
rm -rf .marlin-build
mkdir .marlin-build
cd .marlin-build

echo '>>> Cloning Marlin Firmware ...'
git clone --branch bugfix-2.0.x --single-branch https://github.com/MarlinFirmware/Marlin.git .

echo '>>> Updating Marlin configuration: BIQU/B1-BLTouch ...'
curl -sSL https://github.com/MarlinFirmware/Configurations/raw/import-2.0.x/config/examples/BIQU/B1-BLTouch/Configuration.h -o Marlin/Configuration.h
curl -sSL https://github.com/MarlinFirmware/Configurations/raw/import-2.0.x/config/examples/BIQU/B1-BLTouch/Configuration_adv.h -o Marlin/Configuration_adv.h

echo '>>> Use AUTO_BED_LEVELING_UBL'
sed -i.bak 's|#define AUTO_BED_LEVELING_BILINEAR|//#define AUTO_BED_LEVELING_BILINEAR|g' Marlin/Configuration.h
sed -i.bak 's|//#define AUTO_BED_LEVELING_UBL|#define AUTO_BED_LEVELING_UBL|g' Marlin/Configuration.h
sed -i.bak 's|//#define UBL_MESH_WIZARD|#define UBL_MESH_WIZARD|g' Marlin/Configuration.h

echo '>>> Enable USE_PROBE_FOR_Z_HOMING and Z_SAFE_HOMING | '
sed -i.bak 's|//#define USE_PROBE_FOR_Z_HOMING|#define USE_PROBE_FOR_Z_HOMING|g' Marlin/Configuration.h
sed -i.bak 's|//#define Z_SAFE_HOMING|#define Z_SAFE_HOMING|g' Marlin/Configuration.h
sed -i.bak 's|//#define Z_MIN_PROBE_REPEATABILITY_TEST|#define Z_MIN_PROBE_REPEATABILITY_TEST|g' Marlin/Configuration.h
sed -i.bak 's|#define MESH_INSET 1 |#define MESH_INSET 40|g' Marlin/Configuration.h

echo '>>> NOZZLE_TO_PROBE_OFFSET'
sed -i.bak 's|#define NOZZLE_TO_PROBE_OFFSET { 24, -47, -1.5 }|#define NOZZLE_TO_PROBE_OFFSET { 40, 30, -1.5 }|g' Marlin/Configuration.h

echo '>>> BMG Extruder: 415 steps'
sed -i.bak 's|#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 96 }|#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 415 }|g' Marlin/Configuration.h

echo '>>> Enable filament runout'
sed -i.bak 's|//#define FILAMENT_RUNOUT_SENSOR|#define FILAMENT_RUNOUT_SENSOR|g' Marlin/Configuration.h

echo '>>> Faster HOMING_FEEDRATE'
sed -i.bak 's|#define HOMING_FEEDRATE_MM_M { (50*60), (50*60), (4*60) }|#define HOMING_FEEDRATE_MM_M { (50*60), (50*60), (8*60) }|g' Marlin/Configuration.h

echo '>>> Enable PREHEAT_BEFORE_LEVELING'
sed -i.bak 's|//#define PREHEAT_BEFORE_LEVELING|#define PREHEAT_BEFORE_LEVELING|g' Marlin/Configuration.h
sed -i.bak 's|#define LEVELING_NOZZLE_TEMP 120|#define LEVELING_NOZZLE_TEMP 210|g' Marlin/Configuration.h
sed -i.bak 's|#define LEVELING_BED_TEMP     50|#define LEVELING_BED_TEMP     60|g' Marlin/Configuration.h

echo '>>> PREHEAT PRESETS'
sed -i.bak 's|#define PREHEAT_1_LABEL       "PLA"|#define PREHEAT_1_LABEL       "PLA"|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_1_TEMP_HOTEND 190|#define PREHEAT_1_TEMP_HOTEND 210|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_1_TEMP_BED     65|#define PREHEAT_1_TEMP_BED     60|g' Marlin/Configuration.h

sed -i.bak 's|#define PREHEAT_2_LABEL       "PETG"|#define PREHEAT_2_LABEL       "PETG"|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_2_TEMP_HOTEND 235|#define PREHEAT_2_TEMP_HOTEND 245|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_2_TEMP_BED     80|#define PREHEAT_2_TEMP_BED     70|g' Marlin/Configuration.h

sed -i.bak 's|#define PREHEAT_3_LABEL       "ABS"|#define PREHEAT_3_LABEL       "ASA"|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_3_TEMP_HOTEND 240|#define PREHEAT_3_TEMP_HOTEND 240|g' Marlin/Configuration.h
sed -i.bak 's|#define PREHEAT_3_TEMP_BED    110|#define PREHEAT_3_TEMP_BED     90|g' Marlin/Configuration.h

echo '>>> Enable Meatpack'
sed -i.bak 's|//#define MEATPACK_ON_SERIAL_PORT_1|#define MEATPACK_ON_SERIAL_PORT_1|g' Marlin/Configuration_adv.h
sed -i.bak 's|//#define MEATPACK_ON_SERIAL_PORT_2|#define MEATPACK_ON_SERIAL_PORT_2|g' Marlin/Configuration_adv.h

echo '>>> Faster BLTouch'
sed -i.bak 's|//#define BLTOUCH_DELAY 500|#define BLTOUCH_DELAY 200|g' Marlin/Configuration_adv.h

echo '>>> Setup Trinamic drivers'
sed -i.bak 's|//#define MONITOR_DRIVER_STATUS|#define MONITOR_DRIVER_STATUS|g' Marlin/Configuration_adv.h
sed -i.bak 's|//#define TMC_DEBUG|#define TMC_DEBUG|g' Marlin/Configuration_adv.h
sed -i.bak 's|#define STOP_ON_ERROR|//#define STOP_ON_ERROR|g' Marlin/Configuration_adv.h

echo '>>> Disable SDCARD'
sed -i.bak 's|#define SDSUPPORT|//#define SDSUPPORT|g' Marlin/Configuration.h
sed -i.bak 's|#define AUTO_REPORT_SD_STATUS|//#define AUTO_REPORT_SD_STATUS|g' Marlin/Configuration_adv.h

echo '>>> Building Marlin ...'
pio run -e LPC1768

echo '>>> Updating Marlin build: BIQU/B1-BLTouch ...'
cp Marlin/Configuration.h ../Configuration.h
cp Marlin/Configuration_adv.h ../Configuration_adv.h
cp .pio/build/LPC1768/firmware.bin ../firmware.bin

echo '>>> Cleaning up ...'
cd ..
rm -rf .marlin-build
