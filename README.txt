WaterML 2.0 Validation Service.
===============================

This package contains the libraries, code, and schemas for WaterML 2.0 validation service 
based on the architecture of the Water Data Transfer Format (WDTF) validation service (Yu et al. 2011).

It extends the validation-svc-base framework for a two pass XML validation service
(see https://github.com/CSIRO-enviro-informatics/validation-svc-base). 
First pass XSD validation and second pass Schematron validation. Specific extensions are 
to the Java validation code for WaterML2.0 validation.

The set of XML Schemas and Schematron rules can be found here:
http://schemas.opengis.net/waterml/2.0/


Quick start
-----------

1. Run ant script to obtain WAR file:

	$ ant war


2. Deploy this into your J2EE web service/Tomcat