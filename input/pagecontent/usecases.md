Three use cases were identified.


### Use case 1: Imaging report construction

![Use case 1: Imaging report construction](./usecase1.png){: width="800px"}

<br clear="all" />

* The Patient perform an irradiating exam within a modality.
* The modality share the dose report to the Dose Management System, which may implement the IHE REM Dose Reporter actor. This dose information sharing can follow the REM profile schema. 
* After analysing the exam images, the radiologist sends its notes to the Radiology Information System (RIS).
* In order to construct the final imaging report, the RIS needs to gather a minimal summary of the dose received by the patient. The RIS send a query to the Dose Registry and get minimal dose information report.
* The response is then integrated to the final report, which can be a CDA report following the DICOM Imaging report specification in PS3.20.
* The final report is shared with the hospital EHR or with the regional/national radiology report repository, through IHE XDS-I.b for example.

This use case is very common within RIS systems not supporting dose management modules. In fact, gathering of dose information from modalities can be very complex:

* It is based on multiple sources of data: RDSR, MPPS, SC & OCR, and DICOM images header.
* The reporting of the dose information by the modalities may contains misinterpretations and errors

It is the role of the Dose management system to provide the RIS with the right information regarding the dose administered to the patients. Reporting the minimal dose information inside the final imaging report is recommended by many stakeholders and organizations, and sometimes it is a reglementation. For example, in France there are the Order of 22 September 2006 relating to the dosimetric information to be included in an act report using ionizing radiation, from the French Minister of Health and Solidarity, and describing some dose information that need to be present in the final report.

The same kind of regulations exists in California in the US about the CT exams, which is the Senate Bill No. 1237. 

### Use case 2: Mobile applications access

The exposure of the Dose Summary as FHIR resources open the doors to the mobile applications to gather the dose information from the Dose management systems, or from the EMR if the Dose Summary is propagated to the EMR. Many applications may benefit from this additional patient data in order to add tracking of the patient dose information. Some patient facing applications can track the dose summary through multiple facilities and then concentrate the dose data. Other practitioner mobile applications can benefit from the Dose Summary data in order to collect more data for practitioner, or to improve their Clinical Decision Support (CDS) component.

### Use case 3: Business Intelligence

The exposure of the Dose Summary as a FHIR resources is beneficial for Business Intelligence application exposing metrics on dose data. In fact, multiple metrics can be normalized within a FHIR server collecting the Dose Summary resources, like:

* Comparison of average of Dose between modalities
* Comparison of average of Dose between facilities/hospital
* Comparison of dose administration characteristics between patient cohorts
* Comparison between dose administration levels between regions within a national FHIR server
