Instance: FHIRServer
InstanceOf: CapabilityStatement
Usage: #definition
Description: "Capability Statement needed to be supported by a FHIR Server in order to support all options and interactions with RDSC and RDSP actors."

* name = "RDSC-FHIRServer"
* title = "FHIR Server supporting FHIR operations in order to interact with RDSC and RDSP Actors"
* date = "2021-06-28"
* kind = #requirements
* description = "Defines the operation requirement for FHIR server actor"
* format[0] = #xml
* format[1] = #json
* fhirVersion = #4.0.1
* status = #draft 

* implementationGuide = "http://hl7.org/fhir/fhir-radiation-dose-summary-ig/ImplementationGuide/hl7.fhir.uv.fhir-radiation-dose-summary-ig"

* rest[0].mode = #server
* rest[0].documentation = "Description of the needed resources to be supported by the FHIR server, and the different possible interactions."

* rest[0].interaction[0].code = #transaction
* rest[0].interaction[1].code = #search-system


// Patient resource support
* rest[0].resource[0].type = #Patient
* rest[0].resource[0].documentation = "Search and Read of patient need to be available on FHIR server, and patient create can be activated based on the use case covered."
* rest[0].resource[0].profile = "" 
* rest[0].resource[0].interaction[0].code = #create
* rest[0].resource[0].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].interaction[0].extension.valueCode = #MAY
* rest[0].resource[0].interaction[1].code = #read
* rest[0].resource[0].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].interaction[1].extension.valueCode = #SHALL
* rest[0].resource[0].interaction[2].code = #search-type
* rest[0].resource[0].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].interaction[2].extension.valueCode = #SHALL

* rest[0].resource[0].searchParam[0].name = "identifier"
* rest[0].resource[0].searchParam[0].type = #token
* rest[0].resource[0].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[0].searchParam[1].name = "family"
* rest[0].resource[0].searchParam[1].type = #string
* rest[0].resource[0].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].searchParam[1].extension.valueCode = #SHOULD

* rest[0].resource[0].searchParam[1].name = "given"
* rest[0].resource[0].searchParam[1].type = #string
* rest[0].resource[0].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].searchParam[1].extension.valueCode = #SHOULD

// Practitioner resource support
* rest[0].resource[1].type = #Practitioner
* rest[0].resource[1].documentation = "Search and Read of practitioner shall be supported." 
* rest[0].resource[1].profile = ""
* rest[0].resource[1].interaction[0].code = #create
* rest[0].resource[1].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].interaction[0].extension.valueCode = #MAY
* rest[0].resource[1].interaction[1].code = #read
* rest[0].resource[1].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].interaction[1].extension.valueCode = #SHALL
* rest[0].resource[1].interaction[2].code = #search-type
* rest[0].resource[1].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].interaction[2].extension.valueCode = #SHALL

* rest[0].resource[1].searchParam[0].name = "identifier"
* rest[0].resource[1].searchParam[0].type = #token
* rest[0].resource[1].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[1].searchParam[1].name = "family"
* rest[0].resource[1].searchParam[1].type = #string
* rest[0].resource[1].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].searchParam[1].extension.valueCode = #SHOULD

* rest[0].resource[1].searchParam[1].name = "given"
* rest[0].resource[1].searchParam[1].type = #string
* rest[0].resource[1].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].searchParam[1].extension.valueCode = #SHOULD

// ImagingStudy resource support
* rest[0].resource[2].type = #ImagingStudy
* rest[0].resource[2].documentation = "Search and Read of ImagingStudy shall be supported." 
* rest[0].resource[2].profile = ""
* rest[0].resource[2].interaction[0].code = #create
* rest[0].resource[2].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].interaction[0].extension.valueCode = #MAY
* rest[0].resource[2].interaction[1].code = #read
* rest[0].resource[2].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].interaction[1].extension.valueCode = #SHALL
* rest[0].resource[2].interaction[2].code = #search-type
* rest[0].resource[2].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].interaction[2].extension.valueCode = #SHALL

* rest[0].resource[2].searchParam[0].name = "identifier"
* rest[0].resource[2].searchParam[0].type = #token
* rest[0].resource[2].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[2].searchParam[0].name = "patient"
* rest[0].resource[2].searchParam[0].type = #reference
* rest[0].resource[2].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].searchParam[0].extension.valueCode = #MAY

// Device resource support
* rest[0].resource[3].type = #Device
* rest[0].resource[3].documentation = "Search and Read of Device shall be supported." 
* rest[0].resource[3].profile = ""
* rest[0].resource[3].interaction[0].code = #create
* rest[0].resource[3].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].interaction[0].extension.valueCode = #MAY
* rest[0].resource[3].interaction[1].code = #read
* rest[0].resource[3].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].interaction[1].extension.valueCode = #SHALL
* rest[0].resource[3].interaction[2].code = #search-type
* rest[0].resource[3].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].interaction[2].extension.valueCode = #SHALL

* rest[0].resource[3].searchParam[0].name = "identifier"
* rest[0].resource[3].searchParam[0].type = #token
* rest[0].resource[3].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[3].searchParam[0].name = "type"
* rest[0].resource[3].searchParam[0].type = #token
* rest[0].resource[3].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].searchParam[0].extension.valueCode = #MAY

* rest[0].resource[3].searchParam[0].name = "manufacturer"
* rest[0].resource[3].searchParam[0].type = #token
* rest[0].resource[3].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].searchParam[0].extension.valueCode = #MAY

// Radiation Summary resource support
* rest[0].resource[4].type = #Observation
* rest[0].resource[4].documentation = "Create, Search and read Radiation Summary shall be supported." 
* rest[0].resource[4].interaction[0].code = #create
* rest[0].resource[4].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[0].extension.valueCode = #SHALL
* rest[0].resource[4].interaction[1].code = #read
* rest[0].resource[4].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[1].extension.valueCode = #SHALL
* rest[0].resource[4].interaction[2].code = #search-type
* rest[0].resource[4].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[2].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[0].name = "identifier"
* rest[0].resource[4].searchParam[0].type = #token
* rest[0].resource[4].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[1].name = "code"
* rest[0].resource[4].searchParam[1].type = #token
* rest[0].resource[4].searchParam[1].documentation = "Search based on identifiers of radiation dose summary like Accession Number"
* rest[0].resource[4].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[1].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[2].name = "patient"
* rest[0].resource[4].searchParam[2].type = #reference
* rest[0].resource[4].searchParam[2].documentation = "Search based on patient identifier"
* rest[0].resource[4].searchParam[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[2].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[3].name = "device"
* rest[0].resource[4].searchParam[3].type = #token
* rest[0].resource[4].searchParam[3].documentation = "Search based on modality identifiers"
* rest[0].resource[4].searchParam[3].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[3].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[4].name = "part-of"
* rest[0].resource[4].searchParam[4].type = #reference
* rest[0].resource[4].searchParam[4].documentation = "Search based on ImagingStudy"
* rest[0].resource[4].searchParam[4].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[4].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[5].name = "date"
* rest[0].resource[4].searchParam[5].type = #date
* rest[0].resource[4].searchParam[5].documentation = "Search based on Radiation Summary effective dateTime, can be used to search for radiation through a period of time"
* rest[0].resource[4].searchParam[5].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[5].extension.valueCode = #SHALL


* document[0].mode = #consumer
* document[0].documentation = "Documents related to Radiation Summary Report profile."
* document[0].profile = "http://hl7.org/fhir/fhir-radiation-dose-summary-ig/StructureDefinition/radiation-summary-report"

