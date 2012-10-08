/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.csiro.wdts.validation.waterml2.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.xml.namespace.NamespaceContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
/*import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import javax.xml.xpath.XPathFactoryConfigurationException;*/
import org.csiro.wdts.validation.ValidationInputException;
import org.csiro.wdts.validation.ValidationResult;

import org.csiro.wdts.validation.controller.ValidationController;
import org.csiro.wdts.validation.input.ValidationFormInput;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.springframework.web.servlet.ModelAndView;

/** 
 *
 * @author yu021
 *
 * Combines calls to both XML Validation and Schematron Validation services
 * Extended by tay345 to add in support for linking profile URLs with SCH files
 * 
 */
public class WaterMl2ValidationController extends ValidationController {

    
    
    public HashMap<String, String> getProfileToSchematronRules() {
        
        // TODO: Change this to look up a prop file -- using as a start for testing
        HashMap<String, String> profileURLToSCH = new HashMap<String, String>();
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-xml-rules",
                            "/web/contentRules/compiled-xml-rules.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-timeseries-observation",
                            "/web/contentRules/compiled-timeseries-observation.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-timeseries-tvp-observation",
                            "/web/contentRules/compiled-timeseries-tvp-observation.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-measurement-timeseries-tvp-observation",
                            "/web/contentRules/compiled-measurement-timeseries-tvp-observation.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-categorical-timeseries-tvp-observation",
                            "/web/contentRules/compiled-categorical-timeseries-tvp-observation.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-timeseries-tvp",
                            "/web/contentRules/compiled-timeseries.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-measurement-timeseries-tvp",
                            "/web/contentRules/compiled-measurement-timeseries-tvp.xsl");
        profileURLToSCH.put("http://www.opengis.net/spec/waterml/2.0/conf/xsd-feature-of-interest-monitoring-point",
                            "/web/contentRules/compiled-monitoring-point-feature-of-interest.xsl");

        return profileURLToSCH;
    }
    
    /** 
     * Returns a list of conformance class URLs from the XML instance document 
     * from the input form bean. The xpath to the profiles 
     * is /wml2:Collection/wml2:metadata/wml2:DocumentMetadata/wml2:profile. 
     * Array is empty if no profile element is found. 
     */
    public ArrayList<String> extractProfilesFromInstance(ValidationFormInput bean) 
            throws NoDefinedProfileException, IOException {
        
        ArrayList<String> profiles = new ArrayList<String>();
        // Setup the XPath parsers
        DocumentBuilderFactory docFactory = DocumentBuilderFactory.newInstance();
        docFactory.setNamespaceAware(true);
        DocumentBuilder builder;
        
        try {
            builder = docFactory.newDocumentBuilder();
        } catch (ParserConfigurationException ex) {
            throw new NoDefinedProfileException("Error loading XML document builder: " +
                    ex.getLocalizedMessage());
        }
        
        // Load the XML input from the validation bean
        Document doc;
        try {
            // Read the input XML instance from file or form
            if(bean.getInputMethod().equals("file")) 
                doc = builder.parse(bean.getFile().getInputStream());
            else
                doc = builder.parse(bean.getXmltext());
        }
        catch (SAXException ex){
            throw new NoDefinedProfileException("Error loading XML input: " + 
                    ex.getLocalizedMessage());
        }

        // Setup XPath and namespaces
        //System.setProperty("javax.xml.xpath.XPathFactory:"+ NamespaceConstant.OBJECT_MODEL_SAXON, "com.saxonica.config.EnterpriseXPathFactory");
        // XPathFactory factory = null;
        
        XPathFactory factory = null;
        try {
            factory = XPathFactory.newInstance();
        }
        catch (Exception exp) {
            System.out.print(exp.getLocalizedMessage());
        }
        
        /*
        try {
            factory = XPathFactory.newInstance(NamespaceConstant.OBJECT_MODEL_SAXON);
        } catch (XPathFactoryConfigurationException ex) {
            Logger.getLogger(WaterMl2ValidationController.class.getName()).log(Level.SEVERE, null, ex);
        }*/
        
        //XPathFactory factory = XPathFactoryImpl.newInstance();
        XPath xpath = factory.newXPath();
        NamespaceContext nc = new WMLNamespaceContext();
        xpath.setNamespaceContext(nc);

        XPathExpression expr;
        try {
            expr = xpath.compile("/wml2:Collection/wml2:metadata/"
                        + "wml2:DocumentMetadata/wml2:profile");
            NodeList profileNodes = (NodeList)expr.evaluate(doc, XPathConstants.NODESET);

            // No profile elements found
            if (profileNodes.getLength() == 0)
                throw new NoDefinedProfileException(
                    "No profiles were defined in the XML instance.");
            
            // Extract profile URLs from node attribute
            for (int i = 0; i < profileNodes.getLength(); i++) {
               String confClassURL = profileNodes.item(i).getAttributes().
                       getNamedItem("xlink:href").getTextContent();
               profiles.add(confClassURL);
            }

        } catch (XPathExpressionException ex) {
            throw new NoDefinedProfileException("Error on xpath to profile URLs in XML instance: " 
                    + ex.getLocalizedMessage());
        }
          
        return profiles;
    }
    
    public ArrayList<String> getSCHRules(ArrayList<String> profiles) {
        ArrayList<String> results = new ArrayList<String>();
        
        HashMap<String, String> profileToSch = getProfileToSchematronRules();
        for (String profileURL: profiles) {
            // If the profile is not found it should be a warning --
            // it is possible to have profiles that are not part of the core
            // specification (e.g. extensions). TODO: handle warnings
            if (profileToSch.containsKey(profileURL)) 
                results.add(profileToSch.get(profileURL));
        }
        return results;
    }
    
    public void performValidationSteps(ValidationFormInput bean, ValidationResult vr)
            throws IOException {
        
        /* Pre-processing step) 
         * Load mapping file as index with key-value pairs of <URI,SCH path> 
        1) Load XML instance 
        2) Do xsd checking 
        3) Parsing of the XML instance for profile elements 
        4) Resolve profile URIs to SCH path 
        5) For each profile: a. execute schematron i.e. handleContentValidation(); b. Process SVRL report 
        6) Aggregate the SVRL reports for conformance reporting
         */
        
        this.performStructuralValidation(bean, vr);
        
        // Extract the defined profile URLs from the XML instance
        // Strict rule: if there is no defined profiles, the validation fails
        try {
            ArrayList<String> implementedProfiles = this.extractProfilesFromInstance(bean);
            ArrayList<String> schRulesToRun = getSCHRules(implementedProfiles);
             
            HashMap<String, ValidationResult> results = new HashMap<String, ValidationResult>();
            
            for (String schFile : schRulesToRun) {
                this.performContentValidation(bean, vr, schFile);
                results.put(schFile, vr);
                
            }
            
            // Now get each SCH file from the map
            // Exectute each 
        } catch (NoDefinedProfileException ex) {
            vr.setContentValidationResult(false);
            vr.setContentValidationReport("No profile elements supplied to specify" +
                    " the conformance classes being used. These are required by the validation service.");
        }

    }
    
    @Override
    protected ModelAndView onSubmit(Object command) throws Exception {
//    protected ModelAndView onSubmit(HttpServletRequest request,HttpServletResponse response, Object command, BindException errors)     throws Exception {
        ModelAndView mv;
        ValidationResult vr = new ValidationResult(); //container object to populate info to return to view
        ValidationFormInput bean = (ValidationFormInput) command;
        InputStream fileInputStream = null;

        debug = "";
        chooseOutputMethod(bean);
        mv = new ModelAndView(getSuccessView());//init mv with the right view

        try {
            //handles:
            //- populating various info into bean
            //- checking of valid xml input
            //- checking of valid version input
            //- catalog selection (which determines the version selection...)
            this.performPreProcessingSteps(bean, vr);
        } catch (ValidationInputException vie) {
            vr.setValidXmlData(false);
            vr.setXmlDataErrorMsg(vie.getMessage());

            System.err.println("Caught ValidationInputException: " + vie.getMessage());
            //get the model view info required and return control
            mv = vr.getModelAndView(mv);
            return mv;
        }

        vr.setValidXmlData(true);


        //handle structural validation
        this.performValidationSteps(bean, vr);


        //return model and view object for presentation
        mv = vr.getModelAndView(mv);

        return mv;
    } // end onSubmit

    
    // I've changed this method to take a schFile to run. This breaks the interface,
    // so should be fixed to be more consistent. 
    public boolean performContentValidation(ValidationFormInput bean, ValidationResult vr, String schFile ) throws IOException {
        
        String ruleLocation = schFile;
        InputStream fileInputStream = null;
        
        boolean contentValidationResult = false;
        if (bean.getInputMethod().equals("file")) {
            fileInputStream = bean.getFile().getInputStream();
            InputStream cleanedInputStream = this.getCleanInputStream(fileInputStream);
            contentValidationResult = this.handleContentValidation(vr, cleanedInputStream, ruleLocation);

            fileInputStream.close();
            fileInputStream = null;
            cleanedInputStream.close();
            cleanedInputStream = null;
        } else {
            contentValidationResult = this.handleContentValidation(vr, bean.getXmltext(), ruleLocation);
        }

        return contentValidationResult;
    }
 
    
    public boolean checkValidInputVersion(ValidationFormInput bean, ValidationResult vr) throws IOException, ValidationInputException {

        //Default behaviour for WaterML 2.0 is not to check for version info... yet

        // check if file content's WDTF version matches with that of chosen validation version
        boolean validVersion = false;
        boolean validXmlData = false;
        String xmlDataError = "";

        validVersion = true;
        return validVersion;
    }


    public boolean performStructuralValidation(ValidationFormInput bean, ValidationResult vr) throws IOException {
        boolean structuralValidationResult = false;

        
        if(bean.getInputMethod().equals("file")) {
            structuralValidationResult =  this.handleStructuralValidation(bean.getFile().getInputStream(), bean.getCatalogs(), vr);
        }
        else  {
            structuralValidationResult = this.handleStructuralValidation(bean.getXmltext(), bean.getCatalogs(), vr);
        }

        //structuralValidationResult = true;
        vr.setStructureValidationResult(structuralValidationResult);

        return structuralValidationResult;
    }

    /*
    public String getRuleLocation(ValidationFormInput bean) {
        String ruleLocation = null;

        ruleLocation = "contentRules/compiled-waterml2.xsl";
        
        return ruleLocation;
    }*/

}