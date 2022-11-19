Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: DCMIdType = http://hl7.org/fhir/uv/radiation-dose-summary/CodeSystem/dicom-identifier-type

Profile:        IrradiationEventSummary
Parent:         Observation
Id:             irradiation-event-summary
Title:          "Irradiation Event Summary"
Description:    "General Structure describing a summary of an irradiation event"
* ^abstract = false
* insert RDSStructureDefinitionContent

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Slice on identifier.type"


* identifier contains irradiationEventUID 1..1 MS
* identifier[irradiationEventUID].type = DCMIdType#irradiation-event-uid "Irradiation Event UID"
* identifier[irradiationEventUID].system = "urn:dicom:uid"
* identifier[irradiationEventUID].value 1..1

* identifier[irradiationEventUID] ^short = "Identifier describing the Irradiation Event UID"

* code MS
* code.coding = DCM#113852 "Irradiation Event"
* subject only Reference(Patient)
* subject 1..1 MS

* effective[x] only dateTime
* effective[x] 1..1 MS
* effective[x] ^short = "Irradiation event start date time"

* value[x] 1..1
* value[x] only string
* valueString ^short = "Text Summary of the irradiation event."

// Dose measurements - Irradiation Event Level
* component.code from ComponentIrradiationEventVS (extensible)


ValueSet: ComponentIrradiationEventVS
Id: component-irradiation-event-vs
Title: "Irradiation Event component type"
Description: "Value Set describing the list of minimal dose information related to irradiation event level"
* ^experimental = false
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* DCM#113838 "DLP" // "Dose Length Product (DLP)"
* DCM#113830 "Mean CTDIvol" // "Refers to the average value of the CTDIvol associated with this acquisition"
* DCM#113835 "CTDIw Phantom Type" // "A label describing the type of phantom used for CTDIW measurement according to IEC 60601-2-44"