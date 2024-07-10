Radiation Dose Summary profile defines an overview of an irradiation act, which can be a irradiating imaging study or a radiopharmaceutical administration. When the Radiation Dose Summary is related to a study, it provides a summary of the irradiation events that occurred within the same procedure and equipment.
The Radiation Dose Summary profile has no aim to aggregate radiation exposure over time, or make cumulative calculations over multiple performed procedures.
Here is an example of querying a FHIR server hosting Radiation Dose Summary resources: 

```GET /fhir/Observation?code=73569-6&patient=8&date=gt2020-01-01```

For other examples, please refer to the section [Radiation Dose Summary Consumer search query samples](testing.html#radiation-dose-summary-consumer-search-query-samples) paragraph, from [Test and Conformance](testing.html) page. 

Radiation Dose Summary resource can be mapped to the defined CDA section [Radiation Exposure and Protection Information](https://dicom.nema.org/medical/dicom/current/output/html/part20.html#sect_9.3.1){:target="_blank"} from [DICOM PS3.20: Imaging Reports using HL7 Clinical Document Architecture](http://dicom.nema.org/medical/dicom/current/output/html/part20.html){:target="_blank"}. 
