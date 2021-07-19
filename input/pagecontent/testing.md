This chapter describes testing data and testing plan, and provide some samples for developers.

1. [Test Plan](#testplan) - Test plans for different actors 
2. [Test Data](#testdata) - Test data that can be used
3. [Resources Samples](#samples) - Samples of resources profiled following this IG
4. [Download](#download) - Resources available for download

<a name="testplan"></a>

### Test Plan
#### Scenario 1: RDSR summary to FHIR
##### Actors

* Radiation Dose Summary Producer (RDSP) actor
* FHIR server
* Radiation Dose Summary Consumer (RDSC) actor

##### Roles

| Actors | Roles |
|--------------------------|-----------------------|
| Radiation Dose Summary Producer (RDSP) actor| Produce the Radiation Dose Summary resource <br/> (O) Produce occasionally contextual resources  (Patient, Device, ImagingStudy, etc) |
| FHIR server | Host and Manage the Radiation Dose Summary resource <br/> Manage the contextual resources (Patient, Device, ImagingStudy, etc)|
|Radiation Dose Summary Consumer (RDSC) actor | Consume Radiation Dose Summary resource <br/> (O) Produce Radiation Summary Report |
{:.table-striped .table-bordered}

##### Steps

Here are the different steps that needs to be performed: 
![Actors relationship](./seq.svg){: width="900px"}

<br clear="all" />
* The RDSP actor gathers an RDSR from an irradiating modality (a CT RDSR, an X-Ray RDSR or an RRDSR)
* The RDSP actor collects the identifiers of the Patient, the Device, the Practitioner, and the ImagingStudy from the FHIR Server
    * If some of the resources are not found, the RDSP actor constructs them in order to share them with the FHIR Server
* The RDSP actor constructs the Radiation Dose Summary resource and POST it to the FHIR server
* The RDSC actor queries the FHIR server and collects radiation summary information
* Optionally, the RDSC actor enhances the FHIR server with the Radiation Summary Report.

##### Validation

* The generated Radiation Summary resources shall pass the validation tool testing, using the FHIR [validator](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar){:target="_blank"}
* The sharing of the Radiation Dose Summary resources from the RDSP actor to the FHIR server can be validated through the test script [TestScript_RDS_Sharing_Verification](TestScript-RDS-sharing-verification.html)
* The accessibility of the FHIR server through searching capabilities can be validated with the test script [TestScript_RDSC_Simulator](TestScript-RDSC_Simulator.html)
* The capacity of the FHIR server to accept transactions with the Bundle of resources of Radiation Dose Summary can be tested with the test script [TestScript_RDSP_Simulator](TestScript-RDSP_Simulator.html)

#### Scenario 2: Grouping RDSP and FHIR Server
##### Actors
* Radiation Dose Summary Producer (RDSP) actor <i>grouped with</i> FHIR server
* Radiation Dose Summary Consumer (RDSC) actor

##### Roles

| Actors | Roles |
|--------------------------|-----------------------|
| Radiation Dose Summary Producer (RDSP) actor grouped with FHIR server | Produce internally the Radiation Dose Summary resource <br/> Host and Manage the Radiation Dose Summary resource <br/> Manage the contextual resources (Patient, Device, ImagingStudy, etc) |
|Radiation Dose Summary Consumer (RDSC) actor | Consume Radiation Dose Summary resource |
{:.table-striped .table-bordered}

##### Steps

Here are the different steps that needs to be performed: 
![Actors relationship Scenario 2](./seq2.svg){: width="900px"}

<br clear="all" />
* The (RDSP actor, FHIR server) gathers an RDSR from an irradiating modality (a CT RDSR, an X-Ray RDSR or an RRDSR)
* The (RDSP actor, FHIR server) constructs and exposes the resources related to the Patient, ImagingStudy, Practitioner, Device and Radiation Dose Summary resources.
* The RDSC actor queries the (RDSP actor, FHIR server) and collects radiation summary information

##### Validation

* The generated Radiation Summary resources shall pass the validation tool testing, using the FHIR [validator](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar){:target="_blank"}
* The accessibility of the FHIR server through searching capabilities can be validated with the test script [TestScript_RDSC_Simulator](TestScript-RDSC_Simulator.html)


<a name="testdata"></a>

### Test Data
Some RDSRs and RRDSRs can be downloaded from IHE google drive, and can be used in the generation of the Radiation Dose Summary resources. Here are the links to these DICOM objects:
* [REM samples (CT RDSRs and X-Ray RDSRs)](https://drive.google.com/drive/u/0/folders/1M3OLxdHU25q8vNKQSr-O3Aip__YOYly0){:target="_blank"}
* [REM-NM samples (RRDSRs)](https://drive.google.com/drive/u/0/folders/1fE1BGXQDhqjzTbESt38qtiJ1Q7Js6Gg3){:target="_blank"}

Also, examples of RDSRs and RRDSRs can be accessed through the IHE Connectathon Samples sharing.

<a name="samples"></a>

### Resources samples
#### Radiation Dose Summary Consumer search query samples

Here are some examples of queries and searching use cases that can be performed by the RDSC actor:

| Query Description | Query URL |
|-------------------|--------------------------------------------------------------|
| Search all the Dose summaries within the FHIR Server | GET /fhir/Observation?code=73569-6 |
| View specific Dose Summary | GET /fhir/Observation/19 |
| Access Device dose summaries | GET /fhir/Observation?code=73569-6&device=22  |
| Search Dose Summary of a patient through the last year | GET /fhir/Observation?code=73569-6&patient=8&date=gt2020-01-01 |
| Search Dose Summary related to the study | GET /fhir/Observation?code=73569-6&part-of=1232 |
{:.table-striped .table-bordered}


#### Radiation Dose Summary Profile samples
##### CT sample
Here is an example of the Radiation Dose Summary Profile resource related to CT exam, and its dependencies:

![Example 1](./example1.svg){: width="100%"}

<br clear="all" />

* [CTRadiationDoseSummary-139](Observation-139.html)
* [CTIrradiationEventSummary-839](Observation-839.html)
* [CTIrradiationEventSummary-393](Observation-393.html)
* [ImagingStudy-342](ImagingStudy-342.html)
* [Patient-56](Patient-56.html)
* [Practitioner-33](Practitioner-33.html)
* [ModalityDevice-539](Device-539.html)

A sample of Dose Summary Report profile exists with relationship to Indications profile and Pregnancy Status:
* [RadiationSummaryReport-1](Composition-1.html)
* [Indications-1](Observation-34.html)
* [PregnancyStatus-1](Observation-33.html)

##### X-Ray sample
Here is an example of the Radiation Dose Summary Profile resource related to XA exam, and its dependencies:

![Example 2](./example2.svg)

<br clear="all" />

* [XRayRadiationDoseSummary-545](Observation-545.html)
* [ImagingStudy-344](ImagingStudy-344.html)
* [Patient-56](Patient-56.html)
* [Practitioner-33](Practitioner-33.html)
* [ModalityDevice-12](Device-12.html)

##### NM sample
Here is an example of the Radiation Dose Summary Profile resource related to Radiopharmaceutical administration, and its dependencies:

![Example 3](./example3.svg)
<br clear="all" />

* [NMRadiationDoseSummary-122](Observation-122.html)
* [ImagingStudy-22](ImagingStudy-22.html)
* [Patient-56](Patient-56.html)
* [Practitioner-33](Practitioner-33.html)


<a name="download"></a>

### Download

This implementation guide is web-based and is intended to be browsed online. However, for the convenience of implementers, both this implementation guide, various sub-packages of it and some of the source specifications are available for download. The following links allow you to download various parts of this implementation guide and other referenced implementation guides for local use.

*   This [full IG](full-ig.zip)
*   The [resource definitions](definitions.json.zip) from this IG for use with the FHIR validator (see below)
*   The full FHIR [R4](http://hl7.org/fhir/R4/fhir-spec.zip){:target="_blank"} specifications
*   A [validator](https://github.com/hapifhir/org.hl7.fhir.core/releases/latest/download/validator_cli.jar){:target="_blank"} that can be used to check FHIR resource instance validity.


