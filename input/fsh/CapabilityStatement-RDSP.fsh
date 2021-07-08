Instance: RDSP
InstanceOf: CapabilityStatement
Usage: #definition
Description: "Minimal Capability Statement needed to be supported by RDSP Actor"

* name = "RDSP"
* title = "RDSP Actor minimal requirements"
* date = "2021-06-28"
* kind = #requirements
* description = "Defines the operation requirement for RDSP actor"
* format[0] = #xml
* format[1] = #json
* fhirVersion = #4.0.1
* status = #draft 

* implementationGuide = "http://hl7.org/fhir/uv/radiation-dose-summary/ImplementationGuide/hl7.fhir.uv.radiation-dose-summary"

* rest[0].mode = #client
* rest[0].documentation = "Description of the needed resources to be supported by RDSP actor."

* rest[0].interaction[0].code = #transaction
* rest[0].interaction[1].code = #search-system

// Patient resource support
* rest[0].resource[0].type = #Patient
* rest[0].resource[0].documentation = "Search on patient shall be supported."
* rest[0].resource[0].interaction[0].code = #create
* rest[0].resource[0].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].interaction[0].extension.valueCode = #MAY
* rest[0].resource[0].interaction[1].code = #read
* rest[0].resource[0].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[0].interaction[1].extension.valueCode = #SHOULD
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
* rest[0].resource[1].documentation = "Search on practitioner shall be supported." 
* rest[0].resource[1].interaction[0].code = #create
* rest[0].resource[1].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].interaction[0].extension.valueCode = #MAY
* rest[0].resource[1].interaction[1].code = #read
* rest[0].resource[1].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[1].interaction[1].extension.valueCode = #SHOULD
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
* rest[0].resource[2].documentation = "Search on ImagingStudy shall be supported." 
* rest[0].resource[2].interaction[0].code = #create
* rest[0].resource[2].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].interaction[0].extension.valueCode = #MAY
* rest[0].resource[2].interaction[1].code = #read
* rest[0].resource[2].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[2].interaction[1].extension.valueCode = #SHOULD
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
* rest[0].resource[3].documentation = "Search on Device shall be supported." 
* rest[0].resource[3].interaction[0].code = #create
* rest[0].resource[3].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].interaction[0].extension.valueCode = #MAY
* rest[0].resource[3].interaction[1].code = #read
* rest[0].resource[3].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[3].interaction[1].extension.valueCode = #SHOULD
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
* rest[0].resource[4].documentation = "Create of Radiation Summary shall be supported." 
* rest[0].resource[4].interaction[0].code = #create
* rest[0].resource[4].interaction[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[0].extension.valueCode = #SHALL
* rest[0].resource[4].interaction[1].code = #read
* rest[0].resource[4].interaction[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[1].extension.valueCode = #SHOULD
* rest[0].resource[4].interaction[2].code = #search-type
* rest[0].resource[4].interaction[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].interaction[2].extension.valueCode = #SHOULD

* rest[0].resource[4].searchParam[0].name = "identifier"
* rest[0].resource[4].searchParam[0].type = #token
* rest[0].resource[4].searchParam[0].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[0].extension.valueCode = #SHALL

* rest[0].resource[4].searchParam[1].name = "patient"
* rest[0].resource[4].searchParam[1].type = #reference
* rest[0].resource[4].searchParam[1].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[1].extension.valueCode = #SHOULD

* rest[0].resource[4].searchParam[2].name = "code"
* rest[0].resource[4].searchParam[2].type = #token
* rest[0].resource[4].searchParam[2].extension.url = "http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation"
* rest[0].resource[4].searchParam[2].extension.valueCode = #SHALL