/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.csiro.wdts.validation.waterml2.config;

/**
 *
 * @author yu021
 */
public class ConfigProp {
    private String vocabServiceLocation;
    private String vocabLookupLocation;
    private String defaultContentRulesFile;

    public String getDefaultContentRulesFile() {
        return defaultContentRulesFile;
    }

    public void setDefaultContentRulesFile(String defaultContentRulesFile) {
        this.defaultContentRulesFile = defaultContentRulesFile;
    }

    public String getVocabLookupLocation() {
        return vocabLookupLocation;
    }

    public void setVocabLookupLocation(String vocabLookupLocation) {
        this.vocabLookupLocation = vocabLookupLocation;
    }

    public String getVocabServiceLocation() {
        return vocabServiceLocation;
    }

    public void setVocabServiceLocation(String vocabServiceLocation) {
        this.vocabServiceLocation = vocabServiceLocation;
    }

}
