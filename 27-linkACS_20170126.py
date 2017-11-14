## program:             27-linkACS_20170126.py
## task:                Link ACS tables
##
## version:             First Draft
## project:             Dissertation
## author:              Kate Willyard 1/26/2017
##
## set settings, work directories and file names
import arcpy, os, glob
from arcpy import env
projectWorkspace = "Z:/eocpc/"
workingWorkspace = projectWorkspace + "Working"
gdbOld="26-eocpc_20170125.gdb"
gdbNew="27-eocpc_20170126.gdb"
postedWorkspace = projectWorkspace + "Posted"
originalWorkspace = projectWorkspace + "Original"
gdbWorkspace= postedWorkspace + "/" + gdbNew
##
## Revise geodatabase name to reflect edits
env.workspace = postedWorkspace
if arcpy.Exists(gdbNew):
    arcpy.Delete_management(gdbNew)
arcpy.Copy_management(gdbOld, gdbNew)
print "done copying geodatabase"
##
## Simplify and Match Community Data
env.workspace=gdbWorkspace
arcpy.AddIndex_management("acs", "GEOID_Data", "geoIndex", "UNIQUE", "NON_ASCENDING")
## Simplify and match X01_AGE_AND_SEX 
inTab = "X01_AGE_AND_SEX"
newTab = "age"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
stna = "B01001"
for n in range(1,50):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        if estna == "B01001e1":
                arcpy.AlterField_management(newTab, "B01001e1", new_field_alias="totalPeople")
                arcpy.AlterField_management(newTab, "B01001e1", "totalPeople")
                arcpy.AddField_management(newTab, "sumOver65", "LONG", "", "", "", "", "NULLABLE", "NON_REQUIRED", "")
                calc = "[B01001e20] + [B01001e21] + [B01001e23] + [B01001e24] + [B01001e25] + [B01001e44] + [B01001e45] + [B01001e46] + [B01001e47] + [B01001e48] + [B01001e49]"
                arcpy.CalculateField_management(newTab, "sumOver65", calc, "VB", "")
        else:
                delList.append(estna)
stna = "B01002"
for n in range(1,4):
        toAdd = stna + "e" + str(n)
        delList.append(toAdd)
        toAdd = stna + "m" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Ae" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Am" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Be" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Bm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Ce" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Cm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "De" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Dm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Ee" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Em" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Fe" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Fm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Ge" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Gm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "He" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Hm" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Ie" + str(n)
        delList.append(toAdd)
        toAdd = stna + "Im" + str(n)
        delList.append(toAdd)
delList.append("B01003e1")
delList.append("B01003m1")
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging age table to acs .shp"
## Simplify and match X02_RACE
inTab = "X02_RACE"
newTab = "race"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
stna = "B02001"
for n in range(1,11):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(estna)
        delList.append(mena)
for n in range(8,10):
        estna = "B0200" + str(n) + "e1"
        mena = "B0200" + str(n) + "m1"
        delList.append(mena)
        if estna == "B02009e1":
                arcpy.AlterField_management(newTab, "B02009e1", new_field_alias="sumBlack")
                arcpy.AlterField_management(newTab, "B02009e1", "sumBlack")
        else:
                delList.append(estna)
for n in range(10,14):
        estna = "B020" + str(n) + "e1"
        delList.append(estna)
        mena = "B020" + str(n) + "m1"
        delList.append(mena)
stna = "C02003"
for n in range(1,20):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(estna)
        delList.append(mena)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging race table to acs .shp"
## Simplify and match X03_HISPANIC_OR_LATINO_ORIGIN
inTab = "X03_HISPANIC_OR_LATINO_ORIGIN"
newTab = "ethnicity"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
stna = "B03002"
for n in range(1,22):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(estna)
        delList.append(mena)
        if estna == "B03002e3":
                arcpy.AlterField_management(newTab, "B03002e3", new_field_alias="sumWhiteNonHisp")
                arcpy.AlterField_management(newTab, "B03002e3", "sumWhiteNonHisp")
        else:
                delList.append(estna)
stna = "B03002"
for n in range(1,3):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        if estna == "B003003e3":
                arcpy.AlterField_management(newTab, "B03003e3", new_field_alias="sumHisp")
                arcpy.AlterField_management(newTab, "B03003e3", "sumHisp")
        else:
                delList.append(estna)
stna = "B03003"
for n in range (1,4):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(estna)
        delList.append(mena)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging ethnicity table to acs .shp"
## Simplify and match X15_EDUCATIONAL_ATTAINMENT
inTab = "X15_EDUCATIONAL_ATTAINMENT"
newTab = "education"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
stna = "B15002"
for n in range(1,36):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        if estna == "B15002e1":
                arcpy.AlterField_management(newTab, "B15002e1", new_field_alias="sumOver25")
                arcpy.AlterField_management(newTab, "B15002e1", "sumOver25")
                arcpy.AddField_management(newTab, "sumOver25noHSdiploma", "SHORT")
                calc = "[B15002e2] + [B15002e3] + [B15002e4] + [B15002e5] + [B15002e6] + [B15002e7] + [B15002e8] + [B15002e9] + [B15002e10] + [B15002e20] + [B15002e21] + [B15002e22]+ [B15002e23]+ [B15002e24] + [B15002e25] + [B15002e26] + [B15002e27]"
                arcpy.CalculateField_management(newTab, "sumOver25noHSdiploma", calc, "VB", "")
        else:
                delList.append(estna)
stna = "B15003"
for n in range(1,26):
        estna = stna + "e" + str(n) 
        mena = stna + "m" + str(n) 
        delList.append(mena)
        delList.append(estna)
stna = "B15011"
for n in range(1,40):
        estna = stna + "e" + str(n) 
        mena = stna + "m" + str(n) 
        delList.append(mena)
        delList.append(estna)
stna = "B15012"
for n in range(1,17):
        estna = stna + "e" + str(n) 
        mena = stna + "m" + str(n) 
        delList.append(mena)
        delList.append(estna)
stna = "C15010"
for n in range(1,7):
        estna = stna + "e" + str(n) 
        mena = stna + "m" + str(n) 
        delList.append(mena)
        delList.append(estna)
alphaList = ["A", "B", "C", "D", "E", "F", "G", "H", "I"]
stna = "C15010" 
for n in range(1,7):
        for l in alphaList:
                estna = stna + l + "e" + str(n) 
                mena = stna + l + "m" + str(n) 
                delList.append(mena)
                delList.append(estna)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging education table to acs .shp"
## Simplify and match X16_LANGUAGE_SPOKEN_AT_HOME
inTab = "X16_LANGUAGE_SPOKEN_AT_HOME"
newTab = "fluency"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
stna = "B16002"
for n in range(1,15):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        if estna == "B16002e1":
                arcpy.AlterField_management(newTab, "B16002e1", new_field_alias="totalHousehold")
                arcpy.AlterField_management(newTab, "B16002e1", "totalHouseholds")
                arcpy.AddField_management(newTab, "sumLimitedEnglishHouseholds", "SHORT")
                calc = "[B16002e4] + [B16002e7] + [B16002e10] + [B16002e13]"
                arcpy.CalculateField_management(newTab, "sumLimitedEnglishHouseholds", calc)
        else:
                delList.append(estna)
stna = "B16004"
for n in range(1,68):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging fluency table to acs .shp"
## Simplify and match X17_POVERTY
inTab = "X17_POVERTY"
newTab = "poverty"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = []
arcpy.AddField_management(newTab, "sumBelowPoverty", "SHORT")
calc = "[C17002e2] + [C17002e3]"
arcpy.CalculateField_management(newTab, "sumBelowPoverty", calc)
stna = "C17002"
for n in range(1,9):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B17010"
for n in range(1,42):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B17011"
for n in range(1,6):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B17017"
for n in range(1,60):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B17021"
for n in range(1,36):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging poverty table to acs .shp"
## Simplify and match X19_INCOME
inTab = "X19_INCOME"
newTab = "income"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList = ["B19001e1", "B19001m1"]
arcpy.AlterField_management(newTab, "B19001e2", new_field_alias="houseIncomeLess10K")
arcpy.AlterField_management(newTab, "B19001e2", "houseIncomeLess10K")
arcpy.AlterField_management(newTab, "B19001e3", new_field_alias="houseIncome10Kto14999")
arcpy.AlterField_management(newTab, "B19001e3", "houseIncome10Kto14999")
arcpy.AlterField_management(newTab, "B19001e4", new_field_alias="houseIncome15Kto19999")
arcpy.AlterField_management(newTab, "B19001e4", "houseIncome15Kto19999")
arcpy.AlterField_management(newTab, "B19001e5", new_field_alias="houseIncome20Kto24999")
arcpy.AlterField_management(newTab, "B19001e5", "houseIncome20Kto24999")
arcpy.AlterField_management(newTab, "B19001e6", new_field_alias="houseIncome25Kto29999")
arcpy.AlterField_management(newTab, "B19001e6", "houseIncome25Kto29999")
arcpy.AlterField_management(newTab, "B19001e7", new_field_alias="houseIncome30Kto34999")
arcpy.AlterField_management(newTab, "B19001e7", "houseIncome30Kto34999")
arcpy.AlterField_management(newTab, "B19001e8", new_field_alias="houseIncome35Kto39999")
arcpy.AlterField_management(newTab, "B19001e8", "houseIncome35Kto39999")
arcpy.AlterField_management(newTab, "B19001e9", new_field_alias="houseIncome40Kto44999")
arcpy.AlterField_management(newTab, "B19001e9", "houseIncome40Kto44999")
arcpy.AlterField_management(newTab, "B19001e10", new_field_alias="houseIncome45Kto49999")
arcpy.AlterField_management(newTab, "B19001e10", "houseIncome45Kto49999")
arcpy.AlterField_management(newTab, "B19001e11", new_field_alias="houseIncome50Kto59999")
arcpy.AlterField_management(newTab, "B19001e11", "houseIncome50Kto59999")
arcpy.AlterField_management(newTab, "B19001e12", new_field_alias="houseIncome60Kto74999")
arcpy.AlterField_management(newTab, "B19001e12", "houseIncome60Kto74999")
arcpy.AlterField_management(newTab, "B19001e13", new_field_alias="houseIncome75Kto99999")
arcpy.AlterField_management(newTab, "B19001e13", "houseIncome75Kto99999")
arcpy.AlterField_management(newTab, "B19001e14", new_field_alias="houseIncome100Kto124999")
arcpy.AlterField_management(newTab, "B19001e14", "houseIncome100Kto124999")
arcpy.AlterField_management(newTab, "B19001e15", new_field_alias="houseIncome125Kto149999")
arcpy.AlterField_management(newTab, "B19001e15", "houseIncome125Kto149999")
arcpy.AlterField_management(newTab, "B19001e16", new_field_alias="houseIncome150Kto199999")
arcpy.AlterField_management(newTab, "B19001e16", "houseIncome150Kto199999")
arcpy.AlterField_management(newTab, "B19001e17", new_field_alias="houseIncomeMore200K")
arcpy.AlterField_management(newTab, "B19001e17", "houseIncomeMore200K")
stna = "B19001"
for n in range(2,18):
        mena = stna + "m" + str(n)
        delList.append(mena)
delList.append("B19013e1")
delList.append("B19013m1")
stna = "B19013"
alphaList = ["A","B","C","D","E","F","G","H","I"]
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(estna)
        delList.append(mena)
stna = "B19025"
delList.append("B19025e1")
delList.append("B19025em")
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(estna)
        delList.append(mena)
stna = "B19037"
for n in range(1,70):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B19049"
for n in range(1,6):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna = "B19050"
for n in range(1,6):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stnaList = ["B19051","B19052","B19053","B19054","B19055", "B19056", "B19057","B19059","B19060"]
for stna in stnaList:
        for n in range(1,4):
                estna = stna + "e" + str(n)
                mena = stna + "m" + str(n)
                delList.append(mena)
                delList.append(estna)
li = ["1","2","3","4","5","6","7","9"]
stna = "B1906"
for l in li:
        estna = stna + "e" + l
        mena = stna + "m" + l
        delList.append(estna)
        delList.append(mena)
delList.append("B19069e1")
delList.append("B19069m1")
delList.append("B19070e1")
delList.append("B19070m1")
delList.append("B19202e1")
delList.append("B19202m1")
stna = "B1906"
for n in range(1,8):
        estna = stna + str(n) + "e1" 
        mena = stna + str(n) + "m1" 
        delList.append(mena)
        delList.append(estna)
stna = "B19101"
for n in range(1,18):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna="B19113"
mena = stna + "e1"
estna = stna + "m1"
delList.append(mena)
delList.append(estna)
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(mena)
        delList.append(estna)
delList.append("B19127e1")
delList.append("B19127m1")
stna="B19201"
for n in range(1,18):
        estna = stna + "e" + str(n)
        mena = stna + "m" + str(n)
        delList.append(mena)
        delList.append(estna)
stna="B19202"
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(mena)
        delList.append(estna)
delList.append("B19214e1")
delList.append("B19214m1")
stna="B19301"
mena = stna + "e1"
estna = stna + "m1"
delList.append(mena)
delList.append(estna)
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(mena)
        delList.append(estna)
stna="B19313"
mena = stna + "e1"
estna = stna + "m1"
delList.append(mena)
delList.append(estna)
for l in alphaList:
        estna = stna + l + "e1"
        mena = stna + l + "m1"
        delList.append(mena)
        delList.append(estna)        
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging income table to acs .shp"
## Simplify and match X24_INDUSTRY_OCCUPATION
inTab = "X24_INDUSTRY_OCCUPATION"
newTab = "occupation"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
arcpy.AddField_management(newTab, "sumConstructExtractOcc", "SHORT")
calc = "[C24010e32] + [C24010e68]"
arcpy.CalculateField_management(newTab, "sumConstructExtractOcc", calc)
delList = []
stna = "C24010"
for n in range(1,74):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "C24010"
alphaList = ["A","B","C","D","E","F","G","H","I"]
for n in range(1,14):
        for l in alphaList:
                estna = stna + l + "e" + str(n)
                mena = stna + l + "m" + str(n)
                delList.append(estna)
                delList.append(mena)
stna = "C24020" 
for n in range(1,74):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "C24030"
for n in range(1,56):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B24080"
for n in range(1,22):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging occupation table to acs .shp"
## Simplify and match X25_HOUSING_CHARACTERISTICS
inTab = "X25_HOUSING_CHARACTERISTICS"
newTab = "housing"
arcpy.TableToTable_conversion(inTab,gdbWorkspace,newTab)
env.workspace= gdbWorkspace
arcpy.AddIndex_management(inTab, "GEOID", "geoIndex", "UNIQUE")
delList=[]
stna = "B2500"
for n in range(1,4):
        for m in range(1,4):
                mena = stna + str(m) + "m" + str(n)
                estna = stna + str(m) + "e" + str(n)
                delList.append(mena)
                delList.append(estna)
stna = "B25003"
for l in alphaList:
        for n in range(1,4):
                mena = stna + l + "m" + str(n)
                estna = stna + l + "e" + str(n)
                delList.append(mena)
                delList.append(estna)
stna = "B25004"
for n in range(1,9):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25006"
for n in range(1,11):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25007"
for n in range(1,22):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25008"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25009"
for n in range(1,18):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25010"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25014"
for n in range(1,14):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25015"
for n in range(1,28):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25016"
for n in range(1,20):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25017"
for n in range(1,11):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25018e1")
delList.append("B25018m1")
delList.append("B25019e1")
delList.append("B25019m1")
stna = "B25020"
for n in range(1,22):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25021"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25022"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25024"
for n in range(1,12):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25032"
for n in range(1,24):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25033"
for n in range(1,14):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25034"
for n in range(1,11):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25035e1")
delList.append("B25035m1")
stna = "B25036"
for n in range(1,22):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25037"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25038"
for n in range(1,16):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25039"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25040"
for n in range(1,11):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25041"
for n in range(1,8):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25042"
for n in range(1,16):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25043"
for n in range(1,20):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25044"
for n in range(1,16):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25045"
for n in range(1,20):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25046"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25047"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25049"
for n in range(1,8):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25050"
for n in range(1,20):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25051"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25053"
for n in range(1,8):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25054"
for n in range(1,8):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25055"
for n in range(1,14):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25056"
for n in range(1,25):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B250"
for n in range(57,61):
        mena = stna + str(n) + "m1"
        delList.append(mena)
        estna = stna + str(n) + "e1"
        delList.append(estna)
stna = "B25061"
for n in range(1,23):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25062e1")
delList.append("B25062m1")
stna = "B25063"
for n in range(1,25):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25064e1")
delList.append("B25064m1")
delList.append("B25065e1")
delList.append("B25065m1")
stna = "B25066"
for n in range(1,8):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25067"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25068"
for n in range(1,38):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25069"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25070"
for n in range(1,12):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25071e1")
delList.append("B25071m1")
stna = "B25072"
for n in range(1,30):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25074"
for n in range(1,65):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25075e1")
delList.append("B25075m1")
stna = "B25075"
for n in range(1,26):
        mena = stna + "m" + str(n)
        delList.append(mena)
arcpy.AlterField_management(newTab, "B25075e2", new_field_alias="oohuLess10K")
arcpy.AlterField_management(newTab, "B25075e2", "oohuLess10K")
arcpy.AlterField_management(newTab, "B25075e3", new_field_alias="oohu10Kto14999")
arcpy.AlterField_management(newTab, "B25075e3", "oohu10Kto14999")
arcpy.AlterField_management(newTab, "B25075e4", new_field_alias="oohu15Kto19999")
arcpy.AlterField_management(newTab, "B25075e4", "oohu15Kto19999")
arcpy.AlterField_management(newTab, "B25075e5", new_field_alias="oohu20Kto24999")
arcpy.AlterField_management(newTab, "B25075e5", "oohu20Kto24999")
arcpy.AlterField_management(newTab, "B25075e6", new_field_alias="oohu25Kto29999")
arcpy.AlterField_management(newTab, "B25075e6", "oohu25Kto29999")
arcpy.AlterField_management(newTab, "B25075e7", new_field_alias="oohu30Kto34999")
arcpy.AlterField_management(newTab, "B25075e7", "oohu30Kto34999")
arcpy.AlterField_management(newTab, "B25075e8", new_field_alias="oohu35Kto39999")
arcpy.AlterField_management(newTab, "B25075e8", "oohu35Kto39999")
arcpy.AlterField_management(newTab, "B25075e9", new_field_alias="oohu40Kto49999")
arcpy.AlterField_management(newTab, "B25075e9", "oohu40Kto49999")
arcpy.AlterField_management(newTab, "B25075e10", new_field_alias="oohu50Kto59999")
arcpy.AlterField_management(newTab, "B25075e10", "oohu50Kto59999")
arcpy.AlterField_management(newTab, "B25075e11", new_field_alias="oohu60Kto69999")
arcpy.AlterField_management(newTab, "B25075e11", "oohu60Kto69999")
arcpy.AlterField_management(newTab, "B25075e12", new_field_alias="oohu70Kto79999")
arcpy.AlterField_management(newTab, "B25075e12", "oohu70Kto79999")
arcpy.AlterField_management(newTab, "B25075e13", new_field_alias="oohu80Kto89999")
arcpy.AlterField_management(newTab, "B25075e13", "oohu80Kto89999")
arcpy.AlterField_management(newTab, "B25075e14", new_field_alias="oohu90Kto99999")
arcpy.AlterField_management(newTab, "B25075e14", "oohu90Kto99999")
arcpy.AlterField_management(newTab, "B25075e15", new_field_alias="oohu100Kto124999")
arcpy.AlterField_management(newTab, "B25075e15", "oohu100Kto124999")
arcpy.AlterField_management(newTab, "B25075e16", new_field_alias="oohu125Kto149999")
arcpy.AlterField_management(newTab, "B25075e16", "oohu125Kto149999")
arcpy.AlterField_management(newTab, "B25075e17", new_field_alias="oohu150Kto174999")
arcpy.AlterField_management(newTab, "B25075e17", "oohu150Kto174999")
arcpy.AlterField_management(newTab, "B25075e18", new_field_alias="oohu175Kto199999")
arcpy.AlterField_management(newTab, "B25075e18", "oohu175Kto199999")
arcpy.AlterField_management(newTab, "B25075e19", new_field_alias="oohu200Kto249999")
arcpy.AlterField_management(newTab, "B25075e19", "oohu200Kto249999")
arcpy.AlterField_management(newTab, "B25075e20", new_field_alias="oohu250Kto299999")
arcpy.AlterField_management(newTab, "B25075e20", "oohu250Kto299999")
arcpy.AlterField_management(newTab, "B25075e21", new_field_alias="oohu300Kto399999")
arcpy.AlterField_management(newTab, "B25075e21", "oohu300Kto399999")
arcpy.AlterField_management(newTab, "B25075e22", new_field_alias="oohu400Kto499999")
arcpy.AlterField_management(newTab, "B25075e22", "oohu400Kto499999")
arcpy.AlterField_management(newTab, "B25075e23", new_field_alias="oohu500Kto749999")
arcpy.AlterField_management(newTab, "B25075e23", "oohu500Kto749999")
arcpy.AlterField_management(newTab, "B25075e24", new_field_alias="oohu750Kto999999")
arcpy.AlterField_management(newTab, "B25075e24", "oohu750Kto999999")
arcpy.AlterField_management(newTab, "B25075e25", new_field_alias="oohu1MMore")
arcpy.AlterField_management(newTab, "B25075e25", "oohu1MMore")
delList.append("B25076e1")
delList.append("B25076m1")
delList.append("B25077e1")
delList.append("B25077m1")
delList.append("B25078e1")
delList.append("B25078m1")
stna = "B25079"
for n in range(1,6):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25080"
for n in range(1,9):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25081"
for n in range(1,9):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25082"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25083e1")
delList.append("B25083m1")
stna = "B25085"
for n in range(1,26):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
delList.append("B25086e1")
delList.append("B25086m1")
stna = "B25087"
for n in range(1,30):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
        delList.append("B25083e1")
delList.append("B25083m1")
stna = "B25088"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25089"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25090"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25091"
for n in range(1,24):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25092"
for n in range(1,4):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
stna = "B25093"
for n in range(1,30):
        mena = stna + "m" + str(n)
        delList.append(mena)
        estna = stna + "e" + str(n)
        delList.append(estna)
arcpy.DeleteField_management(newTab, delList)
arcpy.JoinField_management("acs", "GEOID_Data", newTab, "GEOID")
print "done merging housing table to acs .shp"
print "done merging acs fields"
print "program successfully ran"
##
##
