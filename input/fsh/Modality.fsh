Alias: DEViCETYPE =  http://hl7.org/fhir/device-nametype

Profile:        ModalityDevice
Parent:         Device
Id:             modality-device
Title:          "Modality Device"
Description:    "Modality profiling as a Device resource"

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Identifiers for the modality"

* identifier contains deviceSerialNumber 0..1 and aeTitle 1..1 and deviceUID 0..1
* identifier[deviceSerialNumber].system = "device-serial-number"
* identifier[deviceSerialNumber].value 1..1
* identifier[deviceSerialNumber] ^short = "Describe the Device Serial Number, related to tag(0018,1000) Device Serial Number" 
* identifier[aeTitle].system = "application-entity"
* identifier[aeTitle].value 1..1
* identifier[aeTitle] ^short = "Describe the AETitle of the modality irradiating the patient"
* identifier[deviceUID].system = "device-uid"
* identifier[deviceUID].value 1..1
* identifier[deviceUID] ^short = "Describe the Device UID, related to tag(0018,1002) Device UID"
* manufacturer ^short = "The manufacturer of the modality, related to tag(0008,0070) manufacturer"
* serialNumber ^short = "The serial number of the modality, which is the Device Serial Number"
* type 1..1
* type from http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_33.html (required)
* type ^short = "Describe the main modality type (CT, MG, etc.)"
* version ^short = "Describe the Software Versions of the device, related to tag(0018,1020) Software Versions"

* deviceName ^slicing.discriminator.type = #value 
* deviceName ^slicing.discriminator.path = "type"
* deviceName ^slicing.rules = #open
* deviceName ^slicing.description = "name of the device"

* deviceName contains manufacturer 0..1 and manufacturermodelName 0..1
* deviceName[manufacturer].type = DEViCETYPE#manufacturer-name "Manufacturer name"
* deviceName[manufacturer] ^short = "The manufacturer of the modality"
* deviceName[manufacturermodelName].type = DEViCETYPE#model-name "Model name"
* deviceName[manufacturermodelName] ^short = "The model name of the modality"
