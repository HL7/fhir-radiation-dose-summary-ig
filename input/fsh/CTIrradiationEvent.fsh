Alias: DCM = http://dicom.nema.org/resources/ontology/DCM

Profile:        CTIrradiationEventSummary
Parent:         IrradiationEventSummary
Id:             ct-irradiation-event-summary
Title:          "CT Irradiation Event Summary"
Description:    "Defines the Minimal Dose Information related to CT procedures"
* insert RDSStructureDefinitionContent

* value[x] 0..0

* bodySite 1..1 MS
* bodySite from http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4030.html (extensible)
* bodySite ^short = "The bodySite describes the related target region irradiated by this irradiation event"
* bodySite ^comment = "The related target region is described by EV (123014, DCM, Target Region)"

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component ^slicing.description = "Slice on component.code"

* component contains meanCTDIvol 0..1 MS and dlp 0..1 MS and ctdiPhantomType 0..1 MS

* component[dlp].code = DCM#113838 "DLP"
* component[dlp].value[x] only Quantity
* component[dlp].value[x] 1..1
* component[dlp].value[x].unit = "mGy.cm"
* component[meanCTDIvol].code = DCM#113830 "Mean CTDIvol"
* component[meanCTDIvol].value[x] only Quantity
* component[meanCTDIvol].value[x] 1..1
* component[meanCTDIvol].value[x].unit = "mGy"
* component[ctdiPhantomType].code = DCM#113835 "CTDIw Phantom Type"
* component[ctdiPhantomType].value[x] only CodeableConcept
* component[ctdiPhantomType].value[x] 1..1
* component[ctdiPhantomType].valueCodeableConcept from http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4052.html (extensible)

* component[meanCTDIvol] ^short = "Describes the EV(113830, DCM, Mean CTDIvol) element from TID-10013"
* component[dlp] ^short = "Describes the EV(113838, DCM, DLP) element from  TID-10013"
* component[ctdiPhantomType] ^short = "Describes the EV(113835, DCM, CTDIw Phantom Type) element from TID-10013"
* effective[x] ^short = "Describes the EV(111526, DCM, DateTime Started) element from TID-10013"


Mapping: dicom-sr-for-CTIrradiationEventSummary
Id: dicom-sr
Title: "DICOM SR"
Source: CTIrradiationEventSummary
Target: "http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html"
Description: "The CTIrradiationEventSummary can be extracted from TID 10013 - CT Irradaition Event Data."
* -> "TID10013(CT Irradiation Event Data)"
* identifier[irradiationEventUID] -> "TID10013(CT Irradiation Event Data).EV(113769, DCM, Irradiation Event UID)"
* subject -> "tag(0010,0020) [Patient ID]"
* effective[x] -> "TID10013.EV(111526, DCM, DateTime Started)"
* component[dlp] -> "TID10013(CT Irradiation Event Data).EV(113838, DCM, DLP)"
* component[meanCTDIvol] -> "TID10013(CT Irradiation Event Data).EV(113830, DCM, Mean CTDIvol)"
* component[ctdiPhantomType] -> "TID10013(CT Irradiation Event Data).EV(113835, DCM, CTDIw Phantom Type)"



