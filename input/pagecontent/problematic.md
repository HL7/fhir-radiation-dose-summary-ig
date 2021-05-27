The IHE Dose Reporter actor from the IHE REM profile gather Radiation information and dose reports from modalities. However, there is no standardization of the exposure of the gathered data to third parties in light format/API. 

![Problematic](./problematic.png){: width="800px"}

<br clear="all" />

 Dose Management systems need to share information related to the exam to multiple third parties :

* Mobile Applications: like patients related mobile application, where a patient may want to centralize the report of doses injected to him
* RIS/EHR : many RIS/EHR systems does not have capabilities to read DICOM SR documents and prefer to contact the hospital dose registry in order to gather a summary of the dose report; and in order to include the summary under the final imaging report.
* Third backend systems: some third backend application may want to gather a summary of the exam’s dose for some proprietary use; gathering the complete RDSR is useless for most of the non Dose Management systems

The RDSRs have a complete and a strong structure for sharing the dose information from the modalities to the Dose Consumer/Reporter actors, and also between the Dose Reporter and the Dose Registry systems. However, most of third party application have a very light needs for the Dose report. For example, RIS systems in France needs only for CT Dose Length Product Total from the CT RDSR, in order to fit local reglementations. 

The emergence of HL7 FHIR simplified the exchange between backend applications and third parties through the exchange of normalized resources. This analysis allows to share minimal dose information through FHIR resources.

