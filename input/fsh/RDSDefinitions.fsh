// Define a rule set for commonly used rules for definition resources using other Sushi features
RuleSet: RDSStructureDefinitionContent
 * ^status = #draft      // draft until final published
 * ^experimental = true  // true until ready for pilot, then false
 * ^version = "0.1.0"    // Follow IG Versioning rules
 * ^publisher = "HL7 International"
 * ^contact[0].name = "HL7 Imaging Integration Workgroup"
 * ^contact[0].telecom.system = #url
 * ^contact[0].telecom.value = "http://www.hl7.org/Special/committees/imagemgt/index.cfm"
 * ^contact[1].name = "Abderrazek Boufahja"
 * ^contact[1].telecom.system = #email
 * ^contact[1].telecom.value = "mailto:abderrazek.boufahja@ge.com"
 * ^jurisdiction.coding =  http://unstats.un.org/unsd/methods/m49/m49.htm#001