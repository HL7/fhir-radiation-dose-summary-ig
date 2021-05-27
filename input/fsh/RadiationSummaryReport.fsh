Alias: LOINC =  http://loinc.org
Alias: DCM = http://dicom.nema.org/resources/ontology/DCM


Profile:        RadiationSummaryReport
Parent:         Composition
Id:             radiation-summary-report
Title:          "Radiation Summary Report"
Description:    "A report document describing the irradiation act"

* type.coding = LOINC#73569-6 "Radiation exposure and protection information"
* subject only Reference(Patient)
* subject 1..1
* subject ^short = "Related patient"

* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code.coding"
* section ^slicing.rules = #open

* section contains radiationDoseSummary 1..1 and pregnancyObservation 0..1 and indicationObservation 0..1

* section[radiationDoseSummary].code.coding = LOINC#73569-6 "Radiation exposure and protection information"
* section[radiationDoseSummary].entry only Reference(RadiationDoseSummary)
* section[radiationDoseSummary] ^short = "Map to the Radiation Dose Summary Observation resource"

* section[pregnancyObservation].code.coding = LOINC#82810-3 "Pregnancy status"
* section[pregnancyObservation].entry only Reference(PregnancyStatus)
* section[pregnancyObservation] ^short = "Map to the Pregnancy Status Observation resource"

* section[indicationObservation].code.coding = DCM#121109 "Indications for Procedure"
* section[indicationObservation].entry only Reference(IndicationObservation)
* section[indicationObservation] ^short = "Map to Indication Observation resource"
