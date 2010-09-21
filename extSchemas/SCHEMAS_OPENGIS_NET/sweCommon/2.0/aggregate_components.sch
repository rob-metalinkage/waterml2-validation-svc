<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:title>Additional validation rules for XML instances including aggregate data components</sch:title>
    <sch:ns uri="http://www.opengis.net/swe/2.0" prefix="swe"/>
    <sch:pattern>
        <sch:title>Req 42</sch:title>
        <sch:rule context="//swe:DataRecord/swe:field">
            <sch:assert test="not(@name = preceding-sibling::swe:field/@name)">
                Field names shall be unique within a 'DataRecord' component (Req 42)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 42</sch:title>
        <sch:rule context="//swe:Vector/swe:coordinate">
            <sch:assert test="not(@name = preceding-sibling::swe:coordinate/@name)">
                Coordinate names shall be unique within a 'Vector' component (Req 42)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 43</sch:title>
        <sch:rule context="//swe:DataChoice/swe:item">
            <sch:assert test="not(@name = preceding-sibling::swe:item/@name)">
                Item names shall be unique within the 'DataChoice' component (Req 43)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 44, 45, 46</sch:title>
        <sch:rule context="//swe:Vector">
            <sch:report test="swe:coordinate/*/@referenceFrame">
                The 'referenceFrame' attribute is forbidden on vector coordinates (Req 44)
            </sch:report>
            <sch:assert test="swe:coordinate/*/@axisID">
                The 'axisID' attribute is mandatory on vector coordinates (Req 45)
            </sch:assert>
            <sch:report test="@referenceFrame = @localFrame">
                The 'referenceFrame' and 'localFrame' attributes shall have different values (Req 46)
            </sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>