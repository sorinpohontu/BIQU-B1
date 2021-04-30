# Bigtree BIQU-B1 3D Printer

- [BIQU B1 Product page @biqu.equipment](https://www.biqu.equipment/collections/3d-printer/products/biqu-b1-3d-printer-skr-v1-4-32bit-motherboard-tft35-b1-v3-0-dual-operation-system-fdm-impressora-3d-vs-ender3-v2-beginner)
- [BIQU B1 GitHub](https://github.com/bigtreetech/BIQU-B1)

## Reviews
- [All3DP: Biqu B1 Review: Hot, (Not) Pink](https://all3dp.com/1/biqu-b1-review-3d-printer-specs/)
- [3D Print Beginner: BIQU B1 Review: Ender 3 V2 Killer?](https://3dprintbeginner.com/biqu-b1-review-ender-3-v2-killer/)
- [3dprinting.com: Hands-On Review](https://3dprinting.com/3dprinters/hands-on-review-biqu-b1/)
- [BIQU B1: The review on damsteen.nl](https://damsteen.nl/blog/2020/10/18/biqu-b1-review)
- [Reviews of BIQU B1 on 3DJake](https://www.3djake.com/reviews/biqu/b1?lang=all)
- [Reddit](https://www.reddit.com/r/BIGTREETECH/comments/jh25l0/must_have_upgrades_for_biqu_b1/)


## General
The printer it's based on Creality Ender 3x, with a few upgrades already installed.
- Max print size: bed size 235x235mm, height: 270mm
- Mainboard: [BIGTREETECH SKR 1.4]() board with TMC2225 (an upgraded version of TMC2208, see [FYSETC Silent2225](https://wiki.fysetc.com/TMC2225/))

Be prepared for a few upgrades (see comments on 3DJake or Reddit)

# Parts and upgrades

## Bed
Heated bed has same size and physical dimensions as Creality Ender 3x.  
A great build plate is [BIQU SSS Super Spring Steel Sheet](https://www.biqu.equipment/products/biqu-sss-super-spring-steel-sheet-heated-bed-build-plate-platform-235x245mm-printer-parts-for-filament-ender-3-3-printer) (recommended for any printer).

## Hotend
- [Chimera Hotend](https://www.biqu.equipment/products/chimera-hotend-12-24v-j-head-bowden-extruder-kits-mk8-nozzle-chimera-pipe-for-3d-printer-parts-e3d-hotend-upgrade)

### Hotend fixes
- https://www.thingiverse.com/thing:4626617
- https://www.thingiverse.com/thing:4837928

# Marlin

## [Unified Bed Leveling](https://marlinfw.org/docs/features/unified_bed_leveling.html)

;------------------------------------------
;--- Setup and initial probing commands ---
;------------------------------------------
M190 S60        ; Not required, but having the printer at temperature helps accuracy
M104 S200       ; Not required, but having the printer at temperature helps accuracy

G28             ; Home XYZ.
G29 P1          ; Do automated probing of the bed.
G29 S1          ; Save UBL mesh points to EEPROM.
M500            ; Save current setup. WARNING: UBL will be active at power up, before any `G28`

# References
    - https://3dwork.io/en/complete-guide-skr-v1-4-and-tmc2209
    - https://www.jayuk.org/bigtreetech-skr-v1-4-normal-and-turbo-and-fysetc-tmc2209-v3
    - https://3dprintbeginner.com/biqu-b1-hotend-fix-bi-metal-heat-break/
    - https://www.reddit.com/r/BIGTREETECH/comments/j55rt3/biqub1_firmware_updating_bltouch_guide_a/

    - https://github.com/MarlinFirmware/Configurations/tree/import-2.0.x/config/examples/BIQU/B1-BLTouch
