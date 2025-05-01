Alias: LOINC =  http://loinc.org
Alias: DCM = http://dicom.nema.org/resources/ontology/DCM|2025.2.20250411


Profile:        RadiationSummaryReport
Parent:         Composition
Id:             radiation-summary-report
Title:          "Radiation Summary Report"
Description:    "A report document describing the irradiation act"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* insert RDSStructureDefinitionContent

* type MS
* type.coding = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject only Reference(Patient)
* subject 1..1 MS
* subject ^short = "Related patient"

* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code.coding"
* section ^slicing.rules = #open

* section contains radiationDoseSummary 1..1 MS and pregnancyObservation 0..1 MS and indicationObservation 0..1 MS

* section[radiationDoseSummary].code.coding = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* section[radiationDoseSummary].entry only Reference(RadiationDoseSummary)
* section[radiationDoseSummary] ^short = "Map to the Radiation Dose Summary Observation resource"

* section[pregnancyObservation].code.coding = LOINC#82810-3 "Pregnancy status"
* section[pregnancyObservation].entry only Reference(ObservationPregnancyStatusUvIps)
* section[pregnancyObservation] ^short = "Map to the Pregnancy Status Observation resource"

* section[indicationObservation].code.coding = DCM#121109 "Indications for Procedure"
* section[indicationObservation].entry only Reference(IndicationObservation)
* section[indicationObservation] ^short = "Map to Indication Observation resource"
