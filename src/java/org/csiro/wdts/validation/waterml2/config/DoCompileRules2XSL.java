/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package org.csiro.wdts.validation.waterml2.config;

import javax.xml.transform.TransformerConfigurationException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.xml.parsers.ParserConfigurationException;
import org.csiro.wdts.validation.schematron.CompileSchematron;
import org.xml.sax.SAXException;

/**
 *
 * @author yu021
 * 
 * Changed by tay345 to iterate through a map of rule-dest for multiple sch compiles
 */
public class DoCompileRules2XSL {

    public static void main(String[] args) throws SAXException, ParserConfigurationException, FileNotFoundException, IOException, TransformerConfigurationException {
        String rules;
        String destpath;

        System.out.print("Compiling WaterML 2.0 Rules... ");
        rules = "web/contentRules/waterml2.sch";
        destpath = "web/contentRules/compiled-waterml2.xsl";
        
        HashMap<String, String> rulesDest = new HashMap<String, String>();
        rulesDest.put("web/contentRules/xml-rules.sch", 
                        "web/contentRules/compiled-xml-rules.xsl");
        rulesDest.put("web/contentRules/timeseries-observation.sch", 
                        "web/contentRules/compiled-timeseries-observation.xsl");
        rulesDest.put("web/contentRules/timeseries-tvp-observation.sch", 
                        "web/contentRules/compiled-timeseries-tvp-observation.xsl");
        rulesDest.put("web/contentRules/measurement-timeseries-tvp-observation.sch", 
                        "web/contentRules/compiled-measurement-timeseries-tvp-observation.xsl");
        rulesDest.put("web/contentRules/categorical-timeseries-tvp-observation.sch", 
                        "web/contentRules/compiled-categorical-timeseries-tvp-observation.xsl");
        rulesDest.put("web/contentRules/timeseries.sch", 
                        "web/contentRules/compiled-timeseries.xsl");
        rulesDest.put("web/contentRules/measurement-timeseries-tvp.sch", 
                        "web/contentRules/compiled-measurement-timeseries-tvp.xsl");
        rulesDest.put("web/contentRules/monitoring-point-feature-of-interest.sch", 
                        "web/contentRules/compiled-monitoring-point-feature-of-interest.xsl");
        
        for (Map.Entry<String, String> entry: rulesDest.entrySet()) {
            getRules(entry.getKey(), entry.getValue());
        }
        
        System.out.println("Done!\n");
    }

    public static void getRules(String rules, String destpath)  throws SAXException, ParserConfigurationException, FileNotFoundException, IOException, TransformerConfigurationException {


        CompileSchematron cs = new CompileSchematron();
        FileInputStream fis = new FileInputStream(rules);
        File outputfile = new File(destpath);
        System.out.print("Compiling " + rules + "...");
        cs.compileSch(fis, outputfile);
        

        //File f = cs.compiledSch;
        //cs = null;
        //File dest = new File(destpath);
        //dest.delete();
        //boolean renameSuccess = f.renameTo(dest);

        /*FileInputStream fis = new FileInputStream(f);
        FileOutputStream fos = new FileOutputStream(dest);
        FileReader fr = new FileReader(f);
        FileWriter fw = new FileWriter(dest);
        byte[] buf = new byte[1024];
        */
        /*char c;
        c = (char)fr.read();
        while( (c = (char)fr.read()) != -1) {
            fw.write(c);
        }
        //fw.write(buf);
        */
        //int bytesRead = fis.read(buf,);
        /*while(fis.read(buf) != -1) {
            fos.write(buf);
        }


        fis.close();
        fos.flush();
        fos.close();
        
        fw.close();
        fr.close();*/
    }
    
}
