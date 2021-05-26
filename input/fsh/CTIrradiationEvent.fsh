Alias: DCM = http://dicom.nema.org/resources/ontology/DCM

Profile:        CTIrradiationEventSummary
Parent:         IrradiationEventSummary
Id:             ct-irradiation-event-summary
Title:          "CT Irradiation Event Summary"
Description:    "CT Irradiation event Summary"

* value[x] 0..0
* bodySite 1..1

* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open

* component contains meanCTDIvol 0..1 and dlp 0..1 and ctdiPhantomType 0..1

* component[dlp].code.coding = DCM#113838 "DLP"
* component[dlp].value[x] only Quantity
* component[dlp].value[x] 1..1
* component[dlp].value[x].unit = "mGy.cm"
* component[meanCTDIvol].code.coding = DCM#113830 "Mean CTDIvol"
* component[meanCTDIvol].value[x] only Quantity
* component[meanCTDIvol].value[x] 1..1
* component[meanCTDIvol].value[x].unit = "mGy"
* component[ctdiPhantomType].code.coding = DCM#113835 "CTDIw Phantom Type"
* component[ctdiPhantomType].value[x] only CodeableConcept
* component[ctdiPhantomType].value[x] 1..1
* component[ctdiPhantomType].valueCodeableConcept from http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4052.html (extensible)


Mapping: dicom-sr-for-CTIrradiationEventSummary
Id: dicom-sr
Title: "DICOM SR"
Source: CTIrradiationEventSummary
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html"
* -> "TID10013(CT Irradiation Event Data)"
* identifier[irradiationEventUID] -> "TID10013(CT Irradiation Event Data).EV(113769, DCM, Irradiation Event UID)"
* subject -> "tag(0010,0020) [Patient ID]"
* effective[x] -> "TID10013.EV(111526, DCM, DateTime Started)"
* component[dlp] -> "TID10013(CT Irradiation Event Data).EV(113838, DCM, DLP)"
* component[meanCTDIvol] -> "TID10013(CT Irradiation Event Data).EV(113830, DCM, Mean CTDIvol)"
* component[ctdiPhantomType] -> "TID10013(CT Irradiation Event Data).EV(113835, DCM, CTDIw Phantom Type)"