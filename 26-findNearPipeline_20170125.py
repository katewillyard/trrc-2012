## program:		26-findNearPipeline_20170125.py
## task:		Create geodatabase
## 				Find distance to nearest pipeline
##				Export data
##
##
## version: 	First Draft
## project:		Dissertation
## author:		Kate Willyard 1/25/2017
##
## set settings, work directories and file names
import arcpy, os, glob
from arcpy import env
projectWorkspace = "C:/Users/TXCRDC/Documents/Research/eocpc/"
workingWorkspace = projectWorkspace + "Working"
bgdbOld="25-eocpc_20170125.gdb"
bgdbNew="26-eocpc_20170125.gdb"
postedWorkspace = projectWorkspace + "Posted"
originalWorkspace = projectWorkspace + "Original"
gdbWorkspace= postedWorkspace + "/" + bgdbNew
##
## Revise geodatabase name to reflect edits
env.workspace = postedWorkspace
if arcpy.Exists(bgdbNew):
    arcpy.Delete_management(bgdbNew)
arcpy.Copy_management(bgdbOld, bgdbNew)
print "done copying geodatabase"
##
## Find nearest distance between oil leases/gas wells and U.S. pipeline 
env.workspace = gdbWorkspace
arcpy.Near_analysis("gasWells_1miBuf", "pipelines", "", "NO_LOCATION", "NO_ANGLE", "GEODESIC")
print "done finding nearest distance between gas wells and US pipeline"
arcpy.Near_analysis("oilLeases_1miBuf", "pipelines", "", "NO_LOCATION", "NO_ANGLE", "GEODESIC")
print "done finding nearest distance between oil leases and US pipeline"
print "program successfully ran"
##
