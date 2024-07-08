This chapter describes the scope of this guide, provides background information about the radiation dose summary IG, key concepts, and describes the use cases supported by this implementation guide.

1. [Problem](#problem) - Description of the problem
2. [Scope](#scope) - Scope of the IG
3. [Use case](#usecases) - Key use case covered by the IG
4. [Minimal Radiation Information](#mindose) - Description of data shared through this IG
5. [Underlying specifications](#underlying-specs) - Description of the underlying specifications and resources.
6. [Glossary](#glossary) - Glossary of terms used in this IG
7. [References](#references) - Useful references

<a name="problem"></a>

### Problem

The IHE Dose Reporter actor within the IHE (Radiation Exposure Monitoring) REM profile gathers radiation information and dose reports from modalities. However, there is no standard to expose a dose summary to third parties in a light API based format. 

![Problem](./problem.svg){: width="600px"}

<br clear="all" />

Note: This IG also supports the summary of Radiopharmaceutical dose (not depicted above), in which Radiopharmaceutical Activity Information is provided to the Dose Info Reporter by the Radiopharmaceutical Activity Supplier. See [IHE REM for Nuclear Medicine (REM-NM)](https://ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_Suppl_REM-NM.pdf){:target="_blank"} for more information.

The Dose Reporter (a.k.a. Dose Management system) needs to share information related to exam dose to multiple systems outside the REM profile.

Radiation Dose Structured Reports (RDSRs) and Radiopharmaceutical Radiation Dose SRs (RRDSRs) have a complete and stable structure for recording dose information however, many Radiology Information (RIS) and Electronic Health Record (EHR) systems lack the capability to consume them. In most cases, the RIS/EHR need are light, requiring only a dose summary for inclusion in radiology reports, warranting a lightweight standard to obtain the necessary information from the Dose Management system.

The emergence of HL7 FHIR simplified the exchange between back end applications and other systems through the exchange of resources with stable structures. This IG facilitates the sharing of minimal dose information through FHIR Resources.

<a name="scope"></a>

### Scope

The defined profiles in this IG describe radiation information within a unique irradiation act, which may contain multiple irradiation events. 
This IG does not provide sufficient information to guide patient care decisions, or to influence decision making prior to prescribing studies. 

In Scope:
* Summary of dose information by exam through FHIR
* Irradiation to which the patient was exposed
* CT, XA, DX, RF, MG, NM

Out of Scope:
* Details of radiation administration
* Enhanced data (SSDE, Organ Dose, etc.)
* Cumulative calculation of radiation over time
* Irradiation to which the practitioner was exposed
* Radiotherapy


Details of radiation administration (e.g., X-ray parameters, modality configuration, etc.) and enhanced  data (e.g., size specific dose estimation), are available in DICOM Radiation Structured Reports (RDSRs).

Interpretation of radiation information may be influenced by several external factors not addressed in this IG.

The FHIR profiles defined in this IG are a solution to simplify sharing the radiation summary information between applications. This IG is not meant to describe how the radiation data is assessed or who can access and interpret it. Such interpretation requires domain expertise and additional data not available in RDSRs or RRDSRs. Implementers are urged to follow international and national regulations and recommendations, such as [AAPM/ACR/HPS Joint Statement on Proper Use of Radiation Dose Metric Tracking for Patients Undergoing Medical Imaging Exams](https://www.aapm.org/org/policies/details.asp?id=1533&type=PP){:target="_blank"}.

<a name="usecases"></a>

### Use case: Imaging report construction

![Use case 1: Imaging report construction](./usecase1.svg){: width="800px"}

<br clear="all" />

The main use case identified for this implementation guide is the following: 

* The modality transfers the dose report to the Dose Management System (i.e. IHE REM Dose Reporter). 
* After analyzing the study, the radiologist dictates a report within the Radiology Information System (RIS).
* The RIS queries the Dose Management system to obtain a Dose Summary.
* The RIS incorporates the Dose Summary into to the report.
* The radiologist signs the final report.
* The report is available in the hospital EHR.
* Optionally (not shown), the report is shared with the regional/national radiology report repository.

Note: this case shows the RIS pulling (GET) the Dose Summary, it could also be pushed (PUT)

This case is common in RIS systems without a dose management module, in which gathering dose information from multiple sources can be complex due to:
* multiple sources of data (e.g., RDSR, MPPS, SC & OCR, and DICOM image metadata), and
* coercion of reported data in order to provide summary. 

It is the role of the Dose Management system to provide the RIS with the correct information regarding the administered dose. Reporting the minimal dose information within the final imaging report is recommended by various organizations, and may be required by local regulation. For example:
* French order of 22 September 2006 requires the report to provide information justifying the procedure,the operations carried out, as well as the data used to estimate the dose received by the patient.
* California Senate bill Senate Bill No. 1237 requires "...health facilities and clinics that use imaging procedures that involve computed tomography X-ray systems (CT) for human use to record the dose of radiation on every CT study produced during a CT examination."

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
    * AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf){:target="_blank"}
    * [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf){:target="_blank"}
    * AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf){:target="_blank"}
    * [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693){:target="_blank"}
    * University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation.](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf){:target="_blank"}

The analysis of the different specifications allowed to obtain the following coverage between the minimal dose information and these specifications/guidelines:

<table class=MsoNormalTable border=0 cellspacing=0 cellpadding=0 width=1213 style='width:910.0pt;border-collapse:unset'>
    <tr style='height:15.6pt'>
        <td width=467 rowspan=2 style='width:350.5pt;border:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Dose Information</span>
                </b>
            </p>
        </td>
        <td width=193 colspan=5 style='width:144.85pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Modality</span>
                </b>
            </p>
        </td>
        <td width=18 style='width:13.85pt;border:solid windowtext 1.0pt;border-left:  none;background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </b>
            </p>
        </td>
        <td width=65 rowspan=2 style='width:48.75pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>PS3.20</span>
                </b>
            </p>
        </td>
        <td width=236 colspan=4 style='width:177.05pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>PS3.16</span>
                </b>
            </p>
        </td>
        <td width=18 style='width:13.85pt;border:solid windowtext 1.0pt;border-left:  none;background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </b>
            </p>
        </td>
        <td width=68 rowspan=2 style='width:50.85pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Finland</span>
                </b>
            </p>
        </td>
        <td width=62 rowspan=2 style='width:46.8pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>France</span>
                </b>
            </p>
        </td>
        <td width=85 rowspan=2 style='width:63.5pt;border:solid windowtext 1.0pt;  border-left:none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
            <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                <b>
                    <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>USA
                        <br>California
                        </span>
                    </b>
                </p>
            </td>
        </tr>
        <tr style='height:31.2pt'>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#D9E1F2;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>CT</span>
                    </b>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>XA</span>
                    </b>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>RF</span>
                    </b>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#D9E1F2;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>MG</span>
                    </b>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>NM</span>
                    </b>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                    </b>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>CT RDSR</span>
                    </b>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>X-Ray RDSR</span>
                    </b>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#D9E1F2;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>RRDSR</span>
                    </b>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>TID 2008</span>
                    </b>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:31.2pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                    </b>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Irradiation authorizing Person</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Pregnancy Observation</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Indication Observation</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Device</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Irradiation Issued Date</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Associated Procedure</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Dose measurements - Study level</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Dose (RP) Total</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border:none;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Accumulated Average Glandular Dose</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border:solid windowtext 1.0pt;border-left:  none;background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Dose Area Product Total</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Fluoro Dose Area Product Total</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Acquisition Dose Area Product Total</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Total Fluoro Time</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Total Number of Radiographic Frames</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>CT Dose Length Product Total</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Administered activity</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Radiopharmaceutical Agent</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Radionuclide</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Radiopharmaceutical Volume</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Route of administration</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal style='margin-bottom:0cm;line-height:normal'>
                    <b>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;color:black'>Dose measurements - Irradiation Event level</span>
                    </b>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#E7E6E6;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Mean CTDIvol</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>DLP</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>Target Region</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
        <tr style='height:15.6pt'>
            <td width=467 style='width:350.5pt;border:solid windowtext 1.0pt;border-top:  none;background:#D9E1F2;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=right style='margin-bottom:0cm;text-align:right;  line-height:normal'>
                    <i>
                        <span style='font-size:12.0pt;font-family:"Times New Roman",serif;  color:black'>CTDIw Phantom Type</span>
                    </i>
                </p>
            </td>
            <td width=37 style='width:27.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=38 style='width:28.15pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=36 style='width:26.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=42 style='width:31.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#F8CBAD;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=41 style='width:30.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#F8CBAD;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=65 style='width:48.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=58 style='width:43.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#C6E0B4;vertical-align:middle;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
            <td width=67 style='width:50.55pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=60 style='width:45.2pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=50 style='width:37.75pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=18 style='width:13.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  background:#E7E6E6;padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=68 style='width:50.85pt;border-top:none;border-left:none;  border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=62 style='width:46.8pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;padding:0cm 5.4pt 0cm 5.4pt;  height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>&nbsp;</span>
                </p>
            </td>
            <td width=85 style='width:63.5pt;border-top:none;border-left:none;border-bottom:  solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;background:#C6E0B4;vertical-align:middle;  padding:0cm 5.4pt 0cm 5.4pt;height:15.6pt'>
                <p class=MsoNormal align=center style='margin-bottom:0cm;text-align:center;  line-height:normal'>
                    <span style='font-size:10.0pt;font-family:"Times New Roman",serif;  color:black'>Y</span>
                </p>
            </td>
        </tr>
    </table>

#### Concepts mapping

The  minimal dose information that should be collected by the Dose Management system and shared with third party applications are divided into contextual data and dose measurement data.

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

| Dose Measurements | Identifier | DICOM TID | Level | Type | Unit/ValueSet |
|---------------------------------------|--------------------------------------------|--------------|
| Dose (RP) Total        | [EV (113725, DCM, Dose (RP) Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113725){:target="_blank"} | [TID 10007](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10007.html){:target="_blank"}| Procedure | Quantity | mGy |
| Accumulated Average Glandular Dose        |      [EV (111637, DCM, Accumulated Average Glandular Dose)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_111637){:target="_blank"} | [TID 10005](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10005.html){:target="_blank"} | Procedure   | Quantity   | mGy |
| Dose Area Product Total        | [EV (113722, DCM, Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113722){:target="_blank"} | [TID 10007](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10007.html){:target="_blank"} | Procedure  |  Quantity    | mGy.cm2 |
| Fluoro Dose Area Product Total | [EV (113726, DCM, Fluoro Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113726){:target="_blank"} | [TID 10004](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10004.html){:target="_blank"}  | Procedure  |  Quantity    | mGy.cm2 |
| Acquisition Dose Area Product Total        | [EV (113727, DCM, Acquisition Dose Area Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113727){:target="_blank"}  | [TID 10004](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10004.html){:target="_blank"} | Procedure  |  Quantity    | mGy.cm2 |
| Total Fluoro Time              | [EV (113730, DCM, Total Fluoro Time)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113730){:target="_blank"} | [TID 10004](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10004.html){:target="_blank"}  | Procedure  |  Quantity    | s |
| Total Number of Radiographic Frames        | [EV (113731, DCM, Total Number of Radiographic Frames)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113731){:target="_blank"} | [TID 10007](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10007.html){:target="_blank"} | Procedure  |  Integer    |  |
| CT Dose Length Product Total   | [EV (113813, DCM, CT Dose Length Product Total)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113813){:target="_blank"} | [TID 10012](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10012.html){:target="_blank"} | Procedure  |  Quantity    | mGy.cm |
| Administered activity          | [EV (113507, DCM, Administered activity)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113507){:target="_blank"} | [TID 10022](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10022.html){:target="_blank"} | Administration  |  Quantity    | MBq |
| Radiopharmaceutical Agent      | [EV (349358000, SCT, Radiopharmaceutical agent)](http://snomed.info/id/349358000){:target="_blank"} | [TID 10022](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10022.html){:target="_blank"} | Administration | CodeableConcept | [Radiopharmaceuticals Value Set](ValueSet-radiopharmaceutical-rds-vs.html) |
| Radionuclide                  | [EV (89457008, SCT, Radionuclide)](http://snomed.info/id/89457008){:target="_blank"} | [TID 10022](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10022.html){:target="_blank"} | Administration | CodeableConcept | [Isotopes Value Set](ValueSet-isotope-rds-vs.html) |
| Radiopharmaceutical Volume     | [EV (123005, DCM, Radiopharmaceutical Volume)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_123005){:target="_blank"} | [TID 10022](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10022.html){:target="_blank"} | Administration | Quantity | cm3 |
| Route of administration        | [EV (410675002, SCT, Route of administration)](http://snomed.info/id/410675002){:target="_blank"} | [TID 10022](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10022.html){:target="_blank"} | Administration | CodeableConcept | [Route of Administration](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_11.html){:target="_blank"} |
| Mean CTDIvol                   | [EV (113830, DCM, Mean CTDIvol)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113830){:target="_blank"} | [TID 10013](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html){:target="_blank"} | Irradiation Event | Quantity | mGy |
| DLP                           | [EV (113838, DCM, DLP)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113838){:target="_blank"} | [TID 10013](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html){:target="_blank"} | Irradiation Event | Quantity | mGy.cm |
| Target Region                 | [EV (123014, DCM, Target Region)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_123014){:target="_blank"} | [TID 10013](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html){:target="_blank"} | Irradiation Event | CodeableConcept | [Anatomy Imaged](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4030.html){:target="_blank"} |
| CTDIw Phantom Type            | [EV (113835, DCM, CTDIw Phantom Type)](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_D.html#DCM_113835){:target="_blank"} | [TID 10013](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_TID_10013.html){:target="_blank"} | Irradiation Event | CodeableConcept | [Phantom Devices](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_4052.html){:target="_blank"} |
{:.table-striped .table-bordered}

**Remarks**:
* We highlighted the "Dose (RP) Total" and not the "Entrance Exposure at RP", as the latter one is related to the irradiation event level, and not the procedure level. Even if the PS3.20 is referencing the Entrance Exposure at RP, the IEC 61910-1 is referencing the Dose (RP) Total in the Basic Dose Documentation conformance.
* For NM, most of the minimal dose information related to procedure are described in the irradiation event level of the RRDSR structure. However, as there is only one irradiation event per RRDSR, we considered that this minimal dose information is related to the procedure level. However, this implies that for the same NM imaging procedure, multiple Radiation Dose Summaries can be reported. This should not be a problem, as in this case the radiation dose summary is related to the administration act, more than the procedure act.
* The irradiation Issued Date has different significations, based on the targeted procedure type; in CT, it is the start date of the irradiation act, in XA/RF/MG, it is the Series Date Time, and in NM, it is the administration date time.
* The associated procedure is referenced through the related Imaging Study.
* The calibration factors are not reported as part of the minimal dose information. The generator of the Dose Summary resources shall take in consideration these calibration factors.
* Based on the analyzes performed, there is no minimal dose information related to the level Irradiation Event and part of the modalities XA/RF/MG. 

<a name="underlying-specs"></a>

### Underlying specifications

This IG is based on [HL7 FHIR](http://hl7.org/fhir/R4/index.html){:target="_blank"} standard, as well as [DICOM](https://www.dicomstandard.org/current){:target="_blank"} standard, and its packaged value sets [fhir.dicom](http://fhir.org/packages/fhir.dicom){:target="_blank"}. This IG uses also a profile from the specification [International Patient Summary IG (IPS)](https://hl7.org/fhir/uv/ips/STU1/){:target="_blank"}. Implementers of this specification must understand some basic information about the underlying specifications listed above.

#### FHIR
This IG uses terminology, notations and design principles that are specific to the HL7 FHIR standard. Before reading the page [architecture and implementation](archi.html), it is important to be familiar with the basic principles of FHIR and how to read FHIR specifications. Readers who are unfamiliar with FHIR are encouraged to review the following prior to reading the rest of this implementation guide.

* [FHIR overview](http://hl7.org/fhir/R4/overview.html){:target="_blank"}
* [Developer's introduction](http://hl7.org/fhir/R4/overview-dev.html){:target="_blank"} (or [Clinical introduction](http://hl7.org/fhir/R4/overview-clinical.html){:target="_blank"})
* [FHIR data types](http://hl7.org/fhir/R4/datatypes.html){:target="_blank"}
* [Using codes](http://hl7.org/fhir/R4/terminologies.html){:target="_blank"}
* [References between resources](http://hl7.org/fhir/R4/references.html){:target="_blank"}
* [How to read resource & profile definitions](http://hl7.org/fhir/R4/formats.html){:target="_blank"}
* [Base resource](http://hl7.org/fhir/R4/resource.html){:target="_blank"}

This implementation guide supports the recently published [FHIR R4](http://hl7.org/fhir/R4/index.html){:target="_blank"} version of the FHIR standard to ensure alignment with the current direction of the FHIR standard.

#### FHIR resources used
The table below identifies the specific FHIR Resources and their purposes that will be used in this IG. Implementers should familiarize themselves with these FHIR resources and their purposes.

|FHIR Resource|Purpose|
|-----|-----------------|
|[Observation](http://hl7.org/fhir/R4/observation.html){:target="_blank"}| Used to describe the radiation dose summary and the collected minimal dose information|
|[Patient](http://hl7.org/fhir/R4/patient.html){:target="_blank"}| Used to reference the irradiated person|
|[Practitioner](http://hl7.org/fhir/R4/practitioner.html){:target="_blank"}| Used to reference the related irradiation authorizing person|
|[Device](http://hl7.org/fhir/R4/device.html){:target="_blank"}| Used to describe the irradiating modality|
|[ImagingStudy](http://hl7.org/fhir/R4/imagingstudy.html){:target="_blank"}| Used to reference the performed exam|
|[Composition](http://hl7.org/fhir/R4/composition.html){:target="_blank"}| Used to create the irradiation report|
{:.table-striped .table-bordered}

#### DICOM® Standard
DICOM® is used as reference standard, as it provides a complete definition of the dose information that can be present in a radiation report. The DICOM® version used in this IG is the [2021d](https://dicom.nema.org/medical/dicom/2021d/output/){:target="_blank"} release. The packaged value sets coming from DICOM within [fhir.dicom](http://fhir.org/packages/fhir.dicom){:target="_blank"} are referenced many times in the different profiles of this IG.

[DICOM®](https://www.dicomstandard.org/current){:target="_blank"}

#### International Patient Summary IG (IPS)
Pregnancy Status Profile from [International Patient Summary IG (IPS)](https://hl7.org/fhir/uv/ips/STU1/){:target="_blank"} is used within this IG in order to report a possible pregnancy of an irradiated person.

[International Patient Summary IG (IPS)](https://hl7.org/fhir/uv/ips/STU1/){:target="_blank"}

<a name="glossary"></a>

### Glossary

The following terms and acronyms are used within the Radiation Dose Summary IG:

|Term|Definition|
|-----|-----------------|
|AAPM| American Association of Physicists in Medicine |
|ACR| American College of Radiology |
|ATNA| Audit Trail and Node Authentication |
|CDA| Clinical Document Architecture |
|CDS| Clinical Decision Support |
|CT| Computed Tomography |
|CTDI| Computed Tomography Dose Index |
|DAP| Dose Area Product |
|DICOM| Digital Imaging and Communications in Medicine |
|DLP| Dose Length Product |
|EHR| Electronic Health Record |
|EMR| Electronic Medical Record |
|FHIR| Fast Healthcare Interoperability Resources |
|HAS| French High Authority of Health |
|HL7| Health Level Seven|
|HPS| Health Physics Society |
|IEC| International Electrotechnical Commission |
|IG| Implementation Guide |
|IHE| Integrating the Healthcare Enterprise |
|IOD| Information Object Definition |
|IPS| International Patient Summary |
|MG| Mammography |
|MPPS| Modality Performed Procedure Step |
|NM| Nuclear Medicine |
|OCR| Optical Character Recognition |
|PHI| Personal Health Information |
|RDSC| Radiation Dose Summary Consumer |
|RDSP| Radiation Dose Summary Producer |
|RDSR| Radiation Dose Structured Report |
|REM| Radiation Exposure Monitoring|
|REM-NM| Radiation Exposure Monitoring for Nuclear Medicine |
|REST| Representational State Transfer |
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

1. DICOM, [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html){:target="_blank"}
2. DICOM, [DICOM PS3.16: Content Mapping Resource](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/PS3.16.html){:target="_blank"}
3. DICOM, [X-Ray Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_XRayRadiationDoseSRIODTemplates.html){:target="_blank"}
4. DICOM, [CT Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CTRadiationDoseSRIODTemplates.html){:target="_blank"}
5. DICOM, [Radiopharmaceutical Radiation Dose SR IOD Templates](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_RadiopharmaceuticalRadiationDoseSRIODTemplates.html){:target="_blank"}
6. DICOM, [TID 2008\. Radiation Exposure and Protection Information](http://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_A.html#sect_TID_2008){:target="_blank"}
7. French Society of Radiology - SFR,  [Practical Guide for Interventional Radiology](http://gri.radiologie.fr/){:target="_blank"}  (Guideline - 2013)
8. French High Authority of Health - HAS,  [Patient radiation protection and analysis of CPD practices and certification of healthcare establishments](https://www.has-sante.fr/upload/docs/application/pdf/2013-07/radioprotection_du_patient_et_analyse_des_pratiques_dpc_et_certification_des_etablissements_de_sante_format2clics.pdf){:target="_blank"}  (Guideline - 2012)
9. French nuclear safety authority, [Presentation of the main radiation protection regulatory provisions applicable in medical and dental radiology](https://www.cd2-conseils.com/wp-content/uploads/2016/11/rp_asn_presentation-principales-dispositions-reglementaires_2016.pdf){:target="_blank"}  (Guideline: 2016)
10. French Minister of Health and Solidarity,  [Order of 22 September 2006 relating to the radiation information to be included in an act report using ionizing radiation](https://www.legifrance.gouv.fr/eli/arrete/2006/9/22/SANY0623888A/jo/texte){:target="_blank"}, (Order - 2006)
11. Finnish Imaging Report specification,  [KanTa Imaging CDA R2 document structures](http://www.hl7.fi/hl7-rajapintakartta/kanta-%E2%80%93-kuvantamisen-cda-r2-rakenne/){:target="_blank"}  (2013)
12. Finnish Radiation and Nuclear Safety Authority, [Röntgentutkimuksesta potilaalle aiheutuvan säteilyaltistuksen määrittäminen](https://www.julkari.fi/bitstream/handle/10024/125145/rontgensateily.pdf){:target="_blank"} (X-ray examination of the patient radiation exposure determination)
13. AAPM, [Computed Tomography Dose Limit Reporting Guidelines for Section 3 – 115113](https://aapm.org/government_affairs/documents/SB-1237Section3_v7.pdf){:target="_blank"}
14. [Senate Bill No. 1237, CHAPTER 521](http://www.leginfo.ca.gov/pub/09-10/bill/sen/sb_1201-1250/sb_1237_bill_20100929_chaptered.pdf){:target="_blank"}
15. AAPM, [Experience with California Law on Reporting CT Dose](http://amos3.aapm.org/abstracts/pdf/77-22649-312436-91875.pdf){:target="_blank"}
16. [Radiologist Compliance With California CT Dose Reporting Requirements: A Single-Center Review of Pediatric Chest CT](https://www.ajronline.org/doi/pdf/10.2214/AJR.14.13693){:target="_blank"}
17. University of California Dose Optimization and Standardization Endeavor (UC-DOSE). [Recommendations for compliance with California Senate Bill 1237 and related pending legislation](http://files.ctctcdn.com/da9de144201/b78c37fa-a36b-4888-a418-fa21a314393e.pdf){:target="_blank"}
18. IEC, [IEC 61910-1:2014 - Medical electrical equipment - Radiation dose documentation - Part 1: Radiation dose structured reports for radiography and radioscopy](https://webstore.iec.ch/publication/6091){:target="_blank"}
19. IHE Radiology (RAD), [Technical Framework Volume 1, Cross-enterprise Document Sharing for Imaging (XDS-I.b)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_TF_Vol1.pdf){:target="_blank"}
20. IHE Radiology (RAD), [Technical Framework Volume 1, Radiation Exposure Monitoring (REM)](https://www.ihe.net/uploadedFiles/Documents/Radiology/IHE_RAD_TF_Vol1.pdf){:target="_blank"}
21. HL7 International, [International Patient Summary Implementation Guide (IPS)](https://hl7.org/fhir/uv/ips/STU1/)
22.  AAPM/ACR/HPS, [AAPM/ACR/HPS Joint Statement on Proper Use of Radiation Dose Metric Tracking for Patients Undergoing Medical Imaging Exams](https://www.aapm.org/org/policies/details.asp?id=1533&type=PP){:target="_blank"}