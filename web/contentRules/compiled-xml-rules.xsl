<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet xmlns:iso="http://purl.oclc.org/dsdl/schematron" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:saxon="http://saxon.sf.net/" xmlns:schold="http://www.ascc.net/xml/schematron" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:wml2="http://www.opengis.net/waterml/2.0" xmlns:om="http://www.opengis.net/om/2.0" xmlns:gml="http://www.opengis.net/gml/3.2" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:swe="http://www.opengis.net/swe/2.0" version="2.0"><!--Implementers: please note that overriding process-prolog or process-root is 
    the preferred method for meta-stylesheets to use where possible. -->
<xsl:param name="archiveDirParameter" tunnel="no"/><xsl:param name="archiveNameParameter" tunnel="no"/><xsl:param name="fileNameParameter" tunnel="no"/><xsl:param name="fileDirParameter" tunnel="no"/><xsl:variable name="document-uri"><xsl:value-of select="document-uri(/)"/></xsl:variable>

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
<xsl:template match="/"><svrl:schematron-output xmlns:svrl="http://purl.oclc.org/dsdl/svrl" title="OGC WaterML2.0 XML encoding tests" schemaVersion=""><xsl:comment><xsl:value-of select="$archiveDirParameter"/>   
		 <xsl:value-of select="$archiveNameParameter"/>  
		 <xsl:value-of select="$fileNameParameter"/>  
		 <xsl:value-of select="$fileDirParameter"/></xsl:comment><svrl:text>This schematron schema checks the XML encoding requirements of OGC WaterML2.0, as specified
    in the requirements class: http://www.opengis.net/spec/waterml/2.0/req/xsd-xml-rules</svrl:text><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/waterml/2.0" prefix="wml2"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/om/2.0" prefix="om"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/gml/3.2" prefix="gml"/><svrl:ns-prefix-in-attribute-values uri="http://www.w3.org/1999/xlink" prefix="xlink"/><svrl:ns-prefix-in-attribute-values uri="http://www.opengis.net/swe/2.0" prefix="swe"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">result</xsl:attribute><xsl:attribute name="name">Test recommendation: /req/xsd-xml-rules/xlink-title</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M7"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">swe-types</xsl:attribute><xsl:attribute name="name">Test requirement: /req/xsd-xml-rules/swe-types</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M8"/><svrl:active-pattern><xsl:attribute name="document"><xsl:value-of select="document-uri(/)"/></xsl:attribute><xsl:attribute name="id">validLocalXlink</xsl:attribute><xsl:attribute name="name">Test recommendation: /req/xsd-xml-rules/xlink-valid-local-reference</xsl:attribute><xsl:apply-templates/></svrl:active-pattern><xsl:apply-templates select="/" mode="M9"/></svrl:schematron-output></xsl:template>

<!--SCHEMATRON PATTERNS-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">OGC WaterML2.0 XML encoding tests</svrl:text>

<!--PATTERN resultTest recommendation: /req/xsd-xml-rules/xlink-title-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Test recommendation: /req/xsd-xml-rules/xlink-title</svrl:text>

	<!--RULE -->
<xsl:template match="*[@xlink:href]" priority="1000" mode="M7"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*[@xlink:href]"/>

		<!--REPORT -->
<xsl:if test="not(starts-with(@xlink:href, '#') ) and not(@xlink:title)"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(starts-with(@xlink:href, '#') ) and not(@xlink:title)"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>If an xlink:href is used to reference a controlled vocabulary item, the element should encode the
        xlink:title attribute with a text description of the referenced item.If an xlink:href is used to reference a controlled vocabulary item, the
        element should encode the xlink:title attribute with a text description of the referenced item.</svrl:text></svrl:successful-report></xsl:if><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></xsl:template><xsl:template match="text()" priority="-1" mode="M7"/><xsl:template match="@*|node()" priority="-2" mode="M7"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M7"/></xsl:template>

<!--PATTERN swe-typesTest requirement: /req/xsd-xml-rules/swe-types-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Test requirement: /req/xsd-xml-rules/swe-types</svrl:text>

	<!--RULE -->
<xsl:template match="swe:Category" priority="1002" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="swe:Category"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>When using the SWE Common types, the following elements shall not be used: 
        swe:quality (AbstractSimpleComponentType), swe:nilValues (AbstractSimpleComponentType), swe:constraint.</svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></xsl:template>

	<!--RULE -->
<xsl:template match="swe:QuantityType" priority="1001" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="swe:QuantityType"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>When using the SWE Common types, the following elements shall not be used: 
        swe:quality (AbstractSimpleComponentType), swe:nilValues (AbstractSimpleComponentType), swe:constraint.
       </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></xsl:template>

	<!--RULE -->
<xsl:template match="swe:Quantity" priority="1000" mode="M8"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="swe:Quantity"/>

		<!--ASSERT -->
<xsl:choose><xsl:when test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"/><xsl:otherwise><svrl:failed-assert xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="not(swe:quality) and not(swe:nilValues) and not(swe:constraint)"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>When using the SWE Common types, the following elements shall not be used: 
        swe:quality (AbstractSimpleComponentType), swe:nilValues (AbstractSimpleComponentType), swe:constraint.
       </svrl:text></svrl:failed-assert></xsl:otherwise></xsl:choose><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></xsl:template><xsl:template match="text()" priority="-1" mode="M8"/><xsl:template match="@*|node()" priority="-2" mode="M8"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M8"/></xsl:template>

<!--PATTERN validLocalXlinkTest recommendation: /req/xsd-xml-rules/xlink-valid-local-reference-->
<svrl:text xmlns:svrl="http://purl.oclc.org/dsdl/svrl">Test recommendation: /req/xsd-xml-rules/xlink-valid-local-reference</svrl:text>

	<!--RULE -->
<xsl:template match="*[@xlink:href]" priority="1000" mode="M9"><svrl:fired-rule xmlns:svrl="http://purl.oclc.org/dsdl/svrl" context="*[@xlink:href]"/>

		<!--REPORT -->
<xsl:if test="starts-with(@xlink:href, '#') and not(//@*[local-name()='id' ]=substring(@xlink:href, 2))"><svrl:successful-report xmlns:svrl="http://purl.oclc.org/dsdl/svrl" test="starts-with(@xlink:href, '#') and not(//@*[local-name()='id' ]=substring(@xlink:href, 2))"><xsl:attribute name="location"><xsl:apply-templates select="." mode="schematron-select-full-path"/></xsl:attribute><svrl:text>If an xlink:href is a local reference
        the reference element must exist. </svrl:text></svrl:successful-report></xsl:if><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></xsl:template><xsl:template match="text()" priority="-1" mode="M9"/><xsl:template match="@*|node()" priority="-2" mode="M9"><xsl:apply-templates select="@*|*|comment()|processing-instruction()" mode="M9"/></xsl:template></xsl:stylesheet>