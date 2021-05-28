### Scenario: RDSR summary to FHIR
#### Actors

*   Radiation Dose Summary Producer (RDSP) actor
*   FHIR server
*   Radiation Dose Summary Consumer (RDSC) actor

#### Roles

| Actors | Roles |
|--------------------------|-----------------------|
| Radiation Dose Summary Producer (RDSP) actor| Produce the Radiation Dose Summary resource <br/> (O) Produce occasionally contextual resources  (Patient, Device, ImagingStudy, etc) |
| FHIR server | Host and Manage the Radiation Dose Summary resource <br/> Manage the contextual resources (Patient, Device, ImagingStudy, etc)|
|Radiation Dose Summary Consumer (RDSC) actor | Consume Radiation Dose Summary resource <br/> (O) Produce Radiation Summary Report |
{:.table-striped .table-bordered}

#### Steps

* The RDSP actor gather an RDSR from an irradiating modality (a CT RDSR, an X-Ray RDSR or an RRDSR)
* The RDSP actor collect the identifiers of the Patient, the Device, the Practitioner, and the ImagingStudy from the FHIR Server
    * If some of the resources are not found, the RDSP actor construct them in order to share them with the FHIR Server
* The RDSP construct the Radiation Dose Summary resource and POST it with the FHIR server
* The RDSC actor query the the FHIR server and collect radiation summary information
* Optionally, the RDSC actor enhance the FHIR server with the Radiation Summary Report.

### Validation

* The generated Radiation Summary resources shall pass the validation tools execution, using the FHIR [validator](https://fhir.github.io/latest-ig-validator/org.hl7.fhir.validator.jar)