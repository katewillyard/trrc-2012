## program:		22-add2GDB_20170116.py
## task:		Add extracted csv data to geodatabase
##				Add original features to geodatabase
##				Add XY data to geodatabase
##				Make single oil well file (since it uses both nad27 & nad 83 datum)
##				Shorten ACS to only needed variables 
##
## version: 	First Draft
## project:		Dissertation
## author:		Kate Willyard 1/16/2017
##
## Set Settings, Work Directories and File Names
import arcpy, os, glob
from arcpy import env
workingWorkspace = "C:/Users/TXCRDC/Documents/Research/eocpc/Working"
bgdb="22-eocpc_20170116.gdb"
postedWorkspace = "C:/Users/TXCRDC/Documents/Research/eocpc/Posted"
originalWorkspace = "C:/Users/TXCRDC/Documents/Research/eocpc/Original"
tableList = ["21-gas83_20170115.csv", "21-oil83_20170115.csv", "21-oil27_20170115.csv"]
tblOutName = ["allGas", "oil83", "oil27"]
acsTableList = [""]
acsGdb = "ACS_2014_5YR_BG_48_TEXAS.gdb"
acsShp = "ACS_2014_5YR_BG_48_TEXAS"
acsWorkspace = originalWorkspace + "/" + acsGdb
acsTblList = ["BG_METADATA_2014", "X00_COUNTS", "X01_AGE_AND_SEX", "X02_RACE", "X03_HISPANIC_OR_LATINO_ORIGIN", "X15_EDUCATIONAL_ATTAINMENT", "X16_LANGUAGE_SPOKEN_AT_HOME", "X17_POVERTY", "X19_INCOME", "X23_EMPLOYMENT_STATUS", "X24_INDUSTRY_OCCUPATION", "X25_HOUSING_CHARACTERISTICS"]
spaRefFi = acsWorkspace + "/" + acsShp
spaRef = arcpy.Describe(spaRefFi).spatialReference
spaRefName = arcpy.Describe(spaRefFi).spatialReference.name
arcpy.env.outputCoordinateSystem = spaRef
if spaRefName != arcpy.SpatialReference(4269).name:
	print "Error with Spatial Reference Match"
	print("ACS Spatial Reference {0}".format(arcpy.Describe(spaRefFi).spatialReference.name))
	print("WGS Spatial Reference: {0}".format(arcpy.SpatialReference(4269).name))
gdbWorkspace= postedWorkspace + "/" + bgdb
dcFile = originalWorkspace + "/Census/Tract_2010Census_DP1.shp"
tigerWorkspace = originalWorkspace + "/TIGER"
pipelineFile = originalWorkspace + "/Pipelines/NaturalGas_InterIntrastate_Pipelines_US.shp"
##
## Create a Geodatabase
env.workspace = postedWorkspace
if arcpy.Exists(bgdb):
    arcpy.Delete_management(bgdb)
arcpy.CreateFileGDB_management(postedWorkspace, bgdb)
##
## Add Extracted Tables to Geodatabase
env.workspace = postedWorkspace
for n in range(0,3): 
	arcpy.TableToTable_conversion(tableList[n],gdbWorkspace,tblOutName[n])
env.workspace = acsWorkspace
for n in range(0,12): 
	arcpy.TableToTable_conversion(acsTblList[n],gdbWorkspace,acsTblList[n])
## 
## Add Features to Geodatabase
arcpy.FeatureClassToFeatureClass_conversion(acsShp, gdbWorkspace, "acs")
env.workspace = gdbWorkspace
dcOut=gdbWorkspace + "/dc"
arcpy.Clip_analysis(dcFile, "acs", dcOut)
env.workspace = tigerWorkspace
arcpy.FeatureClassToFeatureClass_conversion("tl_2012_48_tabblock.shp", gdbWorkspace, "censusBlocks")
arcpy.FeatureClassToFeatureClass_conversion(pipelineFile,gdbWorkspace, "pipelines")
env.workspace = gdbWorkspace
arcpy.Clip_analysis("pipelines", "acs", "txPipes")
##
## Add XY Data for Wells
## Add Gas Well NAD 83 Spatial Reference Point Data
spRef83 = arcpy.SpatialReference(4269)
env.workspace = gdbWorkspace
table_dbf = tblOutName[0]
newName = tblOutName[0] + "Wells"
table_layer = newName + "Layer"
point_shp = newName + ".shp"
arcpy.MakeXYEventLayer_management(table_dbf, "nad83long", "nad83lat", table_layer, spRef83, "")
arcpy.CopyFeatures_management(table_layer, point_shp, "", "0", "0", "0")
env.workspace = postedWorkspace
arcpy.FeatureClassToFeatureClass_conversion(point_shp, gdbWorkspace, newName)
gas83 = newName
fi2remove = postedWorkspace + "/" + newName + "*"
for fi in glob.glob(fi2remove):
    os.remove(fi)
## Add Oil Well NAD 83 Spatial Reference Point Data
env.workspace = gdbWorkspace
table_dbf = tblOutName[1]
newName = tblOutName[1] + "Well"
table_layer = newName + "Layer"
point_shp = newName + ".shp"
oil83 = newName
arcpy.MakeXYEventLayer_management(table_dbf, "nad83long", "nad83lat", table_layer, spRef83, "")
arcpy.CopyFeatures_management(table_layer, point_shp, "", "0", "0", "0")
env.workspace = postedWorkspace
arcpy.FeatureClassToFeatureClass_conversion(point_shp, gdbWorkspace, newName)
fi2remove = postedWorkspace + "/" + newName + "*"
for fi in glob.glob(fi2remove):
    os.remove(fi)
## Add Oil Well NAD 27 Spatial Reference Point Data
spRef27 = arcpy.SpatialReference(4267)
env.workspace = postedWorkspace 
table_dbf = tableList[2]
newName = tblOutName[2] + "Well"
table_layer = newName + "Layer"
point_shp = newName + ".shp"
oil27 = newName
arcpy.MakeXYEventLayer_management(table_dbf, "nad27long", "nad27lat", table_layer, spRef27, "")
arcpy.CopyFeatures_management(table_layer, point_shp, "", "0", "0", "0")
point_transformed = newName + "trans.shp"
arcpy.Project_management(point_shp, point_transformed, spRef83)
arcpy.FeatureClassToFeatureClass_conversion(point_transformed, gdbWorkspace, newName)
fi2remove = postedWorkspace + "/" + newName + "*"
for fi in glob.glob(fi2remove):
    os.remove(fi)
##
## Make point data of all oil wells
    env.workspace = gdbWorkspace
oil83Well = tblOutName[1] + "Well"
oil27Well = tblOutName[2] + "Well"
arcpy.DeleteField_management(oil83Well, ["lease_numb", "latitudeda", "longituded", "permitPRma", "completi_3", "long83","lat83", "nad83lat", "nad83long"])
arcpy.DeleteField_management(oil27Well, ["lease_numb", "latitudeda", "longituded", "permitPRma", "completi_3", "long83","lat83", "nad83lat", "nad83long"])
arcpy.CreateFeatureclass_management(gdbWorkspace,"allOilWells", "POINT", oil27Well, "DISABLED", "DISABLED", spRef83)
arcpy.Append_management([oil83Well, oil27Well], "allOilWells", "NO_TEST")
## 
