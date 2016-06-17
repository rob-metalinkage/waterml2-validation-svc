<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:saxon="http://saxon.sf.net/" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wml2="http://www.opengis.net/waterml/2.0" xmlns:om="http://www.opengis.net/om/2.0" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xlink="http://www.w3.org/1999/xlink" version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter" tunnel="no"/><xsl:param name="archiveNameParameter" tunnel="no"/><xsl:param name="fileNameParameter" tunnel="no"/><xsl:param name="fileDirParameter" tunnel="no"/><xsl:variable name="document-uri"><xsl:value-of select="document-uri(/)"/></xsl:variable>

<!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--XSD TYPES FOR XSLT2-->
<xsl:import-schema xmlns="http://purl.oclc.org/dsdl/schematron" schema-location="http://schemas.opengis.net/waterml/2.0/waterml2.xsd" namespace="http://www.opengis.net/waterml/2.0"/><xsl:import-schema xmlns="http://purl.oclc.org/dsdl/schematron" schema-location="http://schemas.opengis.net/gml/3.2.1/gml.xsd" namespace="http://www.opengis.net/gml/3.2"/>

<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path"><xsl:apply-templates select="." mode="schematron-get-full-path"/></xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''"><xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>*:</xsl:text><xsl:value-of select="local-name()"/><xsl:text>[namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose><xsl:variable name="preceding" select="count(preceding-sibling::*[local-name()=local-name(current())                                   and namespace-uri() = namespace-uri(current())])"/><xsl:text>[</xsl:text><xsl:value-of select="1+ $preceding"/><xsl:text>]</xsl:text></xsl:template><xsl:template match="@*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>@*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>' and namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose></xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-2-->
<!--This mode can be used to generate prefixed XPath for humans-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-2"><xsl:for-each select="ancestor-or-self::*"><xsl:text>/</xsl:text><xsl:value-of select="name(.)"/><xsl:if test="preceding-sibling::*[name(.)=name(current())]"><xsl:text>[</xsl:text><xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><xsl:text>]</xsl:text></xsl:if></xsl:for-each><xsl:if test="not(self::*)"><xsl:text/>/@<xsl:value-of select="name(.)"/></xsl:if></xsl:template><!--MODE: SCHEMATRON-FULL-PATH-3-->
<!--This mode can be used to generate prefixed XPath for humans 
	(Top-level element has index)-->
<xsl:template match="node() | @*" mode="schematron-get-full-path-3"><xsl:for-each select="ancestor-or-self::*"><xsl:text>/</xsl:text><xsl:value-of select="name(.)"/><xsl:if test="parent::*"><xsl:text>[</xsl:text><xsl:value-of select="count(preceding-sibling::*[name(.)=name(current())])+1"/><xsl:text>]</xsl:text></xsl:if></xsl:for-each><xsl:if test="not(self::*)"><xsl:text/>/@<xsl:value-of select="name(.)"/></xsl:if></xsl:template>

<!--MODE: GENERATE-ID-FROM-PATH -->
<xsl:template match="/" mode="generate-id-from-path"/><xsl:template match="text()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.text-', 1+count(preceding-sibling::text()), '-')"/></xsl:template><xsl:template match="comment()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.comment-', 1+count(preceding-sibling::comment()), '-')"/></xsl:template><xsl:template match="processing-instruction()" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.processing-instruction-', 1+count(preceding-sibling::processing-instruction()), '-')"/></xsl:template><xsl:template match="@*" mode="generate-id-from-path"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:value-of select="concat('.@', name())"/></xsl:template><xsl:template match="*" mode="generate-id-from-path" priority="-0.5"><xsl:apply-templates select="parent::*" mode="generate-id-from-path"/><xsl:text>.</xsl:text><xsl:value-of select="concat('.',name(),'-',1+count(preceding-sibling::*[name()=name(current())]),'-')"/></xsl:template>

<!--MODE: GENERATE-ID-2 -->
<xsl:template match="/" mode="generate-id-2">U</xsl:template><xsl:template match="*" mode="generate-id-2" priority="2"><xsl:text>U</xsl:text><xsl:number level="multiple" count="*"/></xsl:template><xsl:template match="node()" mode="generate-id-2"><xsl:text>U.</xsl:text><xsl:number level="multiple" count="*"/><xsl:text>n</xsl:text><xsl:number count="node()"/></xsl:template><xsl:template match="@*" mode="generate-id-2"><xsl:text>U.</xsl:text><xsl:number level="multiple" count="*"/><xsl:text>_</xsl:text><xsl:value-of select="string-length(local-name(.))"/><xsl:text>_</xsl:text><xsl:value-of select="translate(name(),':','.')"/></xsl:template><!--Strip characters--><xsl:template match="text()" priority="-1"/>

<!--SCHEMA SETUP-->
<xsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="OGC WaterML2.0 timseries validation" schemaVersion=""><xsl:comment><xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/></xsl:comment><svrl:text>Verifies that the Timeseries type follows the requirements specified by 
    http://www.opengis.net/spec/waterml/2.0/req/xsd-timeseries-tvp</svrl:text><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/waterml/2.0" prefix="wml2"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/om/2.0" prefix="om"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/gml/3.2" prefix="gml"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema-instance" prefix="xsi"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">datetime_check</xsl:attribute><xsl:attribute name="name">Tests /req/xsd-xml-rules/iso8601-time and /req/xsd-xml-rules/time-zone</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M9"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">equidistant_series</xsl:attribute><xsl:attribute name="name">Tests /req/xsd-timeseries-tvp/equidistant-encoding 
      and /req/xsd-timeseries-tvp/time-mandatory	</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M10"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">null_values</xsl:attribute><xsl:attribute name="name">Tests /req/xsd-timeseries-tvp/null-point-reason</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M11"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">xlinkTitlesForLocal</xsl:attribute><xsl:attribute name="name">Test recommendation: /req/xsd-xml-rules/xlink-titles-for-core-elements</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M12"/></svrl:schematron-output></xsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">OGC WaterML2.0 timseries validation</svrl:text>

<!--PATTERN datetime_checkTests /req/xsd-xml-rules/iso8601-time and /req/xsd-xml-rules/time-zone-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Tests /req/xsd-xml-rules/iso8601-time and /req/xsd-xml-rules/time-zone</svrl:text>

	<!--RULE -->
<xsl:template match="//wml2:point/wml2:MeasurementTVP/wml2:time" priority="1001" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:point/wml2:MeasurementTVP/wml2:time"/><xsl:variable name="dateInstance" select="text()"/><xsl:variable name="dateTimezoneValid" select="matches($dateInstance, '.*(Z|[+-][0-9][0-9]:[0-9][0-9])')"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="($dateInstance) and ($dateTimezoneValid)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="($dateInstance) and ($dateTimezoneValid)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
        Input value is
        <xsl:text/><xsl:value-of select="$dateInstance"/><xsl:text/>
        Timezone is mandatory according to the following format YYYY-MM-DDTHH:MM:SS(.s+)?(Z|[+-]HH:MM). TZ specifier must exist.
      </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></xsl:template>

	<!--RULE -->
<xsl:template match="//wml2:point/wml2:CategoricalTVP/wml2:time" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:point/wml2:CategoricalTVP/wml2:time"/><xsl:variable name="dateInstance" select="text()"/><xsl:variable name="dateTimezoneValid" select="matches($dateInstance, '.*(Z|[+-][0-9][0-9]:[0-9][0-9])')"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="($dateInstance) and ($dateTimezoneValid)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="($dateInstance) and ($dateTimezoneValid)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
        Input value is
        <xsl:text/><xsl:value-of select="$dateInstance"/><xsl:text/>
        Timezone is mandatory according to the following format YYYY-MM-DDTHH:MM:SS(.s+)?(Z|[+-]HH:MM). TZ specifier must exist.
      </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></xsl:template><xsl:template match="text()" priority="-1" mode="M9"/><xsl:template match="@*|node()" priority="-2" mode="M9"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></xsl:template>

<!--PATTERN equidistant_seriesTests /req/xsd-timeseries-tvp/equidistant-encoding 
      and /req/xsd-timeseries-tvp/time-mandatory	-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Tests /req/xsd-timeseries-tvp/equidistant-encoding 
      and /req/xsd-timeseries-tvp/time-mandatory	</svrl:text>

	<!--RULE -->
<xsl:template match="//wml2:Timeseries/wml2:metadata/wml2:TSMetadata" priority="1001" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:Timeseries/wml2:metadata/wml2:TSMetadata"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="(wml2:spacing and wml2:baseTime) or (not(wml2:spacing) and not(wml2:baseTime))"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(wml2:spacing and wml2:baseTime) or (not(wml2:spacing) and not(wml2:baseTime))"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
        Both spacing and baseTime need to be specifed if equidistant series, otherwise neither should be used. </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/></xsl:template>

	<!--RULE -->
<xsl:template match="//wml2:Timeseries/wml2:point/wml2:TimeValuePair" priority="1000" mode="M10"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:Timeseries/wml2:point/wml2:TimeValuePair"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="(wml2:time and not(../../wml2:metadata/wml2:MeasureTSMetadata/wml2:spacing)         or (not(wml2:time) and (../../wml2:metadata/wml2:MeasureTSMetadata/wml2:spacing)))"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="(wml2:time and not(../../wml2:metadata/wml2:MeasureTSMetadata/wml2:spacing) or (not(wml2:time) and (../../wml2:metadata/wml2:MeasureTSMetadata/wml2:spacing)))"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
        The time for each point in the series must be specified if equidistant spacing isn't being used (i.e. you must
        specify the baseTime and spacing elements). If baseTime and spacing are specified then time is not required. 
      </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/></xsl:template><xsl:template match="text()" priority="-1" mode="M10"/><xsl:template match="@*|node()" priority="-2" mode="M10"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M10"/></xsl:template>

<!--PATTERN null_valuesTests /req/xsd-timeseries-tvp/null-point-reason-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Tests /req/xsd-timeseries-tvp/null-point-reason</svrl:text>

	<!--RULE -->
<xsl:template match="//wml2:Timeseries/wml2:point/wml2:TimeValuePair/wml2:value[@xsi:nil]" priority="1000" mode="M11"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:Timeseries/wml2:point/wml2:TimeValuePair/wml2:value[@xsi:nil]"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="../wml2:metadata/wml2:TVPMeasureMetadata/wml2:nilReason or ../wml2:metadata/wml2:TVPMeasureMetadata/wml2:censoredReason"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="../wml2:metadata/wml2:TVPMeasureMetadata/wml2:nilReason or ../wml2:metadata/wml2:TVPMeasureMetadata/wml2:censoredReason"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>
        All null points must provide a nilReason or a censoredReason. </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/></xsl:template><xsl:template match="text()" priority="-1" mode="M11"/><xsl:template match="@*|node()" priority="-2" mode="M11"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M11"/></xsl:template>

<!--PATTERN xlinkTitlesForLocalTest recommendation: /req/xsd-xml-rules/xlink-titles-for-core-elements-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Test recommendation: /req/xsd-xml-rules/xlink-titles-for-core-elements</svrl:text>

	<!--RULE -->
<xsl:template match="*[@xlink:href]" priority="1000" mode="M12"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*[@xlink:href]"/>

		<!--REPORT -->
<xsl:if test="not(starts-with(@xlink:href, '#') ) and not(@xlink:title)         and (local-name()='observedProperty' or local-name()='featureOfInterest'  )"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(starts-with(@xlink:href, '#') ) and not(@xlink:title) and (local-name()='observedProperty' or local-name()='featureOfInterest' )"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>xlink:title are required for 
        observedProperty and featureOfInterest </svrl:text></svrl:successful-report></xsl:if><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/></xsl:template><xsl:template match="text()" priority="-1" mode="M12"/><xsl:template match="@*|node()" priority="-2" mode="M12"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M12"/></xsl:template></xsl:stylesheet>