Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Profile:        XRayRadiationDoseSummary
Parent:         RadiationDoseSummary
Id:             xray-radiation-dose-summary
Title:          "X-Ray Radiation Dose Summary"
Description:    "Defines the Minimal Dose Information related to X-Ray procedures"

* obeys xray-procedure-reported

* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open

* device 1..1

// Dose measurements - Study Level
* component contains doseRPTotal 0..1 and accumulatedAverageGlandularDose 0..1 and doseAreaProductTotal 0..1 
* component contains fluoroDoseAreaProductTotal 0..1 and acquisitionDoseAreaProductTotal 0..1 and totalFluoroTime 0..1 
* component contains totalNumberOfRadiographicFrames 0..1
* component[doseRPTotal].code.coding = DCM#113725 "Dose (RP) Total"
* component[doseRPTotal].value[x] only Quantity
* component[doseRPTotal].valueQuantity 1..1
* component[doseRPTotal].valueQuantity.unit = "mGy"
* component[accumulatedAverageGlandularDose].code.coding = DCM#111637 "Accumulated Average Glandular Dose"
* component[accumulatedAverageGlandularDose].value[x] only Quantity
* component[accumulatedAverageGlandularDose].valueQuantity 1..1
* component[accumulatedAverageGlandularDose].valueQuantity.unit = "mGy"
* component[doseAreaProductTotal].code.coding = DCM#113722 "Dose Area Product Total"
* component[doseAreaProductTotal].value[x] only Quantity
* component[doseAreaProductTotal].valueQuantity 1..1
* component[doseAreaProductTotal].valueQuantity.unit = "mGy.cm2"
* component[fluoroDoseAreaProductTotal].code.coding = DCM#113726 "Fluoro Dose Area Product Total"
* component[fluoroDoseAreaProductTotal].value[x] only Quantity
* component[fluoroDoseAreaProductTotal].valueQuantity 1..1
* component[fluoroDoseAreaProductTotal].valueQuantity.unit = "mGy.cm2"
* component[acquisitionDoseAreaProductTotal].code.coding = DCM#113727 "Acquisition Dose Area Product Total"
* component[acquisitionDoseAreaProductTotal].value[x] only Quantity
* component[acquisitionDoseAreaProductTotal].valueQuantity 1..1
* component[acquisitionDoseAreaProductTotal].valueQuantity.unit = "mGy.cm2"
* component[totalFluoroTime].code.coding = DCM#113730 "Total Fluoro Time"
* component[totalFluoroTime].value[x] only Quantity
* component[totalFluoroTime].valueQuantity 1..1
* component[totalFluoroTime].valueQuantity.unit = "s"
* component[totalNumberOfRadiographicFrames].code.coding = DCM#113731 "Total Number of Radiographic Frames"
* component[totalNumberOfRadiographicFrames].value[x] only integer
* component[totalNumberOfRadiographicFrames].valueInteger 1..1

Invariant: xray-procedure-reported
Description: "Procedure Reported shall be (113704, DCM, Projection X-Ray) or (71651007, SCT, Mammography)"
Severity: #error
Expression: "component.code.coding.code = '121058' implies (component.valueCodeableConcept.code = '113704' or component.valueCodeableConcept.code = '71651007')"
XPath: "f:component[f:code/f:coding/@code='121058']/f:valueCodeableConcept[(@code = '113704') or (@code = '71651007')]"

Mapping: dicom-sr-for-XRayRadiationDoseSummary
Id: dicom-sr
Title: "DICOM SR"
Source: XRayRadiationDoseSummary
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html"
* -> "TID10001 (Projection X-Ray Radiation Dose)"
* identifier[studyInstanceUID] -> "tag(0020,000D) [Study Instance UID]"
* identifier[radiationSRUID] -> "tag(0008,0018) [SOP Instance UID]"
* identifier[accessionNumber] -> "tag(0008,0050) [Accession Number]"
* partOf[imagingStudyRef] -> "tag(0020,000D) [Study Instance UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* effective[x] -> "tag(0008,0021) [Series Date] + tag(0008,0031) [Series Time]"
* device -> "TID10011 (CT Radiation Dose).TID 1002 (Observer Context).TID 1004 (Device Observer Identifying Attributes)"
* component[doseRPTotal] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10007 (Accumulated Total Projection Radiography Dose).EV (113725, DCM, Dose (RP) Total)"
* component[accumulatedAverageGlandularDose] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10005 (Accumulated Mammography X-Ray Dose).EV (111637, DCM, Accumulated Average Glandular Dose)"
* component[doseAreaProductTotal] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10007 (Accumulated Total Projection Radiography Dose).EV (113722, DCM, Dose Area Product Total)"
* component[fluoroDoseAreaProductTotal] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10004 (Accumulated Fluoroscopy and Acquisition Projection X-Ray Dose).EV (113726, DCM, Fluoro Dose Area Product Total)"
* component[acquisitionDoseAreaProductTotal] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10004 (Accumulated Fluoroscopy and Acquisition Projection X-Ray Dose).EV (113727, DCM, Acquisition Dose Area Product Total)"
* component[totalFluoroTime] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).TID 10004 (Accumulated Fluoroscopy and Acquisition Projection X-Ray Dose).EV (113730, DCM, Total Fluoro Time)"
* component[totalNumberOfRadiographicFrames] -> "TID10011 (CT Radiation Dose).TID 10002 (Accumulated X-Ray Dose).EV (113731, DCM, Total Number of Radiographic Frames)"
