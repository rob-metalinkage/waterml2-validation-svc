<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/samplingSpatial/2.0/samplingSurface.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <!--
        This Schematron schema checks that the type of the spatial sampling feature shape is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Sampling Curve validation</title>
    <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
    <ns prefix="sams" uri="http://www.opengis.net/samplingSpatial/2.0"/>
    <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>

    <xsl:import-schema schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd"/>

    <pattern id="SurfaceTest">
        <rule context="//sams:SF_SpatialSamplingFeature/sams:shape">
            <assert test="schema-element(gml:AbstractSurface) | @xlink:href">a member of the
                substitution group headed by gml:AbstractSurface or an xlink must be present as
                child of sams:shape</assert>
        </rule>
    </pattern>

</schema>
