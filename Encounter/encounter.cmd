#######################################################
#                                                     
#  Encounter Command Logging File                     
#  Created on Fri Apr  5 12:11:28 2019                
#                                                     
#######################################################

#@(#)CDS: Encounter v14.28-s033_1 (64bit) 03/21/2016 13:34 (Linux 2.6.18-194.el5)
#@(#)CDS: NanoRoute v14.28-s005 NR160313-1959/14_28-UB (database version 2.30, 267.6.1) {superthreading v1.25}
#@(#)CDS: CeltIC v14.28-s006_1 (64bit) 03/08/2016 00:08:23 (Linux 2.6.18-194.el5)
#@(#)CDS: AAE 14.28-s002 (64bit) 03/21/2016 (Linux 2.6.18-194.el5)
#@(#)CDS: CTE 14.28-s007_1 (64bit) Mar  7 2016 23:11:05 (Linux 2.6.18-194.el5)
#@(#)CDS: CPE v14.28-s006
#@(#)CDS: IQRC/TQRC 14.2.2-s217 (64bit) Wed Apr 15 23:10:24 PDT 2015 (Linux 2.6.18-194.el5)

set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
set_global _enable_mmmc_by_default_flow      $CTE::mmmc_default
suppressMessage ENCEXT-2799
set init_verilog UART.vh
set init_top_cell UART
set init_lef_file /clear/apps/osu/soc/cadence/lib/ami05/lib/osu05_stdcells.lef
set init_gnd_net gnd
set init_design_settop 0
set init_pwr_net vdd
init_design
saveDesign UART.enc
getIoFlowFlag
setIoFlowFlag 0
floorPlan -r 1.0 0.6 21 21 21 21
uiSetTool select
getIoFlowFlag
fit
clearGlobalNets
globalNetConnect gnd -type pgpin -pin gnd -inst *
globalNetConnect vdd -type pgpin -pin vdd -inst *
set sprCreateIeRingNets {}
set sprCreateIeRingLayers {}
set sprCreateIeRingWidth 1.2
set sprCreateIeRingSpacing 1.2
set sprCreateIeRingOffset 1.2
set sprCreateIeRingThreshold 1.2
set sprCreateIeRingJogDistance 1.2
setAddRingMode -stacked_via_top_layer metal3
setAddRingMode -stacked_via_bottom_layer metal1
addRing -skip_via_on_wire_shape Noshape -skip_via_on_pin Standardcell -center 1 -type core_rings -jog_distance 1.8 -threshold 1.8 -nets {gnd vdd} -follow core -layer {bottom metal1 top metal1 right metal2 left metal2} -width 6.0 -spacing 1.2 -offset 1.8
placeDesign
sroute -nets {vdd gnd}
saveDesign UART.enc
addFiller -cell FILL -prefix FILLER -markFixed
routeDesign -globalDetail
verifyGeometry
verifyConnectivity -type all -noAntenna
setStreamOutMode -snapToMGrid true -supportPathType4 false
streamOut final.gds -mapFile /clear/apps/osu/soc/cadence/flow/ami05/gds2_encounter.map -libName DesignLib -units 100 -merge /clear/apps/osu/soc/cadence/lib/source/gds2/osu05_stdcells.gds2 -mode ALL
saveNetlist final.v
saveDesign UART.enc
win
