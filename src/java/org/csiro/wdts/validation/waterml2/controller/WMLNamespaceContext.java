/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package org.csiro.wdts.validation.waterml2.controller;

import java.util.Iterator;
import javax.xml.namespace.NamespaceContext;

/**
 *
 * @author tay345
 */
class WMLNamespaceContext implements NamespaceContext {

    public WMLNamespaceContext() {
    }

    @Override
    public String getNamespaceURI(String prefix) {
        if (prefix.equals("wml2"))
            return "http://www.opengis.net/waterml/2.0";
        else if (prefix.equals("xlink"))
            return "http://www.w3.org/1999/xlink";
        else if (prefix.equals("gml"))
            return "http://www.opengis.net/gml/3.2";
        else
            return "";
    }

    @Override
    public String getPrefix(String namespace) {
        if (namespace.equals("http://www.opengis.net/waterml/2.0"))
            return "wml2";
        else if (namespace.equals("http://www.w3.org/1999/xlink"))
            return "xlink";
        else if (namespace.equals("http://www.opengis.net/gml/3.2"))
            return "gml";
        
        return "";
    }

    @Override
    public Iterator getPrefixes(String string) {
        return null;
    }
    
}
