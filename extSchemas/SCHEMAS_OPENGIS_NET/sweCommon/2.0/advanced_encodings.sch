<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:title>Additional validation rules for XML instances including advanced encodings</sch:title>
    <sch:ns uri="http://www.opengis.net/swe/2.0" prefix="swe"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:pattern>
        <sch:title>Req 71 for binary encoding</sch:title>
        <sch:rule context="//*[swe:encoding/swe:BinaryEncoding/@byteEncoding='base64']/swe:values">
            <sch:assert test="matches(normalize-space(.), '^([A-Za-z0-9+/=]{4})+$')">
                When base64 binary encoding is specified, values shall be base64 encoded (Req 71)
            </sch:assert>
        </sch:rule>
        <sch:rule context="//*[swe:encoding/swe:BinaryEncoding/@byteEncoding='raw']/swe:values">
            <sch:assert test="@xlink:href">
                When raw binary encoding is specified, encoded data block shall be out of band and referenced by xlink:href (Req 71)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>