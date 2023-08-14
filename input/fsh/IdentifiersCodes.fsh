CodeSystem: DicomIdentifierType
Id: dicom-identifier-type
Title: "DICOM Identifier Type"
Description: "Identifier types related to DICOM UIDs"

* ^experimental = false
* ^caseSensitive = true
* ^content = #complete
* ^hierarchyMeaning = #is-a
* #irradiation-event-uid "Irradiation Event UID" "Unique identification of the irradiation event"
* #device-serial-number "Device Serial Number" "Manufacturer's serial number of the device"
* #application-entity "Application Entity" "Title of a DICOM Application Entity"
* #device-uid "Device UID" "Unique identifier of the equipment that produced the Composite Instances"
* #device-id "Device ID" "User-supplied identifier for the device"
* #study-instance-uid "Study Instance UID" "Unique identifier for the Study"
* #sop-instance-uid "SOP Instance UID" "Uniquely identifies the SOP Instance"

