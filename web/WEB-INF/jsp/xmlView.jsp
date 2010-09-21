<?xml version="1.0" encoding="UTF-8"?>
<%-- 
    Document   : xml view
    Created on : 20/05/2009, 12:54:05 PM
    Author     : yu021
--%>
<%@page contentType="text/xml" pageEncoding="UTF-8"%><%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %><%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %><%@ page isELIgnored="false"%>
<%
pageContext.setAttribute("newLineChar", "\n");
 int errorCount = 0;
%>
<validation>

<title>Validation Result</title>

<input>

<mode><c:out value="${validationType}"/></mode>

<method>
<input><c:out value="${inputMethod}"/></input>
<c:if test="${inputMethod == 'file'}"><filename><c:out value="${contentFilename}"/></filename></c:if>
</method>

<catalogs><c:out value="${catalogs}"/></catalogs>
<inputversion><c:out value="${validationVersion}"/></inputversion>
<contentversion><c:out value="${contentWDTFVersion}"/></contentversion>

<errors><!-- input validation errors --><c:if test="${!isValidXmlData}">
<error><c:out value="${xmlDataErrorMsg}"/> <% errorCount++; %></error></c:if>
</errors>

</input>
<%
        if(errorCount > 0) {
%>
<result/>
<%        }
        else {
%>
<result><c:choose>
<c:when test="${validationType == 'structural' || validationType == 'combined'}">
<structure>
<check><c:if test="${ structureValidationResult}"> valid </c:if> <c:if test="${!structureValidationResult}">invalid</c:if> </check>
<c:if test="${!structureValidationResult}">
<errors>
<c:forEach var="err" items='${fn:split(structureValidationErrors, newLineChar)}'><error><c:out value='${err}' escapeXml="true"/> </error></c:forEach>
</errors>
</c:if></structure>
<c:if test="${validationType == 'structural'}">
<combined>
<check>not executed</check>
</combined></c:if>
</c:when>
</c:choose>
<c:choose>
<c:when test="${(validationType == 'combined')}">
<combined>
<check><c:choose >
<c:when test="${!structureValidationResult}"> not executed </c:when>
<c:when test="${schematronError ||  !contentValidationResult}"> invalid </c:when>
<c:otherwise> valid </c:otherwise>
</c:choose>
</check>

<errors><c:choose>
<c:when test='${schematronError}'> <error> Content validation could not initialise. Schematron Error. </error></c:when>
<c:otherwise><c:if test="${!structureValidationResult}">
<error> Content validation not performed - you are required to fix the structure first. </error></c:if>
<c:if test="${structureValidationResult && !contentValidationResult}">
<error>
Content in XML Document is NOT valid
<%
//out.println("Validation result: " + request.getAttribute("contentValidationResult"));

//out.println(request.getAttribute("contentValidationFile"));
java.io.File f = (java.io.File) request.getAttribute("contentValidationFile");
if(f != null) {
//    out.println("Result File: " + f.getPath());
    java.io.BufferedReader br = new java.io.BufferedReader(new java.io.FileReader(f));
    String line;
    while((line = br.readLine()) != null) {
        out.println(line);
    }
    f.delete();
}
else
    out.println("");
%>
</error>
</c:if>
</c:otherwise>
</c:choose>
</errors>
</combined>
</c:when></c:choose>
</result>
<% } %>
</validation>