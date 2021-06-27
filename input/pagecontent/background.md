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

The IHE Dose Reporter actor from the IHE REM profile gathers Radiation information and dose reports from modalities. However, there is no standardization of the exposure of the gathered data to third parties in a light API based format. 

![Problematic](./problematic.png){: width="800px"}

<br clear="all" />

 Dose Management systems need to share information related to the exam to multiple third parties:

* Mobile Applications: like patients related mobile applications, where a patient may want to centralize the report of doses injected to him
* RIS/EHR: many RIS/EHR systems do not have capabilities to read DICOM SR documents and prefer to contact the hospital dose management system in order to gather a summary of the dose report; and in order to include the radiation summary under the final imaging report.
* Third backend systems: some third backend applications may want to gather a summary of the exam’s radiations for some proprietary usage; gathering the complete RDSR is useless for most of the non Dose Management systems.

The RDSRs have a complete and a strong structure for sharing the dose information from the modalities to the Dose Consumer/Reporter actors, and also between the Dose Reporter and the Dose Registry systems. However, most of third party applications have a very light needs for the Dose report. For example, RIS systems in France need only, for CT exams, the Dose Length Product Total data from the CT RDSR, in order to fit local regulations. 

The emergence of HL7 FHIR simplified the exchange between backend applications and third parties through the exchange of normalized resources having stable structures. This analysis allows to share minimal dose information through FHIR resources.

<a name="scope"></a>

### Scope

Scope:
* Share a summary of dose information by exam through FHIR
* Irradiations received by the patient
* The targeted modalities are CT/XA/RF/MG/NM

Out Of Scope:
* Share details of the radiation administration
* Share enhanced data (SSDE, Organ Dose, etc.) to third applications
* Irradiations received by the practitioner

Dealing with sharing details of radiation procedures, like the X-Ray parameters, the modality configuration, etc., is out of scope. Also, sharing the details of enhanced dose data, like the size specific dose estimation, is also out of scope. Other means exist to share this detailed information, mainly the DICOM Radiation Structured Reports (RDSRs).

Radiotherapy procedures are not covered by the scope of this work, only diagnostic imaging radiations is covered by this work. 

<a name="usecases"></a>

### Use cases
Three use cases were identified.


#### Use case 1: Imaging report construction

![Use case 1: Imaging report construction](./usecase1.png){: width="800px"}

<br clear="all" />

* The Patient performs an irradiating exam within a modality.
* The modality shares the dose report to the Dose Management System, which may implement the IHE REM Dose Reporter actor. This dose information sharing can follow the REM profile schema. 
* After analyzing the exam images, the radiologist sends its notes to the Radiology Information System (RIS).
* In order to construct the final imaging report, the RIS needs to gather a summary of the radiation received by the patient. The RIS send a query to the Dose management system and get minimal dose information report.
* The minimal dose information is then integrated to the final report, which can be a CDA report following the DICOM Imaging report specification in PS3.20.
* The final report is shared with the hospital EHR or with the regional/national radiology report repository, through IHE XDS-I.b for example.

This use case is very common within RIS systems not supporting dose management modules. In fact, gathering of dose information from modalities can be very complex:

* It is based on multiple sources of data: RDSR, MPPS, SC & OCR, and DICOM images header.
* The reporting of the dose information by the modalities may contain misinterpretations and errors

It is the role of the Dose management system to provide the RIS with the right information regarding the dose administered to the patients. Reporting the minimal dose information inside the final imaging report is recommended by many stakeholders and organizations, and sometimes it is a regulation. For example, in France there are the Order of 22 September 2006 relating to the radiation information to be included in an act report using ionizing radiation, from the French Minister of Health and Solidarity, and describing some dose information that needs to be present in the final report.

The same kind of regulations exists in California in the US about the CT exams, which is the Senate Bill No. 1237. 

#### Use case 2: Mobile applications access

The exposure of the Dose Summary as FHIR resources opens the doors to the mobile applications to gather the dose information from the Dose management systems, or from the EMR if the Dose Summary is propagated to the EMR. Many applications may benefit from this additional patient data in order to add tracking of the patient dose information. Some patient facing applications can track the dose summary through multiple facilities. Other practitioner mobile applications can benefit from the Dose Summary data in order to collect more data for practitioner, or to improve their Clinical Decision Support (CDS) component.

#### Use case 3: Business Intelligence

The exposure of the Dose Summary as a FHIR resources is beneficial for Business Intelligence applications exposing metrics on dose data. In fact, multiple metrics can be normalized within a FHIR server collecting the Dose Summary resources, like:

* Comparison of average of Dose between modalities
* Comparison of average of Dose between facilities/hospital
* Comparison of dose administration characteristics between patient cohorts
* Comparison between dose administration levels between regions within a national FHIR server


<a name="mindose"></a>

### Minimal Radiation Information
#### Identification

In this paragraph, we analyze the mapping between the identified minimal dose information and some specifications on dose information reporting coming from multiple stakeholders:

* [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html){:target="_blank"}
* [DICOM PS3.16: Content Mapping Resource](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/PS3.16.html){:target="_blank"}
    * [X-Ray Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html){:target="_blank"}
    * [CT Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html){:target="_blank"}
    * [Radiopharmaceutical Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html){:target="_blank"}
    * [TID 2008 - Radiation Exposure and Protection Information](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_2008){:target="_blank"}
* France guidelines
    * French Society of Radiology - SFR, [Practical Guide for Interventional Radiology](http://gri.radiologie.fr/){:target="_blank"} (Guideline - 2013)
    * High Authority of Health - HAS, [Patient radiation protection and analysis of CPD practices and certification of healthcare establishments](https://www.has-sante.fr/upload/docs/application/pdf/2013-07/radioprotection_du_patient_et_analyse_des_pratiques_dpc_et_certification_des_etablissements_de_sante_format2clics.pdf){:target="_blank"} (Guideline - 2012)
    * [Presentation of the main radiation protection regulatory provisions applicable in medical and dental radiology](https://www.cd2-conseils.com/wp-content/uploads/2016/11/rp_asn_presentation-principales-dispositions-reglementaires_2016.pdf){:target="_blank"} (Guideline: 2016)
    * French Minister of Health and Solidarity, [Order of 22 September 2006 relating to the radiation information to be included in an act report using ionizing radiation](https://www.legifrance.gouv.fr/eli/arrete/2006/9/22/SANY0623888A/jo/texte){:target="_blank"}, (Order - 2006)
* Finnish Imaging Report specification, [KanTa Imaging CDA R2 document structures](http://www.hl7.fi/hl7-rajapintakartta/kanta-%E2%80%93-kuvantamisen-cda-r2-rakenne/){:target="_blank"} (2013)
* US, California State
    * AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf){:target="_blank"}
    * [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf){:target="_blank"}
    * AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf){:target="_blank"}
    * [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693){:target="_blank"}
    * University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation.](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf){:target="_blank"}

The analysis of the different specifications allowed to obtain the following coverage between the minimal dose information and these specifications/guidelines:

![Minimal Dose Information](./mindose.png){: width="900px"}

<br clear="all" />

#### Concepts mapping

The identified minimal dose information that should be collected by the dose management system and shared with third parties applications are divided into contextual information data and dose measurements data.

Contextual Information data:

| Contextual Information         |      Identifier       | Level |
|--------------------------------|-----------------------|-------|
| Irradiation Authorizing Person | [EV (113850, DCM, Irradiation Authorizing)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113850){:target="_blank"} | Procedure |
| Pregnancy Observation          | [EV (82810-3, LN, Pregnancy status)](http://snomed.info/id/364320009){:target="_blank"} | Procedure |
| Indication Observation         | [EV (18785-6, LN, Indications for Procedure)](http://loinc.org/18785-6/){:target="_blank"} | Procedure |
| Irradiating Device             | [EV (113859, DCM, Irradiating Device)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113859){:target="_blank"} | Procedure |
| Irradiation Issued Date        | [EV (113809, DCM, Start of X-Ray Irradiation)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113809){:target="_blank"} | Procedure |
| Related Imaging Study          | [EV (110180, DCM, Study Instance UID)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_110180){:target="_blank"} | Procedure |
{:.table-striped .table-bordered}

Dose measurements data:

| Dose Measurements | Identifier | Level | Type | Unit |
|---------------------------------------|--------------------------------------------|--------------|
| Dose (RP) Total        | [EV (113725, DCM, Dose (RP) Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113725){:target="_blank"}       | Procedure | Quantity | mGy |
| Accumulated Average Glandular Dose        |      [EV (111637, DCM, Accumulated Average Glandular Dose)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_111637){:target="_blank"}       | Procedure   | Quantity   | mGy |
| Dose Area Product Total        | [EV (113722, DCM, Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113722){:target="_blank"}      | Procedure  |  Quantity    | mGy.cm2 |
| Fluoro Dose Area Product Total | [EV (113726, DCM, Fluoro Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113726){:target="_blank"}       | Procedure  |  Quantity    | mGy.cm2 |
| Acquisition Dose Area Product Total        | [EV (113727, DCM, Acquisition Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113727){:target="_blank"}       | Procedure  |  Quantity    | mGy.cm2 |
| Total Fluoro Time              | [EV (113730, DCM, Total Fluoro Time)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113730){:target="_blank"}      | Procedure  |  Quantity    | s |
| Total Number of Radiographic Frames        | [EV (113731, DCM, Total Number of Radiographic Frames)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113731){:target="_blank"}       | Procedure  |  Integer    |  |
| CT Dose Length Product Total   | [EV (113813, DCM, CT Dose Length Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113813){:target="_blank"}       |Procedure  |  Quantity    | mGy.cm |
| Administered activity          | [EV (113507, DCM, Administered activity)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113507){:target="_blank"} | Administration  |  Quantity    | MBq |
| Radiopharmaceutical Agent      | [EV (349358000, SCT, Radiopharmaceutical agent)](http://snomed.info/id/349358000){:target="_blank"} | Administration | CodeableConcept |  |
| Radionucleide                  | [EV (89457008, SCT, Radionuclide)](http://snomed.info/id/89457008){:target="_blank"} | Administration | CodeableConcept |  |
| Radiopharmaceutical Volume     | [EV (123005, DCM, Radiopharmaceutical Volume)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_123005){:target="_blank"}       | Administration | Quantity | cm3 |
| Route of administration        | [EV (410675002, SCT, Route of administration)](http://snomed.info/id/410675002){:target="_blank"}       | Administration | CodeableConcept |  |
| Mean CTDIvol                   | [EV (113830, DCM, Mean CTDIvol)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113830){:target="_blank"}      | Irradiation Event | Quantity | mGy |
| DLP                           | [EV (113838, DCM, DLP)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113838){:target="_blank"}      | Irradiation Event | Quantity | mGy.cm |
| Target Region                 | [EV (123014, DCM, Target Region)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_123014){:target="_blank"}      | Irradiation Event | CodeableConcept |  |
| CTDIw Phantom Type            | [EV (113835, DCM, CTDIw Phantom Type)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113835){:target="_blank"}      | Irradiation Event | CodeableConcept |  |
{:.table-striped .table-bordered}

**Remarks**:
* We highlighted the "Dose (RP) Total" and not the "Entrance Exposure at RP", as the latter one is related to the irradiation event level, and not the procedure level. Even if the PS3.20 is referencing the Entrance Exposure at RP, the IEC 61910-1 is referencing the Dose (RP) Total in the Basic Dose Documentation conformance.
* For NM, most of the minimal dose information related to procedure are described in the irradiation event level of the RRDSR structure. However, as there is only one irradiation event per RRDSR, we considered that these minimal dose information are related to the procedure level. However, this implies that for the same NM imaging procedure, multiple Radiation Dose Summaries can be reported. This should not be a problem, as in this case the Radiation Dose Summary is related to the administration act, more than the procedure act.
* The irradiation Issued Date has different significations, based on the targeted procedure type; in CT, it is the start date of the irradiation act, in XA/RF/MG, it is the Series Date Time, and in NM, it is the administration date time.
* The associated procedure is referenced through the related Imaging Study.
* The calibration factors are not reported as part of the minimal dose information. The generator of the Radiation Dose Summary resources shall take in consideration these calibration factors.
* Based on the analyzes performed, there is no minimal dose information related to the level Irradiation Event and part of the modalities XA/RF/MG. 

<a name="glossary"></a>

### Glossary

The following terms and initialisms/acronyms are used within the Radiation Dose Summary IG:

|Term|Definition|
|-----|-----------------|
|ATNA| Audit Trail and Node Authentication |
|CDA| Clinical Document Architecture |
|CDS| Clinical Decision Support |
|CT| Computed Tomography |
|CTDI| Computed Tomography Dose Index |
|DAP| Dose Area Product |
|DLP| Dose Length Product |
|DICOM| Digital Imaging and Communications in Medicine |
|EHR| Electronic Health Record |
|EMR| Electronic Medical Record |
|FHIR| Fast Healthcare Interoperability Resources |
|HAS| French High Authority of Health |
|HL7| Health Level Seven|
|IG| Implementation Guide |
|IHE| Integrating the Healthcare Enterprise |
|IOD| Information Object Definition |
|IPS| International Patient Summary |
|MG| Mammography |
|MPPS| Modality Performed Procedure Step |
|NM| Nuclear Medicine |
|OCR| Optical Character Recognition |
|RDSC| Radiation Dose Summary Consumer |
|RDSP| Radiation Dose Summary Producer |
|RDSR| Radiation Dose Structured Report |
|REM| Radiation Exposure Monitoring|
|REM-NM| Radiation Exposure Monitoring for Nuclear Medicine |
|RF| Radio Fluoroscopy |
|RIS| Radiology Information System |
|RP|  Reference Point |
|RRDSR| Radiopharmaceutical Radiation Dose Structured Report |
|SFR| French Society of Radiology |
|SR| Structured Report |
|SSDE| Size Specific Dose Estimation |
|TID| Template ID |
|TLS| Transport Layer Security |
|UID| Unique identifier |
|URL| Uniform Resource Locator |
|URN| Uniform Resource Name |
|VR| Value Representation |
|XA| X-Ray Angiography |
|XDS-I.b| Cross-enterprise Document Sharing for Imaging |
{:.table-striped .table-bordered}

<a name="references"></a>

### References

1. DICOM, [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html){:target="_blank"}
2. DICOM, [DICOM PS3.16: Content Mapping Resource](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/PS3.16.html){:target="_blank"}
3. DICOM, [X-Ray Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html){:target="_blank"}
4. DICOM, [CT Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html){:target="_blank"}
5. DICOM, [Radiopharmaceutical Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html){:target="_blank"}
6. DICOM, [TID 2008\. Radiation Exposure and Protection Information](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_2008){:target="_blank"}
7. French Society of Radiology - SFR,  [Practical Guide for Interventional Radiology](http://gri.radiologie.fr/){:target="_blank"}  (Guideline - 2013)
8. French High Authority of Health - HAS,  [Patient radiation protection and analysis of CPD practices and certification of healthcare establishments](https://www.has-sante.fr/upload/docs/application/pdf/2013-07/radioprotection_du_patient_et_analyse_des_pratiques_dpc_et_certification_des_etablissements_de_sante_format2clics.pdf){:target="_blank"}  (Guideline - 2012)
9. French nuclear safety authority, [Presentation of the main radiation protection regulatory provisions applicable in medical and dental radiology](https://www.cd2-conseils.com/wp-content/uploads/2016/11/rp_asn_presentation-principales-dispositions-reglementaires_2016.pdf){:target="_blank"}  (Guideline: 2016)
10. French Minister of Health and Solidarity,  [Order of 22 September 2006 relating to the radiation information to be included in an act report using ionizing radiation](https://www.legifrance.gouv.fr/eli/arrete/2006/9/22/SANY0623888A/jo/texte){:target="_blank"}, (Order - 2006)
11. Finnish Imaging Report specification,  [KanTa Imaging CDA R2 document structures](http://www.hl7.fi/hl7-rajapintakartta/kanta-%E2%80%93-kuvantamisen-cda-r2-rakenne/){:target="_blank"}  (2013)
12. Finnish Radiation and Nuclear Safety Authority, [Röntgentutkimuksesta potilaalle aiheutuvan säteilyaltistuksen määrittäminen](https://www.julkari.fi/bitstream/handle/10024/125145/rontgensateily.pdf){:target="_blank"} (X-ray examination of the patient radiation exposure determination)
13. AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf){:target="_blank"}
14. [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf){:target="_blank"}
15. AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf){:target="_blank"}
16. [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693){:target="_blank"}
17. University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf){:target="_blank"}
18. IEC, [IEC 61910-1:2014 - Medical electrical equipment - Radiation dose documentation - Part 1: Radiation dose structured reports for radiography and radioscopy](https://webstore.iec.ch/publication/6091){:target="_blank"}
19. IHE Radiology (RAD), [Technical Framework Volume 1, Cross-enterprise Document Sharing for Imaging (XDS-I.b)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_TF_Vol1.pdf){:target="_blank"}
20. IHE Radiology (RAD), [Technical Framework Volume 1, Radiation Exposure Monitoring (REM)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_TF_Vol1.pdf){:target="_blank"}
21. HL7 International, [International Patient Summary Implementation Guide (IPS)](https://hl7.org/fhir/uv/ips/STU1/)
