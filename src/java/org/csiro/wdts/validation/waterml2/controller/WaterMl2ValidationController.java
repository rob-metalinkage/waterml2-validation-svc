/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.csiro.wdts.validation.waterml2.controller;

import java.io.IOException;
import org.csiro.wdts.validation.ValidationInputException;
import org.csiro.wdts.validation.ValidationResult;

import org.csiro.wdts.validation.controller.ValidationController;
import org.csiro.wdts.validation.input.ValidationFormInput;
import org.xml.sax.SAXException;


/** 
 *
 * @author yu021
 *
 * Combines calls to both XML Validation and Schematron Validation services
 * 
 */
public class WaterMl2ValidationController extends ValidationController {

    @Override
    public boolean checkValidInputVersion(ValidationFormInput bean, ValidationResult vr) throws IOException, ValidationInputException {

        //Default behaviour for WaterML 2.0 is not to check for version info... yet

        // check if file content's WDTF version matches with that of chosen validation version
        boolean validVersion = false;
        boolean validXmlData = false;
        String xmlDataError = "";

        validVersion = true;
        return validVersion;
    }


    @Override
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

    @Override
    public String getRuleLocation(ValidationFormInput bean) {
        String ruleLocation = null;

        
        ruleLocation = "contentRules/compiled-waterml2.xsl";
        

        return ruleLocation;
    }
}