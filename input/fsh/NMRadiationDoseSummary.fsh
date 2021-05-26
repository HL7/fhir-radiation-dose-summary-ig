Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Profile:        NMRadiationDoseSummary
Parent:         RadiationDoseSummary
Id:             nm-radiation-dose-summary
Title:          "Radiopharmaceutical Radiation Dose Summary"
Description:    "Radiopharmaceutical Radiation Dose Summary report"

* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open

// Dose measurements - Study Level
* component contains administeredActivity 1..1 and radiopharmaceutical 1..1 and radionucleide 0..1 
* component contains radiopharmaceuticalVolume 0..1 and routeOfAdministration 1..1
* component[procedureReported].valueCodeableConcept.coding = DCM#113502 "Radiopharmaceutical Administration"
* component[administeredActivity].code.coding = DCM#113507 "Administered activity"
* component[administeredActivity].value[x] only Quantity
* component[administeredActivity].value[x] 1..1
* component[administeredActivity].value[x].unit = "MBq"
* component[radiopharmaceutical].code.coding = SCT#349358000 "Radiopharmaceutical agent"
* component[radiopharmaceutical].value[x] only CodeableConcept or string
* component[radiopharmaceutical].valueCodeableConcept from RadiopharmaceuticalAgentVS (extensible)
* component[radionucleide].code.coding = SCT#89457008 "Radionucleide"
* component[radionucleide].value[x] only CodeableConcept or string
* component[radionucleide].value[x] 1..1
* component[radionucleide].valueCodeableConcept from IsotopesVS (extensible)
* component[radiopharmaceuticalVolume].code.coding = DCM#123005 "Radiopharmaceutical Volume"
* component[radiopharmaceuticalVolume].value[x] only Quantity
* component[radiopharmaceuticalVolume].value[x] 1..1
* component[radiopharmaceuticalVolume].value[x].unit = "cm3"
* component[routeOfAdministration].code.coding = SCT#410675002 "Route of administration"
* component[routeOfAdministration].value[x] only CodeableConcept
* component[routeOfAdministration].value[x] 1..1
* component[routeOfAdministration].valueCodeableConcept from http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_11.html (preferred)

ValueSet: RadiopharmaceuticalAgentVS
Id: radiopharmaceutical-rds-vs
Title: "Radiopharmaceuticals Value Set"
Description: "List of Radipharmaceuticals. Value Set defined by DICOM Standard: http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_25.html and http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4021.html"

ValueSet: IsotopesVS
Id: isotope-rds-vs
Title: "Isotopes Value Set"
Description: "List for Isotopes in radiopharmaceuticals. Value Set defined by DICOM Standard: http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_18.html and http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4020.html"


Mapping: dicom-sr-for-NMRadiationDoseSummary
Id: dicom-sr
Title: "DICOM SR"
Source: NMRadiationDoseSummary
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html"
* -> "TID10021 (Radiopharmaceutical Radiation Dose)"
* identifier[studyInstanceUID] -> "tag(0020,000D) [Study Instance UID]"
* identifier[radiationSRUID] -> "tag(0008,0018) [SOP Instance UID]"
* identifier[accessionNumber] -> "tag(0008,0050) [Accession Number]"
* partOf[imagingStudyRef] -> "tag(0020,000D) [Study Instance UID]"
* subject -> "tag(0010,0020) [Patient ID]"
* effective[x] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (123003, DCM, Radiopharmaceutical Start DateTime)"
* component[administeredActivity] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (113507, DCM, Administered activity)"
* component[radiopharmaceutical] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (349358000, SCT, Radiopharmaceutical agent)"
* component[radionucleide] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (349358000, SCT, Radiopharmaceutical agent).EV (89457008, SCT, Radionuclide)"
* component[radiopharmaceuticalVolume] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (123005, DCM, Radiopharmaceutical Volume)"
* component[routeOfAdministration] -> "TID10021 (Radiopharmaceutical Radiation Dose).TID10022 (Radiopharmaceutical Administration Event Data).EV (410675002, SCT, Route of administration)"


