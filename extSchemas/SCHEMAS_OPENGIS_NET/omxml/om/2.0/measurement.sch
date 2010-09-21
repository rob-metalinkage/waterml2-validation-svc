<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/om/2.0/measurement.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Measurement validation</title>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>

    <xsl:import-schema schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>

    <pattern id="MeasureTest">
        <rule context="//om:OM_Observation/om:result">
            <assert
                test="(@uom castable as gml:UomSymbol or @uom castable as gml:UomURI) and . castable as xs:double"
                >result type must be gml:MeasureType</assert>
        </rule>
    </pattern>

</schema>
