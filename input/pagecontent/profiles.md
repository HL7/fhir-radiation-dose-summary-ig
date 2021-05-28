### Resource Profiles<a name="resources"></a>
* [Radiation Dose Summary](StructureDefinition-radiation-dose-summary.html) profiles the Observation resource to provide the base for the Radiation Dose Summary reporting.
    * [CT Radiation Dose Summary](StructureDefinition-ct-radiation-dose-summary.html) profiles the Observation resource by extending the Radiation Dose Summary profile with minimal dose information related to CT procedures.
    * [X-Ray Radiation Dose Summary](StructureDefinition-xray-radiation-dose-summary.html) profiles the Observation resource by extending the Radiation Dose Summary profile with minimal dose information related to X-Ray procedures (XA, RF, MG, etc.)
    * [Radiopharmaceutical Radiation Dose Summary](StructureDefinition-nm-radiation-dose-summary.html) profiles the Observation resource by extending the Radiation Dose Summary profile with minimal dose information related to nuclear medecine imaging procedures.
* [Irradiation Event Summary](StructureDefinition-irradiation-event-summary.html) profiles the Observation resource in order to describe minimal dose information related to irradiation events.
    * [CT Irradiation Event Summary](StructureDefinition-ct-irradiation-event-summary.html) profiles the Observation resource by extending Irradiation Event Summary profile, and adding minimal dose information related to CT Irradiation Events.
* [Radiation Summary Report](StructureDefinition-radiation-summary-report.html) profiles Composition resource and defines a report document describing the irradiation act.
* [Indication Observation](StructureDefinition-indication-observation.html) profiles Observation resource to provide the indications related to the performed procedure
* [Pregnancy Status](StructureDefinition-pregnancy-status.html) profiles Observation resource to provide the pregnancy status of the patient
* [Modality Device](StructureDefinition-modality-device.html) profiles Device resource to provide the specificities of a modality as a Device resource.

### Supporting DataType Profiles <a name="datatypes"></a>
There is no special supporting DataType Profiles defined by this IG.

### Supporting Extensions<a name="extensions"></a>
There is no special supporting extensions defined by this IG.
