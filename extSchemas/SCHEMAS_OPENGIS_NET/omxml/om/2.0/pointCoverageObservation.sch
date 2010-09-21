<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/om/2.0/pointCoverageObservation.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Point coverage observation validation</title>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <ns prefix="cv" uri="http://www.opengis.net/cv/0.2/gml32"/>
    <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>

    <xsl:import-schema
        schema-location="http://bp.schemas.opengis.net/06-188r2/cv/0.2.2_gml32/cv.xsd"/>
    <xsl:import-schema schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>

    <pattern id="PointCoverageTest">
        <rule context="//om:OM_Observation/om:result">
            <assert
                test="schema-element(gml:MultiPointCoverage) | schema-element(cv:CV_DiscretePointCoverage)"
                >result must contain an element in the substitution group headed by
                gml:MultiPointCoverage or cv:CV_DiscretePointCoverage</assert>
        </rule>
    </pattern>

</schema>
