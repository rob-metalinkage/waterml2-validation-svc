<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    String startingPoint = "schemas";
    String requestUri = request.getRequestURI();
    String scriptName = "browseSchemas.do";
    boolean atRoot = false;

    String path = "";

    path = request.getParameter("loc");
    if(path == null) {
        path = startingPoint;
        atRoot = true;
    }


    if(path.matches(startingPoint)) {
        atRoot = true;
    }

    /*
    out.println(scriptName);
    out.println(path);
    out.println(startingPoint);
    out.println(atRoot);
    */
%>
<HTML>
    <HEAD>
        <TITLE>Browse cached schemas</TITLE>
        <link rel="stylesheet" type="text/css" href="resources/bom/stylestd.css">
    </HEAD>

    <BODY>
        <H1><big>Browse cached schemas</big></H1>
        <h3>Path: <%= path %>/ </h3>
        <%
            String file = application.getRealPath(path);

            File f = new File(file);
            String [] fileNames = f.list();
            File [] fileObjects= f.listFiles();
        %>
        <UL>
        <%
            if(!atRoot) {
                String updir = path.substring(0, path.lastIndexOf("/"));
                out.println("<li><a href='" + scriptName + "?loc=" + updir + "'>..</a></li>");
            }
            for (int i = 0; i < fileObjects.length; i++) {
                if(fileObjects[i].isDirectory()){ %>
        <LI>[DIR]
          <A HREF="<%= scriptName %>?loc=<%= path + "/" + fileNames[i] %>"><%= fileNames[i] %></A>
        </LI>
        <%
                }
                else if (fileNames[i].matches(".*\\..*")) {
        %>
        <LI>
          <A HREF="<%= path + "/" + fileNames[i] %>"><%= fileNames[i] %></A>
        </LI>
        <%
                }
            }
        %>
        </UL>

       
    </BODY>
</HTML>