<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/om/2.0/categoryObservation.sch"
    see="http://www.opengis.net/doc/IP/OMXML/2.0" xmlns="http://purl.oclc.org/dsdl/schematron"
    queryBinding="xslt2">

    <!--
        This Schematron schema checks that the type of the observation result is correct. 
        
        Observations and Measurements - XML
        Implementation is an OGC Standard Copyright (c) [2010] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

    <title>Category observation validation</title>
    <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>

    <pattern id="CategoryTest">
        <rule context="//om:OM_Observation/om:result">
            <assert test="@codeSpace castable as xs:anyURI and . castable as xs:string">result type
                must be gml:CodeWithAuthorityType</assert>
        </rule>
    </pattern>

</schema>
