<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/om/2.0/categoryObservation.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Complex observation validation</title>
    <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>
    <ns prefix="swe" uri="http://www.opengis.net/swe/2.0"/>

    <xsl:import-schema schema-location="http://schemas.opengis.net/sweCommon/2.0.0/swe.xsd"/>

    <pattern id="RecordTest">
        <rule context="//om:OM_Observation/om:result">
            <assert test="schema-element(swe:DataRecord)">result must contain an element in the
                substitution group headed by swe:DataRecord</assert>
        </rule>
    </pattern>

</schema>
