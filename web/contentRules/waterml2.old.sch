<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron">
    <sch:title/>
    <sch:ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="wml2" uri="http://www.wron.net.au/waterml2"/>
    <sch:ns prefix="xsd" uri="http://www.w3.org/2001/XMLSchema"/>
    <sch:ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="om" uri="http://www.opengis.net/om/2.0"/>
    <sch:ns prefix="wml2" uri="http://www.wron.net.au/waterml2"/>
    <sch:ns prefix="sams" uri="http://www.opengis.net/samplingSpatial/2.0"/>
    <sch:ns prefix="sch" uri="http://purl.oclc.org/dsdl/schematron"/>
    <sch:ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
    <sch:ns prefix="wml2" uri="http://www.wron.net.au/waterml2"/>
    <sch:phase id="watermlPatterns">
        <sch:active pattern="PropertiesforStringNamedValue"/>
        <sch:active pattern="PropertiesforWaterMonitoringObservation"/>
        <sch:active pattern="PropertiesforWaterObservationPoint"/>
    </sch:phase>
    <sch:pattern id="PropertiesforStringNamedValue">
        <sch:rule context="//wml2:StringNamedValue">
            <sch:assert flag="error" test="wml2:value or (empty(wml2:value/*) and wml2:value/@xlink:href)">value must contain either  or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="PropertiesforWaterMonitoringObservation">
        <sch:rule context="//wml2:WaterMonitoringObservation">
            <sch:assert flag="error" test="om:metadata/wml2:ObservationMetadata or (empty(om:metadata/*) and om:metadata/@xlink:href)">metadata must contain either ObservationMetadata or nothing (and carry an xlink:href instead)</sch:assert>
            <sch:assert flag="error" test="om:procedure/wml2:WaterObservationProcess or (empty(om:procedure/*) and om:procedure/@xlink:href)">procedure must contain either WaterObservationProcess or nothing (and carry an xlink:href instead)</sch:assert>
            <sch:assert flag="error" test="om:result/wml2:Timeseries or (empty(om:result/*) and om:result/@xlink:href)">result must contain either Timeseries or nothing (and carry an xlink:href instead)</sch:assert>
            <sch:assert flag="error" test="om:featureOfInterest/sams:SF_SpatialSamplingFeature or (empty(om:featureOfInterest/*) and om:featureOfInterest/@xlink:href)">featureOfInterest must contain either SF_SpatialSamplingFeature or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="PropertiesforWaterObservationPoint">
        <sch:rule context="//wml2:WaterObservationPoint">
            <sch:assert flag="error" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)">relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
        <sch:rule context="//wml2:WaterObservationSection">
            <sch:assert flag="error" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)">relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
        <sch:rule context="//wml2:WaterObservationTransect">
            <sch:assert flag="error" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)">relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
        <sch:rule context="//wml2:WaterObservationVolume">
            <sch:assert flag="error" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)">relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>