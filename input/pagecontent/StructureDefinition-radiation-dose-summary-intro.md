Radiation Dose Summary profile defines an overview of an irradiation act, which can be a 
irradiating procedure, or a radiopharmaceutical administration. When the Radiation Dose Summary is related to an irradiating procedure, it describes a summary of the different irradiation events occured within the same procedure and equipment.
The Radiation Dose Summary profile has no aim to aggregate radiation exposure over time, or making cumulative calculation over multiple performed procedures. However, querying a FHIR server hosting Radiation Dose Summary resources, by searching these 
resources over a period of time, and in relationship with a specific patient, can provide a summary overview of the 
patient irradiation exposure over a period of time.
Here is an example to make such queries : 

```GET /fhir/Observation?code=73569-6&patient=8&date=gt2020-01-01```

To find other searching examples, please refer to the section [Radiation Dose Summary Consumer search query samples](testing.html#radiation-dose-summary-consumer-search-query-samples) paragraph, from [Test and Conformance](testing.html) page. 

Radiation Dose Summary resource can be mapped to the defined CDA section [Radiation Exposure and Protection Information](https://dicom.nema.org/medical/dicom/current/output/html/part20.html#sect_9.3.1){:target="_blank"} from [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html){:target="_blank"}. 

The Radiation Dose Summary profile is an abstract profile, and is extended in this IG by the following profiles: 
[CT Radiation Dose Summary](StructureDefinition-ct-radiation-dose-summary.html),
[X-Ray Radiation Dose Summary](StructureDefinition-xray-radiation-dose-summary.html), and 
[Radiopharmaceutical Radiation Dose Summary](StructureDefinition-nm-radiation-dose-summary.html).