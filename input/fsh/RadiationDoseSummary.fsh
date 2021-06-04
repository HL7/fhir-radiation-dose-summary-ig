Alias: DCM = http://dicom.nema.org/resources/ontology/DCM
Alias: SCT = http://snomed.info/sct
Alias: LOINC =  http://loinc.org

Profile:        RadiationDoseSummary
Parent:         Observation
Id:             radiation-dose-summary
Title:          "Radiation Dose Summary"
Description:    "General Structure describing a summary of an irradiation act"
* insert RDSStructureDefinitionContent

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "system"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Identifiers for the radiation dose"


* identifier contains studyInstanceUID 1..1 and radiationSRUID 0..* and accessionNumber 0..1 
* identifier[studyInstanceUID].system = "study-instance-uid"
* identifier[studyInstanceUID].value 1..1
* identifier[studyInstanceUID] ^short = "Identifier related to Study Instance UID"
* identifier[radiationSRUID].system = "sr-sop-instance-uid"
* identifier[radiationSRUID].value 1..1
* identifier[radiationSRUID] ^short = "Identifier related to SOP Instance UID if the resources is generated based on an RDSR"
* identifier[accessionNumber].system = "accession-number"
* identifier[accessionNumber].value 1..1
* identifier[accessionNumber] ^short = "The accession number related to the performed study"


// Associated Procedure/Exam
* partOf ^slicing.discriminator.type = #type
* partOf ^slicing.discriminator.path = "reference"
* partOf ^slicing.rules = #open
* partOf ^slicing.description = "Description of the related ImagingStudy" 

* partOf contains imagingStudyRef 1..1
* partOf[imagingStudyRef] only Reference(ImagingStudy)
* partOf[imagingStudyRef] ^short = "Related ImagingStudy"

* code = LOINC#73569-6 "Radiation exposure and protection information [Description] Document Diagnostic imaging"
* subject only Reference(Patient)
* subject 1..1
* subject ^short = "Irradiated patient"

// Irradiation Issued Date
* effective[x] only dateTime
* effective[x] 1..1
* effective[x] ^short = "Irradiation Start Date Time"
* value[x] 0..0
* dataAbsentReason 0..0
* specimen 0..0

// Performing irradiation device
* device 0..1
* device only Reference(Device)
* device ^short = "Irradiating modality"


// Pregnancy Observation
// Indication Observation
* hasMember ^slicing.discriminator.type = #profile
* hasMember ^slicing.discriminator.path = "reference"
* hasMember ^slicing.rules = #open
* hasMember ^slicing.description = "Description of the related related observation"
* hasMember contains irradiationEvent 0..*
* hasMember[irradiationEvent] only Reference(IrradiationEventSummary)
* hasMember[irradiationEvent] ^short = "Related irradiation events."

// Irradiation Authorizing Person
* performer ^slicing.discriminator.type = #type
* performer ^slicing.discriminator.path = "reference"
* performer ^slicing.rules = #closed
* performer ^slicing.description = "Description of the related performer" 

* performer contains irradiationAutorizingPerson 1..1
* performer[irradiationAutorizingPerson] only Reference(Practitioner)
* performer 1..1
* performer[irradiationAutorizingPerson] ^short = "Related irradiation authorizing person"

* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.ordered = false
* component ^slicing.description = "Slice on component.code"

// Dose measurements - Procedure Level
* component 1..*
* component.code from ComponentRadiationDoseSummaryVS (extensible)
* component contains procedureReported 1..1
* component[procedureReported].code = DCM#121058 "Procedure reported"
* component[procedureReported].value[x] only CodeableConcept
* component[procedureReported].valueCodeableConcept from ProcedureReportedTypeVS (required)
* component[procedureReported] ^short = "Related Reported Procedure."



ValueSet: ProcedureReportedTypeVS
Id: procedure-reported-type-rds-vs
Title: "Procedure Reported Type Value Set"
Description: "What is the type of procedure reported in the Radiation Dose Summary"
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
//* SCT#373205008 "Nuclear medicine imaging procedure"
* DCM#113502 "Radiopharmaceutical Administration"
* SCT#77477000 "Computerized tomography"
* DCM#113704 "Projection X-Ray"
* SCT#71651007 "Mammography"

ValueSet: ComponentRadiationDoseSummaryVS
Id: component-radiation-dose-summary-vs
Title: "Components' Code for Radiation Dose Summary"
Description: "Value Set describing the list of minimal dose information related to Procedure and Administration level"
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* DCM#121058 "Procedure reported"
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