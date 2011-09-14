<%-- 
    Document   : combinedvalidationresultView
    Created on : 20/05/2009, 12:54:05 PM
    Author     : yu021
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ page isELIgnored="false"%>
<% pageContext.setAttribute("newLineChar", "\n");%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Validation Result</title>

        <link type="text/css" href="resources/jquery-ui-1.7.2/css/smoothness/jquery-ui-1.7.2.custom.css" rel="Stylesheet" />
        <link rel="stylesheet" type="text/css" href="resources/bom/stylestd.css">

        <script type="text/javascript" src="resources/jquery.js"></script>

        <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-1.3.2.min.js"></script>
        <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-ui-1.7.2.custom.min.js"></script>


        <script type="text/javascript">
            <!--

            $(document).ready(function() {

                $(function() {
                    $("#accordion").accordion({
                        autoHeight: false,
						collapsible: true,
                        animated: false,
                        clearStyle: true
                    });
                });

                $("#dispInput").click(function() {
                    //$("#divXmlSource").slideToggle(1000);

                });


                $("#divXmlSource").hide();

            });

            -->
        </script>

    </head>
    <body>

<h1> Validation report </h1>

        <!-- <p><u><b>Table Of Contents:</b></u> <br/>
        <a href="#structuralvalidation">Structural validation result</a>
        <br/>
        <a href="#contentvalidation">Content validation result</a>
        </p> -->

        <div id="accordion">
            <h3><a href="#">Content submitted</a></h3>
            <div>
                <pre>
Validation mode: <c:out value="${validationType}"/>
Input method: <c:out value="${inputMethod}"/>
<c:if test="${inputMethod == 'file'}">Input: <c:out value="${contentFilename}"/> (<c:out value="${filesizeInDecimalFormat}"/> bytes)</c:if>
Validation Version: <c:out value="${validationVersion}"/>
Catalog: <c:out value="${catalogs}"/>
Content Version: <c:out value="${contentWDTFVersion}"/>
                </pre>                
            </div>

            <c:choose>
            <c:when test="${!isValidXmlData}">
                <h3>
                    <a href="#" style="color:red;">
                        <c:out value="${xmlDataErrorMsg}"/>
                    </a>
                </h3>
            </c:when>

            <c:otherwise>
            <h3>
                <a href="#">
                    Structural Validation Result: <c:if test="${ structureValidationResult}"> Valid </c:if>
                    <c:if test="${!structureValidationResult}">
                        Structural validation failed
                    </c:if>

                </a>
            </h3>
            <div>

                <c:if test="${!structureValidationResult}">

                    <h3>Errors reported</h3>
                    <c:forEach var="err" items='${fn:split(structureValidationErrors, newLineChar)}'>
                        <p><c:out value='${err}' escapeXml="true"/> </p>
                    </c:forEach>

                </c:if>


            </div>

            <c:if test="${validationType == 'combined'}">

            <h3><a href="#">Content Validation Result:

                <c:choose >
                    <c:when test="${numContentValidationErrors>0 || schematronError || !structureValidationResult }">
                        Content validation failed
                    </c:when>
                    <c:when test="${numContentValidationMessages>0}">
                        Valid with warning messages
                    </c:when>
                <c:otherwise>
                    Valid
                </c:otherwise>
                </c:choose>
            </a></h3>
            <div>
                <c:choose >

                    <c:when test='${schematronError}'>
                        <h4>Content validation could not initialise</h4>

                        <pre><c:out value='${contentValidationReport}'/> </pre>

                    </c:when>

                    <c:otherwise>
                        <c:if test="${!structureValidationResult}">
                            <p>Content validation not performed - you are required to fix the structure first.</p>
                        </c:if>

                        <c:if test="${structureValidationResult}">
                            <c:if test="${numContentValidationMessages > 0}">

                                <c:if test="${numContentValidationErrors > 0}">
                                    <h4>Content in XML Document is NOT valid according to validation rules</h4>


                                </c:if>

                                <c:if test="${numContentValidationErrors == 0} ">
                                    <h4>Content in XML Document is valid according to validation rules, but contain warnings</h4>

                                </c:if>

<c:forEach var="index" items="${messages}">
  <c:forEach var="msg" items="${index.value}">
<p><b><c:out value="${index.key}"/></b>:

<c:forEach var="line" items="${fn:split(msg, newLineChar)}">
<c:out value="${line}" /><br/>
</c:forEach>
</p>
  </c:forEach>
</c:forEach>

                            </c:if>
                        </c:if>


                    </c:otherwise>


                </c:choose>

            </div> </c:if>
            </c:otherwise>
            </c:choose>
        </div>

                <!--
                        <c:out value='${debug}'/>
                        -->
        <!--
        <a href="index.htm">back to home page</a>

        <a href="/jsp/wdtf/wdtf-validation">back to home page</a>
        -->

    </body>
</html>
