<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:title>Additional validation rules for XML instances including simple encodings</sch:title>
    <sch:ns uri="http://www.opengis.net/swe/2.0" prefix="swe"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:pattern>
        <sch:title>Req 71 for XML encoding</sch:title>
        <sch:rule context="//*[swe:encoding/swe:XMLEncoding]/swe:values">
            <sch:assert test="@xlink:href | *">
                When XML encoding is specified, values shall contain XML elements (Req 71)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>