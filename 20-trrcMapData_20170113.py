## program:		20-trrcMapData_20170113.py
## task:		Create geodatabase
## 				Make state map of well data and export
##
##
## version: 	First Draft
## project:		Dissertation
## author:		Kate Willyard 1/13/2017
##
## set settings, spatial reference, work directories and file names
import arcpy, os, glob
from arcpy import env
projectWorkspace = "Z:/eocpc"
workingWorkspace = projectWorkspace + "/Working"
bgdb="20-eocpc_20170113.gdb"
postedWorkspace = projectWorkspace + "/Posted"
originalWorkspace = projectWorkspace + "/Original"
workingWorkspace = projectWorkspace + "/Working"
gdbPostedWorkspace= postedWorkspace + "/" + bgdb
gdbWorkingWorkspace = workingWorkspace + "/" + bgdb
arcpy.env.outputCoordinateSystem = arcpy.SpatialReference(4269)
##
## Create working and posted geodatabase
env.workspace = workingWorkspace
if arcpy.Exists(bgdb):
    arcpy.Delete_management(bgdb)
arcpy.CreateFileGDB_management(workingWorkspace, bgdb)
env.workspace = postedWorkspace
if arcpy.Exists(bgdb):
    arcpy.Delete_management(bgdb)
arcpy.CreateFileGDB_management(postedWorkspace, bgdb)
##
## Make map well surface locations 
## Shape files in original folder count odd numbers from 001-507 (so count range 0-508)
env.workspace = gdbWorkingWorkspace
wellFeaList = []
for h in range (6):
	for d in range (10):
		for s in range (10):
			if s % 2 != 0:
				outname = str(h) + str(d) + str(s)
				outno = int(outname)
				if outno < 508:
					outFea = "well" + outname
					wellFeaList.append(outFea)
					inShp = outFea + "s.shp"
					inShpLoc = originalWorkspace + "/" + inShp
					arcpy.MakeFeatureLayer_management(inShpLoc,outname)
					arcpy.SelectLayerByAttribute_management(outname, "NEW_SELECTION", "\"API\" <> '001'")
					arcpy.CopyFeatures_management(outname, outFea)
## Make state map of all state files
outShp = "allWellSurfLoc"
well = wellFeaList[0]
emptyFC = arcpy.CreateFeatureclass_management(gdbPostedWorkspace, outShp, "POINT", well)
arcpy.Append_management(wellFeaList, emptyFC, "NO_TEST")
##
##
## After file is run, go to attribute table and export as "20-allWellSurfLoc_20170113.txt"
