<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:sch="http://purl.oclc.org/dsdl/schematron" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:wml2="http://www.wron.net.au/waterml2" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:om="http://www.opengis.net/om/2.0" xmlns:sams="http://www.opengis.net/samplingSpatial/2.0" version="1.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter" tunnel="yes"/><xsl:param name="archiveNameParameter" tunnel="yes"/><xsl:param name="fileNameParameter" tunnel="yes"/><xsl:param name="fileDirParameter" tunnel="yes"/><xsl:variable name="document-uri"><xsl:value-of select="document-uri(/)"/></xsl:variable>

<!--PHASES-->


<!--PROLOG-->
<xsl:output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" method="xml" omit-xml-declaration="no" standalone="yes" indent="yes"/>

<!--XSD TYPES FOR XSLT2-->


<!--KEYS AND FUNCTIONS-->


<!--DEFAULT RULES-->


<!--MODE: SCHEMATRON-SELECT-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-select-full-path"><xsl:apply-templates select="." mode="schematron-get-full-path"/></xsl:template>

<!--MODE: SCHEMATRON-FULL-PATH-->
<!--This mode can be used to generate an ugly though full XPath for locators-->
<xsl:template match="*" mode="schematron-get-full-path"><xsl:apply-templates select="parent::*" mode="schematron-get-full-path"/><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''"><xsl:value-of select="name()"/><xsl:variable name="p_1" select="1+    count(preceding-sibling::*[name()=name(current())])"/><xsl:if test="$p_1&gt;1 or following-sibling::*[name()=name(current())]">[<xsl:value-of select="$p_1"/>]</xsl:if></xsl:when><xsl:otherwise><xsl:text>*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>']</xsl:text><xsl:variable name="p_2" select="1+   count(preceding-sibling::*[local-name()=local-name(current())])"/><xsl:if test="$p_2&gt;1 or following-sibling::*[local-name()=local-name(current())]">[<xsl:value-of select="$p_2"/>]</xsl:if></xsl:otherwise></xsl:choose></xsl:template><xsl:template match="@*" mode="schematron-get-full-path"><xsl:text>/</xsl:text><xsl:choose><xsl:when test="namespace-uri()=''">@<xsl:value-of select="name()"/></xsl:when><xsl:otherwise><xsl:text>@*[local-name()='</xsl:text><xsl:value-of select="local-name()"/><xsl:text>' and namespace-uri()='</xsl:text><xsl:value-of select="namespace-uri()"/><xsl:text>']</xsl:text></xsl:otherwise></xsl:choose></xsl:template>

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
<xsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="" schemaVersion=""><xsl:comment><xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/></xsl:comment><svrl:ns-prefix-in-attribute-values uri="http://purl.oclc.org/dsdl/schematron" prefix="sch"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:ns-prefix-in-attribute-values uri="http://www.wron.net.au/waterml2" prefix="wml2"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/2001/XMLSchema" prefix="xsd"/><svrl:ns-prefix-in-attribute-values uri="http://purl.oclc.org/dsdl/schematron" prefix="sch"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/om/2.0" prefix="om"/><svrl:ns-prefix-in-attribute-values uri="http://www.wron.net.au/waterml2" prefix="wml2"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/samplingSpatial/2.0" prefix="sams"/><svrl:ns-prefix-in-attribute-values uri="http://purl.oclc.org/dsdl/schematron" prefix="sch"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:ns-prefix-in-attribute-values uri="http://www.wron.net.au/waterml2" prefix="wml2"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PropertiesforStringNamedValue</xsl:attribute><xsl:attribute name="name">PropertiesforStringNamedValue</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M14"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PropertiesforWaterMonitoringObservation</xsl:attribute><xsl:attribute name="name">PropertiesforWaterMonitoringObservation</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M15"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">PropertiesforWaterObservationPoint</xsl:attribute><xsl:attribute name="name">PropertiesforWaterObservationPoint</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M16"/></svrl:schematron-output></xsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl"/>

<!--PATTERN PropertiesforStringNamedValue-->


	<!--RULE -->
<xsl:template match="//wml2:StringNamedValue" priority="1000" mode="M14"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:StringNamedValue"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="wml2:value or (empty(wml2:value/*) and wml2:value/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="wml2:value or (empty(wml2:value/*) and wml2:value/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>value must contain either  or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template><xsl:template match="text()" priority="-1" mode="M14"/><xsl:template match="@*|node()" priority="-2" mode="M14"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M14"/></xsl:template>

<!--PATTERN PropertiesforWaterMonitoringObservation-->


	<!--RULE -->
<xsl:template match="//wml2:WaterMonitoringObservation" priority="1000" mode="M15"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:WaterMonitoringObservation"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="om:metadata/wml2:ObservationMetadata or (empty(om:metadata/*) and om:metadata/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="om:metadata/wml2:ObservationMetadata or (empty(om:metadata/*) and om:metadata/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>metadata must contain either ObservationMetadata or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose>

		<!--ASSERT -->
<xsl:choose><xsl:when test="om:procedure/wml2:WaterObservationProcess or (empty(om:procedure/*) and om:procedure/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="om:procedure/wml2:WaterObservationProcess or (empty(om:procedure/*) and om:procedure/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>procedure must contain either WaterObservationProcess or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose>

		<!--ASSERT -->
<xsl:choose><xsl:when test="om:result/wml2:Timeseries or (empty(om:result/*) and om:result/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="om:result/wml2:Timeseries or (empty(om:result/*) and om:result/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>result must contain either Timeseries or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose>

		<!--ASSERT -->
<xsl:choose><xsl:when test="om:featureOfInterest/sams:SF_SpatialSamplingFeature or (empty(om:featureOfInterest/*) and om:featureOfInterest/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="om:featureOfInterest/sams:SF_SpatialSamplingFeature or (empty(om:featureOfInterest/*) and om:featureOfInterest/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>featureOfInterest must contain either SF_SpatialSamplingFeature or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template><xsl:template match="text()" priority="-1" mode="M15"/><xsl:template match="@*|node()" priority="-2" mode="M15"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M15"/></xsl:template>

<!--PATTERN PropertiesforWaterObservationPoint-->


	<!--RULE -->
<xsl:template match="//wml2:WaterObservationPoint" priority="1003" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:WaterObservationPoint"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template>

	<!--RULE -->
<xsl:template match="//wml2:WaterObservationSection" priority="1002" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:WaterObservationSection"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template>

	<!--RULE -->
<xsl:template match="//wml2:WaterObservationTransect" priority="1001" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:WaterObservationTransect"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template>

	<!--RULE -->
<xsl:template match="//wml2:WaterObservationVolume" priority="1000" mode="M16"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="//wml2:WaterObservationVolume"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="wml2:relatedObservation/wml2:WaterMonitoringObservation or (empty(wml2:relatedObservation/*) and wml2:relatedObservation/@xlink:href)"><xsl:attribute name="flag">error</xsl:attribute><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>relatedObservation must contain either WaterMonitoringObservation or nothing (and carry an xlink:href instead)</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template><xsl:template match="text()" priority="-1" mode="M16"/><xsl:template match="@*|node()" priority="-2" mode="M16"><xsl:apply-templates select="*|comment()|processing-instruction()" mode="M16"/></xsl:template></xsl:stylesheet>