package org.geoserver.web.importer;


import org.apache.wicket.Component;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.PropertyModel;

@SuppressWarnings("serial")
public class OtherDbmsParamPanel extends Panel {
    String schema;
    boolean excludeGeometryless = true;
    boolean looseBBox = true;
    String pkMetadata;
    WebMarkupContainer advancedContainer;
    private WebMarkupContainer advancedPanel;
    
    public OtherDbmsParamPanel(String id, String defaultSchema, boolean showLooseBBox) {
        super(id);
        this.schema = defaultSchema;
        
        add(new TextField("schema", new PropertyModel(this, "schema")));
        add(new CheckBox("excludeGeometryless", new PropertyModel(this, "excludeGeometryless")));
        
        add(toggleAdvanced());
        
        advancedContainer = new WebMarkupContainer("advancedContainer");
        advancedContainer.setOutputMarkupId(true);
        advancedPanel = new WebMarkupContainer("advanced");
        advancedPanel.setVisible(false);
        WebMarkupContainer looseBBoxContainer = new WebMarkupContainer("looseBBoxContainer");
        looseBBoxContainer.setVisible(showLooseBBox);
        CheckBox fastBBoxCheck = new CheckBox("looseBBox", new PropertyModel(this, "looseBBox"));
        looseBBoxContainer.add(fastBBoxCheck);
        advancedPanel.add(looseBBoxContainer);
        advancedPanel.add(new TextField("pkMetadata", new PropertyModel(this, "pkMetadata")));
        advancedContainer.add(advancedPanel);
        add(advancedContainer);
    }
    
    Component toggleAdvanced() {
        return new AjaxLink("advancedLink") {
            
            @Override
            public void onClick(AjaxRequestTarget target) {
                System.out.println("TODO: change link style");
                advancedPanel.setVisible(!advancedPanel.isVisible());
                target.addComponent(advancedContainer);
            }
        };
    }
    
}
