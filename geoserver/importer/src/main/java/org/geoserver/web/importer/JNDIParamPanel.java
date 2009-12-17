package org.geoserver.web.importer;


import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.PropertyModel;

@SuppressWarnings("serial")
public class JNDIParamPanel extends Panel {
    String jndiReferenceName = "java:comp/env/jdbc/mydatabase";
    
    public JNDIParamPanel(String id) {
        super(id);
        
        add(new TextField("jndiReferenceName", new PropertyModel(this, "jndiReferenceName")).setRequired(true));
    }
    
}
