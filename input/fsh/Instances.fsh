Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org
Alias: DCMIdType = http://hl7.org/fhir/uv/radiation-dose-summary/CodeSystem/dicom-identifier-type
Alias: HL7IdType = http://terminology.hl7.org/CodeSystem/v2-0203

// Example 1 //
Instance: RadiationDoseSummary-139
InstanceOf: RadiationDoseSummary
Usage: #example
Description: "Radiation Dose Summary example 1"
* id = "139"
* identifier[0].type = DCMIdType#sop-instance-uid "SOP Instance UID"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.840.121.3.32.0.1.1323423.122"
* partOf = Reference(ImagingStudy/342)
* partOf.identifier.type = DCMIdType#study-instance-uid "Study Instance UID"
* partOf.identifier.system = "urn:dicom:uid"
* partOf.identifier.value = "urn:oid:1.2.840.121.3.32.0.1.1323423"
* status = #final
* code = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* focus = Reference(ImagingStudy/342)
* effectiveDateTime = "2015-01-01T22:23:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* valueString = "CT Dose Length Product Total = 203.12 mGy.cm"
* device = Reference(Device/539)
* device.display = "CT01"
* component[0].code.coding = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = SCT#77477000 "Computerized tomography"
* component[1].code.coding = DCM#113813 "CT Dose Length Product Total"
* component[1].valueQuantity.value = 203.12
* component[1].valueQuantity.unit = "mGy.cm"

Instance: Patient-56
InstanceOf: Patient
Usage: #example
Description: "Patient for example 1"
* id = "56"
* identifier[0].system = "urn:pid:ipdauth1"
* identifier[0].value = "PAT3421"
* name[0].family = "Dupony"
* name[0].given = "Pascale"
* birthDate = "1990-03-18"
* gender = #female


Instance: Practitioner-33
InstanceOf: Practitioner
Usage: #example
Description: "Practitioner for example 1"
* id = "33"
* identifier[0].system = "urn:prid:ipractauth1"
* identifier[0].value = "pract67"
* name[0].family = "Moore"
* name[0].given[0] = "John"


Instance: ImagingStudy-342
InstanceOf: ImagingStudy
Usage: #example
Description: "ImagingStudy for example 1"
* id = "342"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.840.121.3.32.0.1.1323423" 
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* started = "2015-01-01T22:20:00.000Z"


Instance: ModalityDevice-539
InstanceOf: ModalityDevice
Usage: #example
Description: "ModalityDevice for example 1"
* id = "539"
* identifier[0].type = DCMIdType#application-entity "Application Entity"
* identifier[0].value = "CT01" 
* manufacturer = "Manufacturer-1"
* serialNumber = "5445A343"
* deviceName[0].type = #manufacturer-name
* deviceName[0].name = "Manufacturer-1"
* deviceName[1].type = #model-name
* deviceName[1].name = "Manufacturer-ModelName-1"
* type.coding = DCM#CT "Computed Tomography"


Instance: RadiationSummaryReport-1
InstanceOf: RadiationSummaryReport
Usage: #example
Description: "Radiation Summary Report for example 1"
* id = "1"
* status = #final
* type.coding = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* date = "2015-01-01T23:43:30.000Z"
* author = Reference(Practitioner/33)
* author.display = "John Moore"
* title = "Radiation exposure and protection information"
* section[0].code.coding = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* section[0].entry = Reference(Observation/139)
* section[0].entry.display = "Radiation Dose Summary"
* section[1].code.coding = DCM#121109 "Indications for Procedure"
* section[1].entry = Reference(Observation/33)
* section[1].entry.display = "Indications"
* section[2].code.coding = LOINC#82810-3 "Pregnancy status"
* section[2].entry = Reference(Observation/34)
* section[2].entry.display = "Pregnancy Status"


Instance: Indications-1
InstanceOf: IndicationObservation
Usage: #example
Description: "Indication Observation for example 1"
* id = "33"
* status = #final
* code.coding = DCM#121109 "Indications for Procedure"
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* effectiveDateTime = "2015-01-01T23:43:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* valueString = "Exam to check right kidney"


Instance: PregnancyStatus-1
InstanceOf: ObservationPregnancyStatusUvIps
Usage: #example
Description: "Pregnancy Status for example 1"
* id = "34"
* status = #final
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* effectiveDateTime = "2015-01-01T23:43:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* valueCodeableConcept = LOINC#LA26683-5 "Not pregnant"



// Example 2 //
Instance: RadiationDoseSummary-545
InstanceOf: RadiationDoseSummary
Usage: #example
Description: "Radiation Dose Summary example 2"
* id = "545"
* partOf = Reference(ImagingStudy/344)
* partOf.identifier.type = DCMIdType#study-instance-uid "Study Instance UID"
* partOf.identifier.system = "urn:dicom:uid"
* partOf.identifier.value = "urn:oid:1.2.840.121.3.32.0.1.25"
* status = #final
* code = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* focus = Reference(ImagingStudy/344)
* effectiveDateTime = "2019-01-23T12:00:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* valueString = "Dose (RP) Total = 212 mGy, DAP Total = 13639 mGy.cm2, Fluoro DAP Total = 4523 mGy.cm2, Total Fluoro Time = 450s"
* device = Reference(Device/12)
* device.display = "XA01"
* component[0].code.coding = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = DCM#113704 "Projection X-Ray"
* component[1].code.coding = DCM#113725 "Dose (RP) Total"
* component[1].valueQuantity.value = 212
* component[1].valueQuantity.unit = "mGy"
* component[2].code.coding = DCM#113722 "Dose Area Product Total"
* component[2].valueQuantity.value = 13639
* component[2].valueQuantity.unit = "mGy.cm2"
* component[3].code.coding = DCM#113726 "Fluoro Dose Area Product Total"
* component[3].valueQuantity.value = 4523
* component[3].valueQuantity.unit = "mGy.cm2"
* component[3].code.coding = DCM#113730 "Total Fluoro Time"
* component[3].valueQuantity.value = 450
* component[3].valueQuantity.unit = "s"


Instance: ImagingStudy-344
InstanceOf: ImagingStudy
Usage: #example
Description: "ImagingStudy for example 2"
* id = "344"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.840.121.3.32.0.1.25" 
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* started = "2019-01-23T11:45:30.000Z"


Instance: ModalityDevice-12
InstanceOf: ModalityDevice
Usage: #example
Description: "ModalityDevice for example 2"
* id = "12"
* identifier[0].type = DCMIdType#application-entity "Application Entity"
* identifier[0].value = "XA01" 
* manufacturer = "Manufacturer-1"
* serialNumber = "767ER"
* deviceName[0].type = #manufacturer-name
* deviceName[0].name = "Manufacturer-1"
* deviceName[1].type = #model-name
* deviceName[1].name = "Manufacturer-ModelName-1"
* type.coding = DCM#XA "X-Ray Angiography"


// Example 3 //
Instance: RadiationDoseSummary-122
InstanceOf: RadiationDoseSummary
Usage: #example
Description: "NM Radiation Dose Summary example 3"
* id = "122"
* partOf = Reference(ImagingStudy/22)
* partOf.identifier.type = DCMIdType#study-instance-uid "Study Instance UID"
* partOf.identifier.system = "urn:dicom:uid"
* partOf.identifier.value = "urn:oid:1.2.840.121.3.32.0.1.32"
* status = #final
* code = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* focus = Reference(ImagingStudy/22)
* effectiveDateTime = "2019-01-23T12:00:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* valueString = "Activity = 154 MBq (123-I)"
* component[0].code = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = DCM#113502 "Radiopharmaceutical Administration"
* component[1].code = DCM#113507 "Administered activity"
* component[1].valueQuantity.value = 154
* component[1].valueQuantity.unit = "MBq"
* component[2].code = SCT#349358000 "Radiopharmaceuticals"
* component[2].valueCodeableConcept.coding = SCT#429296007 "Product containing ioflupane (123-I) (medicinal product)"


Instance: ImagingStudy-22
InstanceOf: ImagingStudy
Usage: #example
Description: "ImagingStudy for example 3"
* id = "22"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.840.121.3.32.0.1.32" 
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascale Dupont"
* started = "2019-01-23T11:45:30.000Z"
