## program:             24-overlayNGO_20170125.py
## task:                Copy and rename geodatabase
##                      Add county shape and ngo table data to geodatabase
##						Join county shape and ngo table
##						Overlay ngo and community data
##
## version:     		First Draft
## project:             Dissertation
## author:              Kate Willyard 1/25/2017
##
##
## set settings, work directories and file names
import arcpy, os, glob
from arcpy import env
projectWorkspace = "C:/Users/TXCRDC/Documents/Research/eocpc/"
workingWorkspace = projectWorkspace + "Working"
gdbOld="22-eocpc_20170116.gdb"
gdbNew="24-eocpc_20170125.gdb"
postedWorkspace = projectWorkspace + "Posted"
originalWorkspace = projectWorkspace + "Original"
countyShpWorkspace = originalWorkspace + "/stratmap_boundaries/historic"
gdbWorkspace= postedWorkspace + "/" + gdbNew
##
##
## Revise geodatabase name to reflect edits
env.workspace = postedWorkspace
arcpy.Copy_management(gdbOld, gdbNew)
##
##
## Add county shape and ngo table data to geodatabase
env.workspace = countyShpWorkspace
arcpy.FeatureClassToFeatureClass_conversion("StratMap_County_poly.shp",gdbWorkspace, "texasCounties")
env.workspace = postedWorkspace
arcpy.TableToTable_conversion("23-ngo_20170125.csv",gdbWorkspace,"texas2012ngos")
##
##
## Join county shape and ngo table
env.workspace=gdbWorkspace
arcpy.AddIndex_management("texasCounties", "NAME", "ngoIndex", "UNIQUE", "ASCENDING")
arcpy.AddIndex_management("texas2012ngos", "county", "ngoIndex", "UNIQUE", "NON_ASCENDING")
arcpy.JoinField_management("texasCounties", "NAME", "texas2012ngos", "county")
##
##
## Overlay ngo and community data
arcpy.Intersect_analysis("texasCounties #; allGasWells #", "gasWngo", "ALL", "", "INPUT")
print "done overlaying ngo & gas well data"
arcpy.Intersect_analysis("texasCounties #; allOilWells #", "oilWngo", "ALL", "", "INPUT")
print "done overlaying ngo & oil well data"
##
