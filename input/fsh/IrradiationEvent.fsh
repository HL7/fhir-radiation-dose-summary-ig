Alias: DCM = http://dicom.nema.org/resources/ontology/DCM

Profile:        IrradiationEventSummary
Parent:         Observation
Id:             irradiation-event-summary
Title:          "Irradiation Event Summary"
Description:    "Irradiation event Summary"

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open


* identifier contains irradiationEventUID 1..1
* identifier[irradiationEventUID].system = "irradiation-event-uid"
* identifier[irradiationEventUID].value 1..1

* code.coding = DCM#113852 "Irradiation Event"
* subject only Reference(Patient)
* subject 1..1

// EV (111526, DCM, "DateTime Started")
* effective[x] only dateTime
* effective[x] 1..1
