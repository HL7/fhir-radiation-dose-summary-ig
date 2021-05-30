This chapter describes the scope of this guide, provides background information about the radiation dose summary IG, key concepts,
and describes the use cases supported by this implementation guide.

1. [Problematic](#problematic) - Description of the problematic
2. [Scope](#scope) - Scope of the IG
3. [Use cases](#usecases) - Key use cases covered by the IG
4. [Minimal Radiation Information](#mindose) - Description of data shared through this IG
5. [Glossary](#glossary) - Glossary of terms used in this IG
5. [References](#references) - Useful references

<a name="problematic"></a>

### Problematic

The IHE Dose Reporter actor from the IHE REM profile gather Radiation information and dose reports from modalities. However, there is no standardization of the exposure of the gathered data to third parties in light format/API. 

![Problematic](./problematic.png){: width="800px"}

<br clear="all" />

 Dose Management systems need to share information related to the exam to multiple third parties :

* Mobile Applications: like patients related mobile application, where a patient may want to centralize the report of doses injected to him
* RIS/EHR : many RIS/EHR systems does not have capabilities to read DICOM SR documents and prefer to contact the hospital dose registry in order to gather a summary of the dose report; and in order to include the summary under the final imaging report.
* Third backend systems: some third backend application may want to gather a summary of the exam’s dose for some proprietary use; gathering the complete RDSR is useless for most of the non Dose Management systems

The RDSRs have a complete and a strong structure for sharing the dose information from the modalities to the Dose Consumer/Reporter actors, and also between the Dose Reporter and the Dose Registry systems. However, most of third party application have a very light needs for the Dose report. For example, RIS systems in France needs only for CT Dose Length Product Total from the CT RDSR, in order to fit local reglementations. 

The emergence of HL7 FHIR simplified the exchange between backend applications and third parties through the exchange of normalized resources. This analysis allows to share minimal dose information through FHIR resources.

<a name="scope"></a>

### Scope

Scope:
* Share a summary of dose information by exam through FHIR
* Irradiations received by the patient
* The targeted modalities are CT/XA/RF/MG/NM

Out Of Scope:
* Share details of the radiation administration
* Share enhanced data (SSDE, Organ Dose, etc) to third applications
* Irradiations received by the practitioner

Dealing with sharing details of radiation procedures, like the X-Ray parameters, the modality configuration, etc, is out of scope. Also, sharing the details of enhanced dose data, like the size specific dose estimation, is also out of scope. Other means exist to share these detailed information, mainly the DICOM Radiation Structured Reports (RDSRs).

Radiotherapy procedures are not covered by the scope of this work, only diagnostic imaging radiations is covered by this work. 

<a name="usecases"></a>

### Use cases
Three use cases were identified.


#### Use case 1: Imaging report construction

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

#### Use case 2: Mobile applications access

The exposure of the Dose Summary as FHIR resources open the doors to the mobile applications to gather the dose information from the Dose management systems, or from the EMR if the Dose Summary is propagated to the EMR. Many applications may benefit from this additional patient data in order to add tracking of the patient dose information. Some patient facing applications can track the dose summary through multiple facilities and then concentrate the dose data. Other practitioner mobile applications can benefit from the Dose Summary data in order to collect more data for practitioner, or to improve their Clinical Decision Support (CDS) component.

#### Use case 3: Business Intelligence

The exposure of the Dose Summary as a FHIR resources is beneficial for Business Intelligence application exposing metrics on dose data. In fact, multiple metrics can be normalized within a FHIR server collecting the Dose Summary resources, like:

* Comparison of average of Dose between modalities
* Comparison of average of Dose between facilities/hospital
* Comparison of dose administration characteristics between patient cohorts
* Comparison between dose administration levels between regions within a national FHIR server


<a name="mindose"></a>

### Minimal Radiation Information
#### Identification

In this paragraph we analysed the mapping between the identified minimal dose information and some specifications on dose information reporting coming from multiple stakeholders:

* [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html)
* [DICOM PS3.16: Content Mapping Resource](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/PS3.16.html)
    * [X-Ray Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html)
    * [CT Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html)
    * [Radiopharmaceutical Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html)
    * [TID 2008 - Radiation Exposure and Protection Information](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_2008)
* France guidelines
    * French Society of Radiology - SFR, [Practical Guide for Interventional Radiology](http://gri.radiologie.fr/) (Guideline - 2013)
    * High Authority of Health - HAUS, [Patient radiation protection and analysis of CPD practices and certification of healthcare establishments](https://www.has-sante.fr/upload/docs/application/pdf/2013-07/radioprotection_du_patient_et_analyse_des_pratiques_dpc_et_certification_des_etablissements_de_sante_format2clics.pdf) (Guideline - 2012)
    * [Presentation of the main radiation protection regulatory provisions applicable in medical and dental radiology](https://www.cd2-conseils.com/wp-content/uploads/2016/11/rp_asn_presentation-principales-dispositions-reglementaires_2016.pdf) (Guideline: 2016)
    * French Minister of Health and Solidarity, [Order of 22 September 2006 relating to the dosimetric information to be included in an act report using ionizing radiation](https://www.legifrance.gouv.fr/eli/arrete/2006/9/22/SANY0623888A/jo/texte), (Order - 2006)
* Finnish Imaging Report specification, [KanTa Imaging CDA R2 document structures](http://www.hl7.fi/hl7-rajapintakartta/kanta-%E2%80%93-kuvantamisen-cda-r2-rakenne/) (2013)
* US, California State
    * AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf)
    * [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf)
    * AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf)
    * [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693)
    * University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation.](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf)

The analysis of the different specifications allowed to obtain the following coverage between the minimal dose information and these specifications/guidelines:

![Minimal Dose Information](./mindose.png){: width="800px"}

<br clear="all" />

#### Concepts mapping

The identified minimal dose information that should be collected by the dose management system and shared with third parties application, are divided into contextual information data and dose measurements data.

Contextual Information data:

| Contextual Information   |      Identifier       |  Description |
|--------------------------|-----------------------|--------------|
| Irradiation Authorizing Person |  EV (113850, DCM, "Irradiation Authorizing") | The clinician responsible for determining that the irradiating procedure was appropriate for the indications. |
| Pregnancy Observation          |    EV (364320009, SCT, "Pregnancy observable")   | Pregnancy observable  |
| Indication Observation         | EV (18785-6, LN, "Indications for Procedure") |    Radiology Reason for study |
| Alert Observation              | EV (113900, DCM, "Dose Check Alert Details") |    Report section about cumulative dose alerts during an examination. |
| Irradiating Device | EV (113859, DCM, "Irradiating Device")         |  A device exposing a patient to ionizing radiation. |
| Irradiation Issued Date        | EV (113809, DCM, "Start of X-Ray Irradiation") |    Start DateTime of the first X-Ray Irradiation Event of the accumulation within a Study.|
| Related Imaging Study          |       EV (110180, DCM, "Study Instance UID")       |  Related performed study. |
{:.table-striped .table-bordered}

Dose measurements data:

| Dose Measurements        |      Identifier       |  Description |
|---------------------------------------|--------------------------------------------|--------------|
| Entrance Exposure at RP        |      EV (111636, DCM, "Entrance Exposure at RP")       |  Exposure measurement in air at the reference point that does not include back scatter, according to MQCM 1999. |
| Accumulated Average Glandular Dose        |      EV (111637, DCM, "Accumulated Average Glandular Dose")       |  Average Glandular Dose to a single breast accumulated over multiple images. |
| Dose Area Product Total        |      EV (113722, DCM, "Dose Area Product Total")       |  Total calculated Dose Area Product (in the scope of the including report). |
| Fluoro Dose Area Product Total |       EV (113726, DCM, "Fluoro Dose Area Product Total")       |  Total calculated Dose Area Product applied in Fluoroscopy Modes (in the scope of the including report). |
| Acquisition Dose Area Product Total        |       EV (113727, DCM, "Acquisition Dose Area Product Total")       |  Total calculated Dose Area Product applied in Acquisition Modes (in the scope of the including report). |
| Total Fluoro Time              |       EV (113730, DCM, "Total Fluoro Time")       |  Total accumulated clock time of Fluoroscopy in the scope of the including report (i.e., the sum of the Irradiation Duration values for accumulated fluoroscopy irradiation events). |
| Total Number of Radiographic Frames        |       EV (113731, DCM, "Total Number of Radiographic Frames")       |  Accumulated Count of exposure pulses (single or multi-frame encoded) created from irradiation events performed with high dose (acquisition). |
| CT Dose Length Product Total   |       EV (113813, DCM, "CT Dose Length Product Total")       |  The total dose length product defined scope of accumulation. |
| Total Number Of Irradiation Events |       EV (113812, DCM, "Total Number Of Irradiation Events")       |  Total number of events during the defined scope of accumulation. |
| Mean CTDIvol                   |       EV (113830, DCM, "Mean CTDIvol")       |  "Mean CTDIvol" refers to the average value of the CTDIvol associated with this acquisition. |
| Effective Dose                 |       EV (113839, DCM, "Effective Dose")       |  Effective dose in mSv. When the exam is in CT modality, the value is collected from "CT Effective Dose Total" from the TID 10012. CT Accumulated Dose Data. |
| Administered activity          |       EV (113507, DCM, "Administered activity")       |  The calculated activity at the Radiopharmaceutical Start Time when the radiopharmaceutical is administered to the patient. The residual activity (i.e.,  adiopharmaceutical not administered) , if measured, is reflected in the calculated value. The estimated extravasation is not reflected in the calculated value. |
| Radiopharmaceutical Agent      |       EV (349358000, SCT, "Radiopharmaceutical agent").       |  Active ingredient (molecular) used for radioactive tracing. |
| Radionucleide                  |       EV (89457008, SCT, "Radionuclide")       |  Isotopes in Radiopharmaceutical agent |
| Radiopharmaceutical Volume     |       EV (123005, DCM, "Radiopharmaceutical Volume")       |  Volume of radiopharmaceutical administered to the patient. |
| Route of administration        |   EV (410675002, SCT, "Route of administration")       |  Example: Intravenous, Intramuscular, etc. |
{:.table-striped .table-bordered}

<a name="glossary"></a>

### Glossary

The following terms and initialisms/acronyms are used within the Radiation Dose Summary IG:

|Term|Definition|
|CDS| Clinical Decision Support |
|CT| Computed Tomography |
|DICOM| Digital Imaging and Communications in Medicine |
|EHR| Electronic Health Record |
|EMR| Electronic medical record |
|FHIR| Fast Healthcare Interoperability Resources |
|HAUS| French High Authority of Health |
|HL7| Health Level Seven|
|IG| Implementation Guide |
|IHE| Integrating the Healthcare Enterprise |
|IOD| Information Object Definition |
|MG| Mammography |
|MPPS| Modality Performed Procedure Step |
|NM| Nuclear Medecine |
|OCR| Optical Character Recognition |
|REM| Radiation Exposure Monitoring|
|RDSC| Radiation Dose Summary Consumer |
|RDSP| Radiation Dose Summary Producer |
|RDSR| Radiation Dose Structured Report |
|RF| Radio Fluoroscopy |
|RIS| Radiology Information System |
|RRDSR| Radiopharmaceutical Radiation Dose Structured Report |
|SFR| French Society of Radiology |
|SR| Structured Report |
|SSDE| Size Specific Dose Estimation |
|TID| Template ID |
|XA| X-Ray Angiography |
{:.table-striped .table-bordered}

<a name="references"></a>

### References

1. DICOM, [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html)
2. DICOM, [DICOM PS3.16: Content Mapping Resource](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/PS3.16.html)
3. DICOM, [X-Ray Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html)
4. DICOM, [CT Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html)
5. DICOM, [Radiopharmaceutical Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html)
6. DICOM, [TID 2008\. Radiation Exposure and Protection Information](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_2008)
7. French Society of Radiology - SFR,  [Practical Guide for Interventional Radiology](http://gri.radiologie.fr/)  (Guideline - 2013)
8. French High Authority of Health - HAUS,  [Patient radiation protection and analysis of CPD practices and certification of healthcare establishments](https://www.has-sante.fr/upload/docs/application/pdf/2013-07/radioprotection_du_patient_et_analyse_des_pratiques_dpc_et_certification_des_etablissements_de_sante_format2clics.pdf)  (Guideline - 2012)
9. French nuclear safety authority, [Presentation of the main radiation protection regulatory provisions applicable in medical and dental radiology](https://www.cd2-conseils.com/wp-content/uploads/2016/11/rp_asn_presentation-principales-dispositions-reglementaires_2016.pdf)  (Guideline: 2016)
10. French Minister of Health and Solidarity,  [Order of 22 September 2006 relating to the dosimetric information to be included in an act report using ionizing radiation](https://www.legifrance.gouv.fr/eli/arrete/2006/9/22/SANY0623888A/jo/texte), (Order - 2006)
11. Finnish Imaging Report specification,  [KanTa Imaging CDA R2 document structures](http://www.hl7.fi/hl7-rajapintakartta/kanta-%E2%80%93-kuvantamisen-cda-r2-rakenne/)  (2013)
12. Finnish Radiation and Nuclear Safety Authority, [Röntgentutkimuksesta potilaalle aiheutuvan säteilyaltistuksen määrittäminen](https://www.julkari.fi/bitstream/handle/10024/125145/rontgensateily.pdf) (X-ray examination of the patient radiation exposure determination)
13. AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf)
14. [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf)
15. AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf)
16. [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693)
17. University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf)

