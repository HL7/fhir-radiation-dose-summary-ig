This IG standardizes the sharing of minimal radiation information following a performed exam. Minimal radiation information is required by multiple stakeholders including RIS, EHR, and national/regional stakeholders and their associated regulations. This IG standardizes data sharing from dose management systems to third parties. The IG exposes radiation information related to (and coming from) imaging procedures, but not medications.

### Organization of this implementation guide

This IG is organized into three main sections:

* [Chapter I](background.html): Background - Introduction and overview
    * [Problematic](background.html#problematic) - Description of the problematic
    * [Scope](background.html#scope) - Scope of the IG
    * [Use cases](background.html#usecases) - Key use cases covered by the IG
    * [Minimal Radiation Information](background.html#mindose) - Description of data shared through this IG
    * [Glossary](background.html#glossary) - Glossary
    * [References](background.html#references) - References
* [Chapter II](archi.html): Architecture & Implementation
    * [Profiles & Extensions](archi.html#profiles) - FHIR Profiles and extensions defined in the IG
    * [Actors](archi.html#actors) - Actors participating in the IG
    * [Terminology](archi.html#terminology) - Value Sets defined and used
    * [Security Consideration](archi.html#sec) - Security aspects to be taken in consideration
* [Chapter III](testing.html): Testing & Conformance
    * [Test Plan](testing.html#testplan) - Test plans for the different actors 
    * [Test Data](testing.html#testdata) - Test data that can be used
    * [Resources Samples](testing.html#samples) - Samples of resources profiled following this IG

### Copyrights and acknowledgments

This document is licensed under Creative Commons "No Rights Reserved" (CC0).

#### Value Sets
Value Sets in this guide include:

* Vocabulary Content from SNOMED CT, which is copyright © 2002+ International Health Terminology Standards Development Organization (IHTSDO) and distributed by agreement between IHTSDO and HL7. Implementer use of SNOMED CT is not covered by this agreement
* Vocabulary Content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at LOINC/license. 

#### Trademarks
LOINC® is a registered United States trademark of Regenstrief Institute, Inc.

SNOMED® and "SNOMED CT" are registered trademarks of the IHTSDO.

HL7®, HEALTH LEVEL SEVEN®, FHIR® and the FHIR® Logo are trademarks owned by Health Level Seven International, registered with the United States Patent and Trademark Office.

DICOM® is a registered trademark of the National Electrical Manufacturers Association for its standards publications relating to digital communications of medical information.

IHE® is a registered trademark of the Healthcare Information Management Systems Society in the United States and trademarks of IHE Europe in the European Community.


### Sponsors Working Groups
* [Imaging Integration Work Group](http://www.hl7.org/Special/committees/imagemgt/index.cfm){:target="_blank"}
* [Clinical Quality Information Work Group](http://www.hl7.org/Special/committees/cqi/index.cfm){:target="_blank"}

### Contributors

| Name        |      Organization       |  Role |
|--------------------------|-----------------------|--------------|
| Abderrazek Boufahja | GE Healthcare |Author |
| Jonathan Whitby | Canon Group Company | Contributor |
| Christopher Lindop | GE Healthcare | Contributor |
| Steven Nichols | GE Healthcare | Contributor |
{:.table-striped .table-bordered}

