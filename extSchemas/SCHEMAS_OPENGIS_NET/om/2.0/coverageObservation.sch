<?xml version="1.0" encoding="UTF-8"?>
<schema
    fpi="http://schemas.opengis.net/om/2.0/coverageObservation.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0"
    xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Coverage observation validation</title>
    <p>Verifies that all instances of OM_Observation have a result that matches the pattern for DiscreteCoverageObservations</p>
    <ns
        prefix="gml"
        uri="http://www.opengis.net/gml/3.2"/>
    <ns
        prefix="cv"
        uri="http://www.opengis.net/cv/0.2/gml32"/>
    <ns
        prefix="om"
        uri="http://www.opengis.net/om/2.0"/>
    <ns
        prefix="xsi"
        uri="http://www.w3.org/2001/XMLSchema-instance"/>
    <ns
        prefix="xlink"
        uri="http://www.w3.org/1999/xlink"/>

    <xsl:import-schema
        schema-location="http://bp.schemas.opengis.net/06-188r2/cv/0.2.2_gml32/cv.xsd"/>
    <xsl:import-schema
        schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>

    <pattern
        id="observation-type-coverage">
        <rule
            context="//om:OM_Observation">
            <include href="./result-coverage.sch"/>
        </rule>
    </pattern>

</schema>
