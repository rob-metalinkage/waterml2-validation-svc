<%--
Views should be stored under the WEB-INF folder so that
they are not accessible except through controller process.

This JSP is here to provide a redirect to the dispatcher
servlet but should be the only JSP outside of WEB-INF.

Change Note: Due to solving the problem of not being able to be accessed by URL
www.bom.gov.au/jsp/wdtf/wdtf-validation,
the line containing response.sendRedirect("index.htm");
has been replaced with jsp:forward.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:forward page="index.htm"/>

