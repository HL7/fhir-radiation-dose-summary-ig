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