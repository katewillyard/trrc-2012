## program:             28-findComChar_20170922.py
## task:                Find community characteristics
##                          within 1 mile of gas well/oil lease
##
## version:             First Draft
## project:             Dissertation
## author:              Kate Willyard 9/22/2017
##
## set settings, work directories and file names
import arcpy, os, glob
from arcpy import env
projectWorkspace = "Z:/"
gdbOld="27-eocpc_20170126.gdb"
gdbNew="28-eocpc_20170922.gdb"
gdbWorkspace = projectWorkspace + "/" + gdbNew

##
## Revise geodatabase name to reflect edits
env.workspace = projectWorkspace
if arcpy.Exists(gdbNew):
    arcpy.Delete_management(gdbNew)
arcpy.Copy_management(gdbOld, gdbNew)
print "done copying geodatabase"
##
## Split by county and find characteristics of communities 10 miles from wells by well county
coLi = ["Anderson", "Andrews"]
coOilLi = []
coGasLi = []
countyFi = gdbWorkspace + "/texasCounties"
arcpy.MakeFeatureLayer_management(countyFi, "texasCounties")
oilFi = gdbWorkspace + "/oilLeases_1miBuf"
arcpy.MakeFeatureLayer_management(oilFi, "oilLeases_1miBuf")
gasFi = gdbWorkspace + "/gasWells_1miBuf"
arcpy.MakeFeatureLayer_management(gasFi, "gasWells_1miBuf")
blockFi = gdbWorkspace + "/censusBlocks"
arcpy.MakeFeatureLayer_management(blockFi, "censusBlocks")
for co in coLi:
    coNa = co.replace(" ", "")
    coLyr = coNa
    arcpy.MakeFeatureLayer_management("texasCounties", coLyr)
    coLyrCalc = "NAME = '" + co + "'" 
    arcpy.SelectLayerByAttribute_management(coLyr, "NEW_SELECTION", coLyrCalc)
    coFi = gdbWorkspace + "/" + coNa + "County"
    arcpy.CopyFeatures_management(coLyr, coFi)
    arcpy.Delete_management(coLyr)
    coClipPrtState = co + " county polygon created"
    print coClipPrtState
    oClip = gdbWorkspace + "/" + coNa + "OilLeases"
    arcpy.Clip_analysis("oilLeases_1miBuf", coFi, oClip)
    oClipPrtState = co + " county oil lease file created"
    print oClipPrtState
    gClip = gdbWorkspace + "/" + coNa + "GasWells"
    arcpy.Clip_analysis("gasWells_1miBuf", coFi, gClip)
    gClipPrtState = co + " county gas well file created"
    print gClipPrtState
    bClip = gdbWorkspace + "/" + coNa + "Blocks"
    arcpy.Clip_analysis("censusBlocks", coFi, bClip)
    bClipPrtState = co + " county block group file created"
    print bClipPrtState
    arcpy.Delete_management(coFi)
    bOil = gdbWorkspace + "/" + coNa + "Oil"
    oilOp = bClip + " #; " + oClip + " #"
    arcpy.Intersect_analysis(oilOp, bOil, "ALL", "", "INPUT")
    coOilLi.append(bOil)
    oOvrlyPrtState = co + " county oil - block overlay completed"
    print oOvrlyPrtState
    arcpy.Delete_management(oClip)
    bGas = gdbWorkspace + "/" + coNa + "Gas"
    gasOp = bClip + " #; " + gClip + " #"
    arcpy.Intersect_analysis(gasOp, bGas, "ALL", "", "INPUT")
    coGasLi.append(bGas)
    gOvrlyPrtState = co + " county gas - block overlay completed"
    print gOvrlyPrtState
    arcpy.Delete_management(gClip)
    arcpy.Delete_management(bClip)
    finalPrtState = "COMPLETED- " + co + " county overlay analysis"
print "COMPLETED COUNTY ANALYSIS FOR ALL TEXAS COUNTIES"
##
## Make complete gas well & oil lease file
##
print "starting to append county files to single state file for gas well data"
firstGasFi = coGasLi[0]
arcpy.CreateFeatureclass_management(gdbWorkspace, "gasBlocks", "POLYGON", firstGasFi)
outLoc = gdbWorkspace+ "/gasBlocks"
arcpy.Append_management(coGasLi, outLoc, "NO_TEST")
print "done creating single gas well file"
print "starting to append county files to single state file for oil lease data"
firstOilFi = coOilLi[0]
arcpy.CreateFeatureclass_management(gdbWorkspace, "oilBlocks", "POLYGON", firstOilFi)
outLoc = gdbWorkspace+e + "/oilBlocks"
arcpy.Append_management(coOilLi, outLoc, "NO_TEST")
print "done creating single oil lease file"
print "PROGRAM 28-findComChar_20170922.py SUCCESSFULLY RAN"
