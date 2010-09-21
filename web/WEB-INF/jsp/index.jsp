<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Welcome to WaterML 2.0 Validation Service</title>

    <link type="text/css" href="resources/jquery-ui-1.7.2/css/smoothness/jquery-ui-1.7.2.custom.css" rel="Stylesheet" />


    <script type="text/javascript" src="resources/jquery.js"></script>

    <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-ui-1.7.2.custom.min.js"></script>


    <script type="text/javascript">
        <!--
        $(function() {
            $("#tabs").tabs();
        });


        $(document).ready(function() {
       
            $("#submitBtn").click(function() {
                $("#filename").val($("#fileinput").val());
                $("#displayTxt").val($("#fileinput").val());
                alert("Submit button clicked! Input= " + $("#filename").val());
            });
            $("#dataInputMethod").change(function () {
                if($(this).val() == "text") {
                    $("#fmFileInput").hide();
                    $("#fmTextInput").show();
                }
                if($(this).val() == "file") {
                    $("#fmTextInput").hide();
                    $("#fmFileInput").show();
                }
            });

            $("#fmTextInput").hide();




        });


        -->

    </script>


    <style type="text/css">
        .ui-tabs .ui-tabs-hide {
            display: none;
        }

    </style>


</head>

<body>



<h2>Welcome to WaterML 2.0 Validation Service</h2>

<p>Click on the tabs below to take you to the respective resources.</p>


<div class="sections">

    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">Validation Service</a></li>
            <li><a href="#tabs-2">Other resources</a></li>
            <li><a href="#tabs-3">Temp</a></li>
        </ul>
        <div id="tabs-1">

        <spring:nestedPath path="XMLFileInput">
        <form method="post" action="" enctype="multipart/form-data">

            <spring:bind path="catalogs">
                <input type="hidden" name="catalogs" value="localcatalog.xml"/>
            </spring:bind>

            <div>
                <div>
                    <table cellpadding="5">
                    <tr>
                    <td width="200" valign="top">
                        Validation type
                        <spring:bind path="version">
                            <select id="validationType" multiple="multiple" name="validationType">
                                <option  value="structural">Structural</option>
                                <option selected value="combined">Combined</option>
                            </select>
                        </spring:bind>
                    </td>
                    <td valign="top">
                    <div id="structuralDescrip" style="vertical-align: top">
                        <b>Structural validation:</b> <u>XML structure</u> & <u>XML Schema validation</u>
                        against <a href="browseSchemas.htm">cached schemas</a>.
                    </div>
                    <br/>
                    <div id="contentDescrip">
                        <b>Combined validation: </b> Combines <u>Structural</u> validation (see above) &amp;
                        <u>Content</u> validation against content rules and vocabulary service
                    </div>
                </td>
                </tr>
                </table>
<hr/>

            </div>

            <div>

                <table cellpadding="5">
                    <tr>
                        <td  valign="top">
                            <p>Input method</p>
                            <spring:bind path="inputMethod">
                                <select id="dataInputMethod" multiple="multiple" name="inputMethod">
                                    <option value="file" selected>File</option>
                                    <option value="text" >Text input</option>
                                </select>
                            </spring:bind>

                        </td>
                        <td valign="top">

                            <div id="fmFileInput">
                                <p>Select a file to validate: </p>

                                <input id="fileinput" type="file" name="file"/>
                                <spring:bind path="filename">
                                    <input id="filename" type="hidden" name="filename"/>
                                </spring:bind>
                                <input id="displayTxt" type="text" name="displayTxt"/>
                            </div>

                            <div id="fmTextInput">
                                <p>Enter XML Text below:</p>
                                <spring:bind path="xmltext">
                                    <textarea name="xmltext" rows="20" cols="80">
                            <%/*
        java.net.URL url = config.getServletContext().getResource("/sample/timeseries.xml");
        BufferedReader buffreader = new BufferedReader(new InputStreamReader(url.openStream()));
        String line = "";
        while ((line = buffreader.readLine()) != null) {
        out.println(line);
        }
        out.flush();
        buffreader.close();
         */
        %>
                                    </textarea>
                                </spring:bind>
                            </div>

                        </td>


                    </tr>
                </table>
                <hr/>



            </div>

        </div>
        <!-- Uncomment the following block to enable version user input
        <div>
            <p>Version</p>
            <spring:bind path="version">
                <select multiple="multiple" name="version">
                    <option value="wdtf0.2">WDTF 0.2</option>
                    <option value="wdtf0.3" selected>WDTF 0.3</option>
                </select>
            </spring:bind>

<hr/>
        </div> -->

        <table cellpadding="5">
            <tr>
                <td  valign="top">

                </td>
                <td valign="top">
                </td>

                <td  valign="top">
                </td>


            </tr>
        </table>


        <input id="submitBtn" type="submit" value="Validate my XML "/>

    </form>
    </spring:nestedPath>


</div>
<div id="tabs-3">
    <p>
        <b>Validation offered:</b>  Combines <u>Structural</u> validation (see above) &amp; <u>Content</u> validation
        against content rules and vocabulary service
    </p>

    <ol style="list-style:lower-alpha">
        <li>
            <a href="combinedvalidation.htm">Combined validation by text input</a> <br/>
        </li>
        <li>
            <a href="combinedfilevalidation.htm">Combined validation by file </a> <br/>
        </li>
    </ol>
</div>

<div id="tabs-2">
    <h3>Web services</h3>

    <ul>
        <li>
            <p>SOAP-based Web Service (<a href="SOAPValidation?wsdl">WSDL</a>)</p>
        </li>
    </ul>
    <h3>References: </h3>

    <ul>
        <li>
            <p>Local cached schemas</p>
            <ul>
                <li>
                    <a href="browseSchemas.htm">Browse schemas</a>
                </li>
            </ul>
        </li>
    </ul>
</div>
</div>

</div>


</body>
</html>
