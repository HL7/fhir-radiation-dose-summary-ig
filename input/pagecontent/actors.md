A list of actors are identified within this IG:
* Radiation Dose Summary Producer
* FHIR Server
* Radiation Dose Summary Consumer

![Actors](./actors.png){: width="900px"}

<br clear="all" />

### Radiation Dose Summary Producer
The radiation dose summary producer (RDSP) actor is responsible on the creation of the Radiation Dose Summary observation, and sharing it with the FHIR Server. The RDSP actor shall consider synchronizing with the FHIR server multiple resources, in order to avoid dupplicating resources in the FHIR server. For example, the RDSP actor shall check if the patient already exists in the FHIR server, and if so, only a reference to this patient is created, and the POST bundle from the RDSP actor to the FHIR server shall not contain a Patient resource.
Generally, this actor can be implemented within a Dose Management System.

### FHIR Server
The FHIR Server has two functions:
1. Provide the diagnostic procedure context to both the Radiation Dose Summary Producer and Consumer actors
2. Store the Radiation Dose Summary resources and Irradiation Event resources from the sharings performed from the Producer actor
Thus, the FHIR server can be devided in fact in two actors: one for the contextual resources, and one for the Radiation Dose resources.

The contextual resources are resources managed by the FHIR server and related to the imaging procedure, and works as a source of truth for these resources:
1. The Patient resources: the patients having exams.
2. The Device and DeviceDefinition resources: the modalities participating in the irradiation of the patients.
3. The Practitioner resources: the irradiating authorizing persons responsible on the exams performed on the patients.
4. The ImagingStudy resources: resources describing the performed exams.

When these resources are not present in the FHIR server, the radiation dose summary producer can take the responsibility on alimenting the FHIR server with these resources, by creating them from the RDSRs and images collected from modalities.

### Radiation Dose Summary Consumer
The radiation dose summary consumer (RDSC) actor is responsible on the interpretation of the Radiation Dose Summary observation. There are many ways to use the Radiation Dose Summary resources, and it depends on the consumer.
* Some RIS systems can act as consumer actor, in order to enhance the final radiology report with radiation information. 
* Some Clinical Decision Support consumer tools can use these radiation resources to feed their algorithms
* Some Clinical Quality Information consumer tools can use these radiation resources to perform analyzes on radiations information, and provide metrics related to patients cohorts, or devices comparison, or limit values calculations, etc.
* Some consumers may act as a light Dose registry, by collecting the radiation summary information for a patient or a group of patients in a regional or national infrastructure. Such registries can create valuable data for regulations purpose, or for population radiation estimations.

### Actors grouping
The FHIR Server can be grouped with the Radiation Dose Summary Producer actor within the Dose Management System. Thus, the Dose Management System is managing all the resources and references between resources. Another possible grouping is between the FHIR Server and the Radiation Dose Summary Consumer actor. This can happen for example within EMR systems or RIS and EHR systems. In this case, the source of truth for contextual resources are independant from the Dose Management System.

