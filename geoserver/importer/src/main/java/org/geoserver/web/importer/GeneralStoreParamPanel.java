/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;

import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.PropertyModel;
import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.web.data.workspace.WorkspaceChoiceRenderer;
import org.geoserver.web.data.workspace.WorkspaceDetachableModel;
import org.geoserver.web.data.workspace.WorkspacesModel;

@SuppressWarnings("serial")
public class GeneralStoreParamPanel extends Panel {
    IModel workspace;
    String name;
    String description;
    
    public GeneralStoreParamPanel(String id, Catalog catalog) {
        super(id);
        
        // workspace chooser
        workspace = new WorkspaceDetachableModel(catalog.getDefaultWorkspace());
        DropDownChoice choice = new DropDownChoice("workspace", workspace, new WorkspacesModel(), new WorkspaceChoiceRenderer());
        add(choice);
        
        // add workspace link
        add(new AjaxLink("createWorkspace") {
            
            @Override
            public void onClick(AjaxRequestTarget target) {
                System.out.println("Do something here");
                // create a new workspace subclass that goes back here? 
                // Add "go back to page" as a general functionality in GS pages?
            }
        });
        
        // name and description
        add(new TextField("name", new PropertyModel(this, "name")).setRequired(true));
        add(new TextField("description", new PropertyModel(this, "description")));
    }

    public WorkspaceInfo getWorkpace() {
        return (WorkspaceInfo) workspace.getObject();
    }

    
}

