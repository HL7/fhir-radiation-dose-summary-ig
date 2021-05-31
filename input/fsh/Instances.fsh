Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Instance: CTRadiationDoseSummary-139
InstanceOf: CTRadiationDoseSummary
Usage: #example
Description: "CT Radiation Dose Summary example 1"
* id = "139"
* identifier[0].system = "study-instance-uid"
* identifier[0].value = "1.2.840.121.3.32.0.1.1323423"
* identifier[1].system = "sr-sop-instance-uid"
* identifier[1].value = "1.2.840.121.3.32.0.1.1323423.122"
* identifier[2].system = "accession-number"
* identifier[2].value = "AN12322332"
* partOf = Reference(ImagingStudy/342)
* status = #final
* code.coding = LOINC#73569-6 "Radiation exposure and protection information"
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* effectiveDateTime = "2015-01-01T22:23:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* device = Reference(Device/539)
* device.display = "CT01"
* hasMember[0] = Reference(Observation/839)
* hasMember[0].display = "Irradiation Event - 1"
* hasMember[1] = Reference(Observation/393)
* hasMember[1].display = "Irradiation Event - 2"
* component[0].code.coding = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = SCT#77477000 "Computerized tomography"
* component[1].code.coding = DCM#113813 "CT Dose Length Product Total"
* component[1].valueQuantity.value = 203.12
* component[1].valueQuantity.unit = "mGy.cm"

Instance: CTIrradiationEventSummary-839
InstanceOf: CTIrradiationEventSummary
Usage: #example
Description: "CT Irradiation Event Summary instance 1 for example 1"
* id = "839"
* identifier[0].system = "irradiation-event-uid"
* identifier[0].value = "1.2.840.121.3.32.0.1.1323423.1"
* partOf = Reference(ImagingStudy/342)
* status = #final
* code.coding = DCM#113852 "Irradiation Event"
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* effectiveDateTime = "2015-01-01T22:25:30.000Z"
* bodySite = SCT#7832008 "Abdominal aorta"
* component[0].code.coding = DCM#113830 "Mean CTDIvol"
* component[0].valueQuantity.value = 1.25
* component[0].valueQuantity.unit = "mGy"
* component[1].code.coding = DCM#113838 "DLP"
* component[1].valueQuantity.value = 157.07
* component[1].valueQuantity.unit = "mGy.cm"
* component[2].code.coding = DCM#113835 "CTDIw Phantom Type"
* component[2].valueCodeableConcept.coding = DCM#113691 "IEC Body Dosimetry Phantom"


Instance: CTIrradiationEventSummary-393
InstanceOf: CTIrradiationEventSummary
Usage: #example
Description: "CT Irradiation Event Summary instance 2 for example 1"
* id = "393"
* identifier[0].system = "irradiation-event-uid"
* identifier[0].value = "1.2.840.121.3.32.0.1.1323423.2"
* partOf = Reference(ImagingStudy/342)
* status = #final
* code.coding = DCM#113852 "Irradiation Event"
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* effectiveDateTime = "2015-01-01T22:29:30.000Z"
* bodySite = SCT#7832008 "Abdominal aorta"
* component[0].code.coding = DCM#113830 "Mean CTDIvol"
* component[0].valueQuantity.value = 2.25
* component[0].valueQuantity.unit = "mGy"
* component[1].code.coding = DCM#113838 "DLP"
* component[1].valueQuantity.value = 46.05
* component[1].valueQuantity.unit = "mGy.cm"
* component[2].code.coding = DCM#113835 "CTDIw Phantom Type"
* component[2].valueCodeableConcept.coding = DCM#113691 "IEC Body Dosimetry Phantom"


Instance: Patient-56
InstanceOf: Patient
Usage: #example
Description: "Patient for example 1"
* id = "56"
* identifier[0].system = "ipdauth1"
* identifier[0].value = "PAT3421"
* name[0].family = "Payet"
* name[0].given = "Pascal"
* birthDate = "1990-03-18"
* gender = #male


Instance: Practitioner-33
InstanceOf: Practitioner
Usage: #example
Description: "Practitioner for example 1"
* id = "33"
* identifier[0].system = "practauth1"
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
* identifier[1].system = "http://ginormoushospital.org/accession"
* identifier[1].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[1].type.coding[0].code = #ACSN
* identifier[1].value = "AN12322332"
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* started = "2015-01-01T22:20:00.000Z"


Instance: ModalityDevice-539
InstanceOf: ModalityDevice
Usage: #example
Description: "ModalityDevice for example 1"
* id = "539"
* identifier[0].system = "device-serial-number"
* identifier[0].value = "5445A343"
* identifier[1].system = "application-entity"
* identifier[1].value = "CT01" 
* manufacturer = "Manufacturer-1"
* serialNumber = "5445A343"
* deviceName[0].type = #manufacturer-name
* deviceName[0].name = "Manufacturer-1"
* deviceName[1].type = #model-name
* deviceName[1].name = "Manufacturer-ModelName-1"
* type.coding = DCM#CT "Computed Tomography"


Instance: XRayRadiationDoseSummary-545
InstanceOf: XRayRadiationDoseSummary
Usage: #example
Description: "CT Radiation Dose Summary example 2"
* id = "545"
* identifier[0].system = "study-instance-uid"
* identifier[0].value = "1.2.840.121.3.32.0.1.25"
* identifier[1].system = "accession-number"
* identifier[1].value = "AN1232234"
* partOf = Reference(ImagingStudy/344)
* status = #final
* code.coding = LOINC#73569-6 "Radiation exposure and protection information"
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* effectiveDateTime = "2019-01-23T12:00:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* device = Reference(Device/12)
* device.display = "XA01"
* component[0].code.coding = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = DCM#113704 "Projection X-Ray"
* component[1].code.coding = DCM#113725 "Dose (RP) Total"
* component[1].valueQuantity.value = 212
* component[1].valueQuantity.unit = "mGy"
* component[2].code.coding = DCM#113722 "Dose Area Product Total"
* component[2].valueQuantity.value = 136.39
* component[2].valueQuantity.unit = "dGy.cm2"
* component[3].code.coding = DCM#113726 "Fluoro Dose Area Product Total"
* component[3].valueQuantity.value = 45.23
* component[3].valueQuantity.unit = "dGy.cm2"
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
* identifier[1].system = "http://ginormoushospital.org/accession"
* identifier[1].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[1].type.coding[0].code = #ACSN
* identifier[1].value = "AN1232234"
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* started = "2019-01-23T11:45:30.000Z"


Instance: ModalityDevice-12
InstanceOf: ModalityDevice
Usage: #example
Description: "ModalityDevice for example 2"
* id = "12"
* identifier[0].system = "device-serial-number"
* identifier[0].value = "767ER"
* identifier[1].system = "application-entity"
* identifier[1].value = "XA01" 
* manufacturer = "Manufacturer-1"
* serialNumber = "767ER"
* deviceName[0].type = #manufacturer-name
* deviceName[0].name = "Manufacturer-1"
* deviceName[1].type = #model-name
* deviceName[1].name = "Manufacturer-ModelName-1"
* type.coding = DCM#XA "X-Ray Angiography"


Instance: NMRadiationDoseSummary-122
InstanceOf: NMRadiationDoseSummary
Usage: #example
Description: "NM Radiation Dose Summary example 3"
* id = "122"
* identifier[0].system = "study-instance-uid"
* identifier[0].value = "1.2.840.121.3.32.0.1.32"
* identifier[1].system = "accession-number"
* identifier[1].value = "AN6545"
* partOf = Reference(ImagingStudy/22)
* status = #final
* code.coding = LOINC#73569-6 "Radiation exposure and protection information"
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* effectiveDateTime = "2019-01-23T12:00:30.000Z"
* performer = Reference(Practitioner/33)
* performer.display = "John Moore"
* component[0].code.coding = DCM#121058 "Procedure reported"
* component[0].valueCodeableConcept.coding = DCM#113502 "Radiopharmaceutical Administration"
* component[1].code.coding = DCM#113507 "Administered activity"
* component[1].valueQuantity.value = 154
* component[1].valueQuantity.unit = "MBq"
* component[2].code.coding = SCT#349358000 "Radiopharmaceutical agent"
* component[2].valueCodeableConcept.coding = SCT#429296007 "Ioflupane I^123^"


Instance: ImagingStudy-22
InstanceOf: ImagingStudy
Usage: #example
Description: "ImagingStudy for example 3"
* id = "22"
* identifier[0].system = "urn:dicom:uid"
* identifier[0].value = "urn:oid:1.2.840.121.3.32.0.1.32" 
* identifier[1].system = "http://ginormoushospital.org/accession"
* identifier[1].type.coding[0].system = "http://terminology.hl7.org/CodeSystem/v2-0203"
* identifier[1].type.coding[0].code = #ACSN
* identifier[1].value = "AN6545"
* status = #available
* subject = Reference(Patient/56)
* subject.display = "Pascal Payet"
* started = "2019-01-23T11:45:30.000Z"
