<?xml version="1.0" encoding="UTF-8"?>
<schema fpi="http://schemas.opengis.net/waterml/2.0/waterObservation.sch" see="http://www.opengeospatial.org/projects/groups/waterml2.0swg"
  xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--
        This schematron schema checks the XML encoding requirements of WaterML2.0, as specified
        in the requirements class: http://www.opengis.net/spec/waterml/2.0/req/xsd-encoding-rules
        
        WaterML 2.0 - XML
        Implementation is an OGC Standard Copyright (c) [2011] Open Geospatial Consortium, Inc.
        All Rights Reserved. To obtain additional rights of use, visit
        http://www.opengeospatial.org/legal/. 
    -->

  <title>WaterML2.0 XML encoding tests</title>
  <p>This schematron schema checks the XML encoding requirements of WaterML2.0, as specified
    in the requirements class: http://www.opengis.net/spec/waterml/2.0/req/xsd-encoding-rules</p>
  <ns prefix="wml2" uri="http://www.opengis.net/waterml/2.0"/>
  <ns prefix="om" uri="http://www.opengis.net/om/2.0"/>
  <ns prefix="gml" uri="http://www.opengis.net/gml/3.2"/>
  <ns prefix="xlink" uri="http://www.w3.org/1999/xlink"/>
  
  <pattern id="result">
    <title>Test requirement: /req/xsd-encoding-rules/xlink-title</title>
    <rule context="*[@xlink:href]">
      <assert test="@xlink:title">All xlink hrefs must contain a xlink:title providing readable context for the reference.</assert>
    </rule>
  </pattern>
  
</schema>
