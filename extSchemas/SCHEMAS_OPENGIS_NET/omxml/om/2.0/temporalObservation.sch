<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/om/2.0/temporalObservation.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Temporal observation validation</title>
    <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>

    <xsl:import-schema schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>

    <pattern id="TemporalTest">
        <rule context="//om:OM_Observation/om:result">
            <assert test="schema-element(gml:AbstractTimeObject)">result must contain an element in
                the substitution group headed by gml:AbstractTimeObject</assert>
        </rule>
    </pattern>

</schema>
