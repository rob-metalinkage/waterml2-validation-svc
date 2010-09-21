<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
    <sch:title>Additional validation rules for XML instances including simple data components</sch:title>
    <sch:ns uri="http://www.opengis.net/swe/2.0" prefix="swe"/>
    <sch:ns uri="http://www.w3.org/1999/xlink" prefix="xlink"/>
    <sch:pattern>
        <sch:title>Req 19</sch:title>
        <sch:rule context="//swe:Quantity | //swe:Count | //swe:Time | //swe:Boolean | //swe:Category | //swe:Text">
            <sch:assert test="@definition">
                The 'definition' attribute is mandatory on all simple data components (Req 19)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 19</sch:title>
        <sch:rule context="//swe:QuantityRange | //swe:CountRange | //swe:TimeRange | //swe:CategoryRange">
            <sch:assert test="@definition">
                The 'definition' attribute is mandatory on all range data components (Req 19)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 27</sch:title>
        <sch:rule context="//swe:Category">
            <sch:assert test="swe:codeSpace | swe:constraint">
                A 'Category' component must have either a code space or an enumeration constraint (Req 27)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern id="P03">
        <sch:title>Req 29 and 31</sch:title>
        <sch:rule context="//swe:Time">
            <sch:assert test="@referenceFrame">
                The 'referenceFrame' attribute is mandatory on all 'Time' components (Req 29)
            </sch:assert>
            <sch:report test="@referenceFrame = @localFrame">
                The 'referenceFrame' and 'localFrame' attributes shall have different values (Req 31)
            </sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 56</sch:title>
        <sch:rule context="//*">
            <sch:assert test="@xlink:href | * | @* or (normalize-space(.) != '')">
                A property element shall have children or an xlink:href (Req 56)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 63</sch:title>
        <sch:rule context="//swe:uom">
            <sch:assert test="@code | @xlink:href">
                Either a UCUM code or a URI pointing to a non UCUM unit shall be specified (Req 63)
            </sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <sch:title>Req 65</sch:title>
        <sch:rule context="//swe:Time[matches(swe:value, '[:-T]')]">
            <sch:assert test="swe:uom/@xlink:href = 'urn:ogc:def:unit:ISO:8601'">
                ISO8601 shall be specified as the uom when the time value is ISO8601 encoded
            </sch:assert>
        </sch:rule>
    </sch:pattern>
</sch:schema>