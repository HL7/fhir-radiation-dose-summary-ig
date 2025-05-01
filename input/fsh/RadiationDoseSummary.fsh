Alias: DCM = http://dicom.nema.org/resources/ontology/DCM|2025.2.20250411
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org
Alias: DCMIdType = http://hl7.org/fhir/uv/radiation-dose-summary/CodeSystem/dicom-identifier-type
Alias: HL7IdType = http://terminology.hl7.org/CodeSystem/v2-0203

Profile:        RadiationDoseSummary
Parent:         Observation
Id:             radiation-dose-summary
Title:          "Radiation Dose Summary"
Description:    "General Structure describing a summary of an irradiation act"
* ^abstract = false
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* insert RDSStructureDefinitionContent

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.ordered = false
* identifier ^slicing.description = "Identifiers for the radiation dose"

* identifier contains radiationSRUID 0..* MS
* identifier[radiationSRUID].type = DCMIdType#sop-instance-uid "SOP Instance UID"
* identifier[radiationSRUID].system = "urn:dicom:uid"
* identifier[radiationSRUID].value 1..1
* identifier[radiationSRUID] ^short = "Identifier related to SOP Instance UID if the resource is generated based on an RDSR"

// Associated Procedure/Exam
* partOf ^slicing.discriminator.type = #type
* partOf ^slicing.discriminator.path = "reference"
* partOf ^slicing.rules = #open
* partOf ^slicing.description = "Description of the related ImagingStudy" 

* partOf contains imagingStudyRef 1..1 MS
* partOf[imagingStudyRef] only Reference(ImagingStudy)
* partOf[imagingStudyRef] ^short = "Related ImagingStudy"
* partOf[imagingStudyRef].identifier.type 1..1
* partOf[imagingStudyRef].identifier.type = DCMIdType#study-instance-uid "Study Instance UID"
* partOf[imagingStudyRef].identifier.system = "urn:dicom:uid"
* partOf[imagingStudyRef].identifier.value 1..1
* partOf[imagingStudyRef].identifier ^short = "Identifier related to Study Instance UID"

// Associated ServiceRequest
* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = "reference"
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Description of the related ServiceRequest"

* basedOn contains serviceRequestRef 0..1 MS
* basedOn[serviceRequestRef] only Reference(ServiceRequest)
* basedOn[serviceRequestRef] ^short = "Description of the related ServiceRequest"
* basedOn[serviceRequestRef].identifier.type 1..1
* basedOn[serviceRequestRef].identifier.type = HL7IdType#ACSN "Accession ID"
* basedOn[serviceRequestRef].identifier.value 1..1
* basedOn[serviceRequestRef].identifier ^short = "The accession number related to the performed study"

* code MS
* code = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"

* subject only Reference(Patient)
* subject 1..1 MS
* subject ^short = "Irradiated patient"

* focus only Reference(ImagingStudy)
* focus 1..1 MS
* focus ^short = "The observation has a focus on the performed exam."

// Irradiation Issued Date
* effective[x] only dateTime
* effective[x] 1..1 MS
* effective[x] ^short = "Irradiation Start Date Time"
* value[x] 1..1 MS
* value[x] only string
* valueString ^short = "Dose Summary text."
* valueString ^comment = "Textual representation of the dose summary based computed by the Dose Management system. Based on a locally defined template, definition of which is out of scope of this IG."
* dataAbsentReason 0..0
* specimen 0..0

// Performing irradiation device
* device 0..1 MS
* device only Reference(ModalityDevice)
* device ^short = "Irradiating modality"

// Irradiation Authorizing Person
* performer ^slicing.discriminator.type = #type
* performer ^slicing.discriminator.path = "reference"
* performer ^slicing.rules = #closed
* performer ^slicing.description = "Description of the related performer" 

* performer contains irradiationAutorizingPerson 1..1 MS
* performer[irradiationAutorizingPerson] only Reference(Practitioner)
* performer 1..1 MS
* performer[irradiationAutorizingPerson] ^short = "Related irradiation authorizing person"

// Dose measurements - Procedure Level
* component 0..*
* component.code from ComponentRadiationDoseSummaryVS (extensible)



ValueSet: ProcedureReportedTypeVS
Id: procedure-reported-type-rds-vs
Title: "Procedure Reported Type Value Set"
Description: "What is the type of procedure reported in the Radiation Dose Summary"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* ^experimental = false
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
//* SCT#373205008 "Nuclear medicine imaging procedure"
* DCM#113502 "Radiopharmaceutical Administration"
* SCT#77477000 "Computerized tomography"
* DCM#113704 "Projection X-Ray"
* SCT#71651007 "Mammography"

ValueSet: ComponentRadiationDoseSummaryVS
Id: component-radiation-dose-summary-vs
Title: "Radiation Dose Summary component type"
Description: "Value Set describing the list of minimal dose information related to Procedure and Administration level"
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* ^experimental = false
* ^copyright = "This value set includes content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organisation (IHTSDO), and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement."
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* DCM#113813 "CT Dose Length Product Total"
* DCM#113725 "Dose (RP) Total"
* DCM#111637 "Accumulated Average Glandular Dose"
* DCM#113722 "Dose Area Product Total"
* DCM#113726 "Fluoro Dose Area Product Total"
* DCM#113727 "Acquisition Dose Area Product Total"
* DCM#113730 "Total Fluoro Time"
* DCM#113731 "Total Number of Radiographic Frames"
* DCM#113507 "Administered activity"
* SCT#349358000 "Radiopharmaceuticals"
* SCT#89457008 "Radioisotope"
* DCM#123005 "Radiopharmaceutical Volume"
* SCT#410675002 "Route of administration"
