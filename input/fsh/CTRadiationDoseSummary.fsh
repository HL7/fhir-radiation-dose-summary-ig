Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Profile:        CTRadiationDoseSummary
Parent:         RadiationDoseSummary
Id:             ct-radiation-dose-summary
Title:          "CT Radiation Dose Summary"
Description:    "CT Radiation Dose Summary report"

* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open

* device 1..1

// Dose measurements - Study Level
* component contains cTDoseLengthProductTotal 1..1

* component[procedureReported].valueCodeableConcept.coding = SCT#77477000 "Computed Tomography X-Ray"

* component[cTDoseLengthProductTotal].code.coding = DCM#113813 "CT Dose Length Product Total"
* component[cTDoseLengthProductTotal].value[x] only Quantity
* component[cTDoseLengthProductTotal].value[x] 1..1
* component[cTDoseLengthProductTotal].value[x].unit = "mGy.cm"

Mapping: dicom-sr-for-CTRadiationDoseSummary
Id: dicom-sr
Title: "DICOM SR"
Source: CTRadiationDoseSummary
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html"
* -> "TID10011 (CT Radiation Dose)"
* identifier[studyInstanceUID] -> "tag(0020,000D) [Study Instance UID]"
* identifier[radiationSRUID] -> "tag(0008,0018) [SOP Instance UID]"
* identifier[accessionNumber] -> "tag(0008,0050) [Accession Number]"
* partOf[imagingStudyRef] -> "tag(0020,000D) [Study Instance UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* effective[x] -> "TID10011 (CT Radiation Dose).EV (113809, DCM, Start of X-Ray Irradiation)"
* device -> "TID10011 (CT Radiation Dose).TID 1002 (Observer Context).TID 1004 (Device Observer Identifying Attributes)"
* hasMember[irradiationEvent] -> "TID10011 (CT Radiation Dose).TID10013 (CT Irradiation Event Data)"
* performer[irradiationAutorizingPerson] -> "TID10011 (CT Radiation Dose)"
* component[procedureReported] -> "TID10011(CT Radiation Dose).EV(121058, DCM, Procedure reported)"
* component[cTDoseLengthProductTotal] -> "TID10011(CT Radiation Dose).TID10012(CT Accumulated Dose Data).EV(113813, DCM, CT Dose Length Product Total)"