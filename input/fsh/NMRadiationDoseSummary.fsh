Alias: DCM = http://dicom.nema.org/resources/ontology/DCM|2025.2.20250411
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

ValueSet: RadiopharmaceuticalAgentVS
Id: radiopharmaceutical-rds-vs
Title: "Radiopharmaceuticals Value Set"
Description: "List of Radipharmaceuticals. Value Set defined by DICOM Standard: http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_25.html and http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4021.html"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* ^experimental = false
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* include codes from valueset http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_25.html|2025.2.20250411
* include codes from valueset http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4021.html|2025.2.20250411

ValueSet: IsotopesVS
Id: isotope-rds-vs
Title: "Isotopes Value Set"
Description: "List for Isotopes in radiopharmaceuticals. Value Set defined by DICOM Standard: http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_18.html and http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4020.html"
* ^experimental = false
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* include codes from valueset http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_18.html|2025.2.20250411
* include codes from valueset http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4020.html|2025.2.20250411
