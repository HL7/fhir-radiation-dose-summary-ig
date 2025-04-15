// Define a rule set for commonly used rules for definition resources using other Sushi features
RuleSet: RDSStructureDefinitionContent
* ^status = #active   // draft until final published
* ^experimental = false  // true until ready for pilot, then false
* ^version = "1.0.0"    // Follow IG Versioning rules
* ^publisher = "HL7 International"
* ^contact[0].name = "HL7 International / Imaging Integration"
* ^contact[0].telecom[0].system = #url
* ^contact[0].telecom[0].value = "http://www.hl7.org/Special/committees/imagemgt"
* ^contact[1].name = "Abderrazek Boufahja"
* ^contact[1].telecom.system = #email
* ^contact[1].telecom.value = "mailto:abderrazek.boufahja@gehealthcare.com"
* ^contact[2].name = "Steven Nichols"
* ^contact[2].telecom.system = #email
* ^contact[2].telecom.value = "mailto:steven.nichols@gehealthcare.com"
* ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001
* ^extension[0].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-wg"
* ^extension[0].valueCode = #ii
* ^extension[1].url = "http://hl7.org/fhir/StructureDefinition/structuredefinition-fmm"
* ^extension[1].valueInteger = 2
