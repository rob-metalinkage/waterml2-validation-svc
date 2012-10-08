/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.csiro.wdts.validation.waterml2.controller;

/**
 *
 * @author tay345
 * Exception if no profiles are defined within the XML instance class
 */
public class NoDefinedProfileException extends Exception {

    public NoDefinedProfileException(String message) {
        super(message);
    }
    
    
}
