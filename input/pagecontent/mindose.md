### Identification

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

### Concepts mapping

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
|--------------------------|-----------------------|--------------|
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
