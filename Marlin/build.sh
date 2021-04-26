#!/bin/zsh

rm -rf .marlin-build
mkdir .marlin-build
cd .marlin-build

echo '>>> Cloning Marlin Firmware ...'
git clone --branch bugfix-2.0.x --single-branch https://github.com/MarlinFirmware/Marlin.git .
echo '>>> Cloning Marlin Configurations ...'
git clone --branch import-2.0.x --single-branch https://github.com/MarlinFirmware/Configurations.git

echo '>>> Updating Marlin configuration: BIQU/B1-BLTouch ...'
cp Configurations/config/examples/BIQU/B1-BLTouch/Configuration.h Marlin/Configuration.h
cp Configurations/config/examples/BIQU/B1-BLTouch/Configuration_adv.h Marlin/Configuration_adv.h

echo '>>> AUTO_BED_LEVELING_UBL'
sed -i.bak 's|#define AUTO_BED_LEVELING_BILINEAR|//#define AUTO_BED_LEVELING_BILINEAR|g' Marlin/Configuration.h
sed -i.bak 's|//#define AUTO_BED_LEVELING_UBL|#define AUTO_BED_LEVELING_UBL|g' Marlin/Configuration.h

echo '>>> Z_SAFE_HOMING | USE_PROBE_FOR_Z_HOMING'
sed -i.bak 's|//#define USE_PROBE_FOR_Z_HOMING|#define USE_PROBE_FOR_Z_HOMING|g' Marlin/Configuration.h
sed -i.bak 's|//#define Z_SAFE_HOMING|#define Z_SAFE_HOMING|g' Marlin/Configuration.h
sed -i.bak 's|#define MESH_INSET 1 |#define MESH_INSET 40|g' Marlin/Configuration.h

echo '>>> NOZZLE_TO_PROBE_OFFSET'
sed -i.bak 's|#define NOZZLE_TO_PROBE_OFFSET { 24, -47, -1.5 }|#define NOZZLE_TO_PROBE_OFFSET { 40, 30, -1.5 }|g' Marlin/Configuration.h

echo '>>> BMG Extruder: 415 steps'
sed -i.bak 's|#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 96 }|#define DEFAULT_AXIS_STEPS_PER_UNIT   { 80, 80, 400, 415 }|g' Marlin/Configuration.h

echo '>>> Disabling SDCARD'
sed -i.bak 's|#define SDSUPPORT|//#define SDSUPPORT|g' Marlin/Configuration.h
sed -i.bak 's|#define AUTO_REPORT_SD_STATUS|//#define AUTO_REPORT_SD_STATUS|g' Marlin/Configuration_adv.h

echo '>>> PREHEAT_BEFORE_LEVELING'
sed -i.bak 's|//#define PREHEAT_BEFORE_LEVELING|#define PREHEAT_BEFORE_LEVELING|g' Marlin/Configuration.h
sed -i.bak 's|#define LEVELING_NOZZLE_TEMP 120|#define LEVELING_NOZZLE_TEMP 210|g' Marlin/Configuration.h
sed -i.bak 's|#define LEVELING_BED_TEMP     50|#define LEVELING_BED_TEMP     60|g' Marlin/Configuration.h

pio run -e LPC1768

echo '>>> Updating Marlin build: BIQU/B1-BLTouch ...'
cp Marlin/Configuration.h ../Configuration.h
cp Marlin/Configuration_adv.h ../Configuration_adv.h
cp .pio/build/LPC1768/firmware.bin ../firmware.bin

read -s -k '?Press any key to continue.'

cd ..
rm -rf .marlin-build
