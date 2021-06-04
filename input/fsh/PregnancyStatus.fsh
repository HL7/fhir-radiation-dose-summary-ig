Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Profile:        PregnancyStatus
Parent:         Observation
Id:             pregnancy-status
Title:          "Pregnancy Status"
Description:    "Describes patient pregnancy status"
* insert RDSStructureDefinitionContent

* code.coding = LOINC#82810-3 "Pregnancy status"
* code MS
* effective[x] MS
* valueCodeableConcept MS
* component MS
* component.code.coding MS
* component.code.coding = LOINC#11778-8 "Delivery date Estimated"
* component.valueDateTime MS
* component.valueDateTime 1..1