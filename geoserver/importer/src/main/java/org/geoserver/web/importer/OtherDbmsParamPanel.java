/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;


import org.apache.batik.css.engine.sac.CSSAttributeCondition;
import org.apache.wicket.AttributeModifier;
import org.apache.wicket.Component;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.extensions.markup.html.repeater.data.sort.OrderByLink.CssModifier;
import org.apache.wicket.markup.ComponentTag;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.form.CheckBox;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.AbstractReadOnlyModel;
import org.apache.wicket.model.PropertyModel;

/**
 * Other params form for databases: schema, loose bbox, pk metadata lookup table
 *  
 * @author Andrea Aime - OpenGeo
 */
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
        final AjaxLink advanced = new AjaxLink("advancedLink") {
            
            @Override
            public void onClick(AjaxRequestTarget target) {
                advancedPanel.setVisible(!advancedPanel.isVisible());
                target.addComponent(advancedContainer);
                target.addComponent(this);
            }
        };
        advanced.add(new AttributeModifier("class", true, new AbstractReadOnlyModel() {
            
            @Override
            public Object getObject() {
                return advancedPanel.isVisible() ? "expanded" : "collapsed";
            }
        }));
        advanced.setOutputMarkupId(true);
        return advanced;
    }
    
}
