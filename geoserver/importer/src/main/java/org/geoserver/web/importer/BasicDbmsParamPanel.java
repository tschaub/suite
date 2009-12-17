/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;

import org.apache.wicket.markup.html.form.PasswordTextField;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.PropertyModel;

/**
 * Panel for the basic dbms parameters 
 * @author Andrea Aime - OpenGeo
 */
@SuppressWarnings("serial")
public class BasicDbmsParamPanel extends Panel {
    String host;

    int port;

    String username;

    String password;

    String database;

    public BasicDbmsParamPanel(String id, String host, int port, boolean databaseRequired) {
        super(id);
        this.host = host;
        this.port = port;

        add(new TextField("host", new PropertyModel(this, "host")).setRequired(true));
        add(new TextField("port", new PropertyModel(this, "port")).setRequired(true));
        add(new TextField("username", new PropertyModel(this, "username")).setRequired(true));
        add(new PasswordTextField("password", new PropertyModel(this, "password"))
                .setResetPassword(false));
        add(new TextField("database", new PropertyModel(this, "database"))
                .setRequired(databaseRequired));
    }

}
