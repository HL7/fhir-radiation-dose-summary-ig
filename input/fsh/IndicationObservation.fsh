Alias: DCM = http://dicom.nema.org/resources/ontology/DCM

Profile:        IndicationObservation
Parent:         Observation
Id:             indication-observation
Title:          "Indication Observation"
Description:    "Indication observation related to the radiation administration"

* code.coding = DCM#121109 "Indications for Procedure"

* subject only Reference(Patient)
* subject 1..1
* subject ^short = "Related Patient"

* value[x] 1..1
* value[x] only CodeableConcept or string
* value[x] ^short = "Indications description"