Alias: DCM = http://dicom.nema.org/resources/ontology/DCM|2021.4.20210910

Profile:        IndicationObservation
Parent:         Observation
Id:             indication-observation
Title:          "Indication Observation"
Description:    "Indication observation related to the radiation administration"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* insert RDSStructureDefinitionContent

* code MS
* code.coding = DCM#121109 "Indications for Procedure"

* subject only Reference(Patient)
* subject 1..1 MS
* subject ^short = "Related Patient"

* value[x] 1..1 MS
* value[x] only CodeableConcept or string
* value[x] ^short = "Indications description"

Mapping: procedure-indication-mapping
Id: procedure-indication-mapping
Title: "DICOM Procedure Indication"
Source: IndicationObservation
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part03/sect_C.4.11.html"
Description: "The mapping for indication is following the CDA defined mapping within PS 3.20: http://dicom.nema.org/medical/dicom/current/output/chtml/part20/sect_C.4.4.html"
* -> "Requested Procedure Module"
* valueCodeableConcept -> "Referenced Request Sequence (0040,A370) > Reason for the Requested Procedure (0040,1002)"
* valueString -> "Referenced Request Sequence (0040,A370) > Reason for the Requested Procedure Code Sequence (0040,100A)"
