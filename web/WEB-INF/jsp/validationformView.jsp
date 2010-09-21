<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Put unique datetime 11:06 Tue 13 July 2010 here to force guaranteed checked in with new $Rev code.
    But be sure to check in the jsp file to force a new $Rev nuumber.
-->
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>WaterML 2.0 Validation Service</title>

    <link type="text/css" href="resources/jquery-ui-1.7.2/css/smoothness/jquery-ui-1.7.2.custom.css" rel="Stylesheet" />
    <link rel="stylesheet" type="text/css" href="resources/bom/stylestd.css">


    <script type="text/javascript" src="resources/jquery.js"></script>

    <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-1.3.2.min.js"></script>
    <script type="text/javascript" src="resources/jquery-ui-1.7.2/js/jquery-ui-1.7.2.custom.min.js"></script>


    <script type="text/javascript">
        <!--

        function loadSubmit() {
            ProgressImage = document.getElementById('progress_image');
            document.getElementById("progress").style.visibility = "visible";
            setTimeout("ProgressImage.src = ProgressImage.src",100);
            return true;
        }
        $(function() {
            $("#tabs").tabs();
        });


        $(document).ready(function() {

            $("#submitBtn").click(function() {
                $("#filename").val($("#fileinput").val());
                $("#displayTxt").val($("#fileinput").val());
                //alert("Submit button clicked! Input= " + $("#filename").val());
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
            //code below ensures the right XML catalog is used in the processing
            $("#versionSelect").change(function () {
                if($(this).val() == "wdtf1.0.1") {
                    //$("#fmVersion03").hide();
                    //$("#fmVersion02").hide();
                    //$("#fmVersion10").show();
                    $("#catalogRef").val("catalog_wdtf1.0.1.xml");
                }
                if($(this).val() == "wdtf1.0") {
                    //$("#fmVersion03").hide();
                    //$("#fmVersion02").hide();
                    //$("#fmVersion10").show();
                    $("#catalogRef").val("catalog_wdtf1.0.xml");
                }
                if($(this).val() == "wdtf0.3") {
                    //$("#fmVersion02").hide();
                    //$("#fmVersion10").hide();
                    //$("#fmVersion03").show();
                    $("#catalogRef").val("catalog_wdtf0.3.xml");
                }
                if($(this).val() == "wdtf0.2") {
                    //$("#fmVersion03").hide();
                    //$("#fmVersion10").hide();
                    //$("#fmVersion02").show();
                    $("#catalogRef").val("catalog_wdtf0.2.xml");
                }
            });

            $("#fmTextInput").hide();

        });
        -->
    </script>

    <style type="text/css">
        <!--
        .ui-tabs .ui-tabs-hide {
            display: none;
        }
        -->
    </style>


</head>

<body>
<!-- <jsp:include page="bureau_header.html" /> -->

<!--
<div >
<img width="800" height="60" align="right" src="http://www.bom.gov.au/water/images/curve.gif" alt="Water Division" border="0"/>
<h1 align="center" style="color:black; width: 100%;">WDTF Validation Service</h1>
</div>
-->

<table style="width: 100%;" cellpadding="0" cellspacing="0">
    <tr>
        <td cellpadding="0" cellspacing="0"><h1 style="margin: 0 0 0 0" align="center">WaterML 2.0 Validation Service</h1></td>
    </tr>
</table>

<div class="sections">

    <div id="tabs">
        <ul>
            <li><a href="#tabs-1">Validation Service</a></li>
<!--
            <li><a href="#tabs-2">About</a></li>
            <li><a href="#tabs-3">Rules Coverage</a></li>
-->
            <li><a href="#tabs-4">References</a></li>
<!--
            <li><a href="#tabs-5">Feedback</a></li>
            <li><a href="#tabs-6">Changes Note</a></li>
-->
        </ul>
        <div id="tabs-1">

        <spring:nestedPath path="XMLFileInput">
        <form method="post" action="" enctype="multipart/form-data">

            <spring:bind path="catalogs">
                <input id="catalogRef" type="hidden" name="catalogs" value="catalog_waterml_2.xml"/>

            </spring:bind>
            <spring:bind path="outputMethod">
                <!-- <input id="outMethod" type="hidden" name="outputMethod" value="xml"/> -->
                <input id="outMethod" type="hidden" name="outputMethod" value="html"/>
            </spring:bind>

            <div>
                <h3>Please enter the following details to validate your data:</h3>
                <hr>
                <div>
                    <table cellpadding="1" cellspacing="1">
                    <tr>
                    <td width="180" valign="top">
                        <p style="color:#0F5499; font-weight:bold;">1. Select the validation type</p>
                        <spring:bind path="version">
                            <select id="validationType" multiple="multiple" name="validationType">
                                <option value="structural">Structural</option>
                                
                                <option selected value="combined">Combined</option>
                                
                            </select>


                            <input id="version" type="hidden" name="version" value="waterml20"/>

                    </spring:bind>
                        </spring:bind>
                    </td>
                    <td valign="top">
                    <div id="structuralDescrip" style="vertical-align: top">
                        <p>Choose one of the validation types:</p>
                        <b>Structural validation:</b> <i>XML structure</i> & <i>XML Schema validation</i>
                        against <i><a href="browseSchemas.do">cached schemas</a></i>.
                    </div>
                    <div id="contentDescrip">
                        <b>Combined validation: </b> Combines <i>Structural validation</i> (see above) &amp;
                        <i>Content validation</i> against Hydrological semantics rules and vocabulary service.
                    </div>
                </td>
                </tr>
                </table>
<hr/>

            </div>

            <div>

                <table cellpadding="1" cellspacing="1">
                    <tr>
                        <td width="180"  valign="top">
                            <p style="color:#0F5499; font-weight:bold;">2. Select the input method</p>
                            <spring:bind path="inputMethod">
                                <select id="dataInputMethod" multiple="multiple" name="inputMethod">
                                    <option value="file" selected>File</option>
                                    <option value="text" >Text input</option>
                                </select>
                            </spring:bind>

                        </td>
                        <td valign="top">
                            <div id="fmFileInput">
                                <p>Input your XML Data by selecting a file you want to validate: </p>
                                <input id="fileinput" type="file" name="file"/>
                                <spring:bind path="filename">
                                    <input id="filename" type="hidden" name="filename"/>
                                </spring:bind>
                                <p>Please note there is a 3-mega-byte limit on file size.</p>
                            </div>

                            <div id="fmTextInput">
                                <p>Enter XML Text below:</p>
                                <spring:bind path="xmltext">
                                    <textarea name="xmltext" rows="20" cols="80"><%/*
        java.net.URL url = config.getServletContext().getResource("/sample/timeseries.xml");
        BufferedReader buffreader = new BufferedReader(new InputStreamReader(url.openStream()));
        String line = "";
        while ((line = buffreader.readLine()) != null) {
        out.println(line);
        }
        out.flush();
        buffreader.close();
         */
        %></textarea>
                                </spring:bind>
                            </div>

                        </td>
                    </tr>
                </table>
                <hr/>
            </div>

        </div>
        <!-- Restore back Multiple-WDTF-versions support - with explicit selection box -->
        <div>
        
        </div>
    <div>
        <table cellpadding="1" cellspacing="1">
            <tr>
                <td width="180" valign="top">
                    <p style="color:#0F5499; font-weight:bold;">3. Validate your data</p>
                </td>
                <td>
                   <div style="vertical-align: top">
                    <p>Press the button to start the validation process:
                    <input style="vertical-align:top" id="submitBtn" onclick="return loadSubmit()" type="submit" value="Validate"/>.
                    <span style="visibility:hidden;" id="progress">
                      Validation in progress …
                        <img id="progress_image" height="20" width="20" style="vertical-align:top;padding-left:5px;" src="/water/wdtf/images/ajax-loader-trans.gif" alt=""/> <!-- padding-top:5px; -->
                    </span>
                   </p>
                    This may take a couple of seconds or minutes depending on the size of the data.
                   </div>
                </td>
            </tr>
        </table>
    </div>
    <hr/>
    <div>
        <table cellpadding="1" cellspacing="1">
            <tr>
                <td width="180" valign="top">
                    <p style="color:#0F5499; font-weight:bold;">4. See the validation report</p>
                </td>
                <td>
                   <div><p>A validation report will appear on screen.</p></div>
                </td>
            </tr>
        </table>
    </div>
    </form>
    </spring:nestedPath>

</div>


<div id="tabs-4">
    <!--
    <h3>Web services</h3>

    <ul>
        <li>
            <p>SOAP-based Web Service (<a href="SOAPValidation?wsdl">WSDL</a>)</p>
        </li>
    </ul>
    -->
    <h3>References</h3>

    <ul>
        <li>
            <p>Local cached schemas</p>
            <ul>
                <li>
                    <!--
                    <a href="/water/wdtf/documentation/BrowseSchemas/browseSchemas.htm">Browse schemas</a>
                    -->
                    <a href="browseSchemas.do">Browse schemas</a>
                </li>
            </ul>
        </li>
    </ul>
</div>


</div> <!-- tabs -->
</div> <!-- sections -->

<!--
<jsp:include page="copyright.html" />
-->
</body>
</html>
