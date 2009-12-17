/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;

import static org.geotools.data.postgis.PostgisNGDataStoreFactory.*;
import static org.geotools.jdbc.JDBCJNDIDataStoreFactory.*;

import java.io.Serializable;
import java.net.URI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.apache.wicket.Component;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.SubmitLink;
import org.apache.wicket.model.PropertyModel;
import org.geoserver.catalog.CatalogBuilder;
import org.geoserver.catalog.NamespaceInfo;
import org.geoserver.catalog.StoreInfo;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.web.GeoServerSecuredPage;
import org.geoserver.web.wicket.ParamResourceModel;
import org.geotools.data.DataAccess;
import org.geotools.data.DataAccessFinder;
import org.geotools.data.DataStoreFactorySpi;
import org.geotools.data.postgis.PostgisNGDataStoreFactory;
import org.geotools.data.postgis.PostgisNGJNDIDataStoreFactory;

/**
 * Connection params form for the PostGIS database
 * @author Andrea Aime - OpenGeo
 */
@SuppressWarnings("serial")
public class PostGISPage extends GeoServerSecuredPage {
    /** The PostGIS connection types */
    enum ConnectionType {
        Default, JNDI;

        public String toString() {
            return new ParamResourceModel("ConnectionType." + this.name(), null).getString();
        };
    };

    ConnectionType connectionType = ConnectionType.Default;

    String schema;

    boolean looseBBox;

    String pkMetadataTable;

    Form form;

    GeneralStoreParamPanel generalParams;

    private ConnectionPoolParamPanel connectionPoolPanel;

    private WebMarkupContainer connPoolParametersContainer;

    private WebMarkupContainer connParamContainer;

    private JNDIParamPanel jndiParamsPanel;

    private BasicDbmsParamPanel basicDbmsPanel;

    private Component connPoolLink;

    private OtherDbmsParamPanel otherParamsPanel;

    public PostGISPage() {
        form = new Form("form");
        add(form);

        // general parameters panel
        form.add(generalParams = new GeneralStoreParamPanel("generalParams", getCatalog()));

        // connection type chooser
        form.add(connectionTypeSelector());

        // default param panels
        connParamContainer = new WebMarkupContainer("connectionParamsContainer");
        connParamContainer.setOutputMarkupId(true);

        basicDbmsPanel = new BasicDbmsParamPanel("basicParameters", "localhost", 5432, true);
        connParamContainer.add(basicDbmsPanel);
        connPoolLink = toggleConnectionPoolLink();
        connParamContainer.add(connPoolLink);
        connPoolParametersContainer = new WebMarkupContainer("connPoolParametersContainer");
        connPoolParametersContainer.setOutputMarkupId(true);
        connectionPoolPanel = new ConnectionPoolParamPanel("connPoolParameters", true);
        connectionPoolPanel.setVisible(false);
        connPoolParametersContainer.add(connectionPoolPanel);
        connParamContainer.add(connPoolParametersContainer);
        form.add(connParamContainer);

        // jndi param panels
        jndiParamsPanel = new JNDIParamPanel("jndiParameters");
        jndiParamsPanel.setVisible(false);
        connParamContainer.add(jndiParamsPanel);
        form.add(connParamContainer);

        // other params
        otherParamsPanel = new OtherDbmsParamPanel("otherParams", "public", true);
        form.add(otherParamsPanel);

        // next button (where the action really is)
        SubmitLink submitLink = submitLink();
        form.add(submitLink);
        form.setDefaultButton(submitLink);
    }

    /**
     * Toggles the connection pool param panel
     * 
     * @return
     */
    Component toggleConnectionPoolLink() {
        return new AjaxLink("connectionPoolLink") {

            @Override
            public void onClick(AjaxRequestTarget target) {
                System.out.println("TODO: change link style");
                connectionPoolPanel.setVisible(!connectionPoolPanel.isVisible());
                target.addComponent(connPoolParametersContainer);
            }
        };
    }

    /**
     * Switches between the types of param panels
     * 
     * @return
     */
    Component connectionTypeSelector() {
        DropDownChoice choice = new DropDownChoice("connType", new PropertyModel(this,
                "connectionType"), Arrays.asList(ConnectionType.values()));
        choice.add(new AjaxFormComponentUpdatingBehavior("onchange") {

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                boolean jndi = !jndiParamsPanel.isVisible();
                basicDbmsPanel.setVisible(!jndi);
                connPoolLink.setVisible(!jndi);
                connectionPoolPanel.setVisible(false);
                jndiParamsPanel.setVisible(jndi);

                target.addComponent(connParamContainer);
            }
        });

        return choice;
    }

    /**
     * Setups the datastore and moves to the next page
     * 
     * @return
     */
    SubmitLink submitLink() {
        // TODO: fill this up with the required parameters
        return new SubmitLink("next") {

            @Override
            public void onSubmit() {
                try {
                    // check there is not another store with the same name
                    WorkspaceInfo workspace = generalParams.getWorkpace();
                    NamespaceInfo namespace = getCatalog()
                            .getNamespaceByPrefix(workspace.getName());
                    StoreInfo oldStore = getCatalog().getStoreByName(workspace, generalParams.name,
                            StoreInfo.class);
                    if (oldStore != null) {
                        error(new ParamResourceModel("ImporterError.duplicateStore",
                                PostGISPage.this, generalParams.name, workspace.getName()).getString());
                        return;
                    }

                    // build up the store connection param map
                    Map<String, Serializable> params = new HashMap<String, Serializable>();
                    DataStoreFactorySpi factory;
                    if (connectionType == ConnectionType.JNDI) {
                        factory = new PostgisNGJNDIDataStoreFactory();

                        params.put(PostgisNGJNDIDataStoreFactory.DBTYPE.key,
                                (String) PostgisNGJNDIDataStoreFactory.DBTYPE.sample);
                        params.put(JNDI_REFNAME.key, jndiParamsPanel.jndiReferenceName);
                    } else {
                        factory = new PostgisNGDataStoreFactory();

                        // basic params
                        params.put(PostgisNGDataStoreFactory.DBTYPE.key,
                                (String) PostgisNGDataStoreFactory.DBTYPE.sample);
                        params.put(HOST.key, basicDbmsPanel.host);
                        params.put(PostgisNGDataStoreFactory.PORT.key, basicDbmsPanel.port);
                        params.put(USER.key, basicDbmsPanel.username);
                        params.put(PASSWD.key, basicDbmsPanel.password);
                        params.put(DATABASE.key, basicDbmsPanel.database);

                        // connection pool params
                        params.put(MINCONN.key, connectionPoolPanel.minConnection);
                        params.put(MAXCONN.key, connectionPoolPanel.maxConnection);
                        params.put(FETCHSIZE.key, connectionPoolPanel.fetchSize);
                        params.put(MAXWAIT.key, connectionPoolPanel.timeout);
                        params.put(VALIDATECONN.key, connectionPoolPanel.validate);
                        params.put(PREPARED_STATEMENTS.key, connectionPoolPanel.preparedStatements);

                    }
                    params.put(NAMESPACE.key, new URI(namespace.getURI()).toString());
                    params.put(LOOSEBBOX.key, otherParamsPanel.looseBBox);
                    params.put(PK_METADATA_TABLE.key, otherParamsPanel.pkMetadata);

                    // ok, check we can connect
                    try {
                        DataAccess store = DataAccessFinder.getDataStore(params);
                        // force the store to open a connection
                        store.getNames();
                        store.dispose();
                    } catch (Throwable e) {
                        LOGGER.log(Level.INFO, "Could not connect to the datastore", e);
                        error(new ParamResourceModel("ImporterError.databaseConnectionError",
                                PostGISPage.this, e.getMessage()).getString());
                        return;
                    }

                    // build the store
                    CatalogBuilder builder = new CatalogBuilder(getCatalog());
                    builder.setWorkspace(workspace);
                    StoreInfo si = builder.buildDataStore(generalParams.name);
                    si.setDescription(generalParams.description);
                    si.getConnectionParameters().putAll(params);
                    si.setEnabled(true);
                    si.setType(factory.getDisplayName());
                    getCatalog().add(si);

                    // redirect to the layer chooser
                    PageParameters pp = new PageParameters();
                    pp.put("store", si.getName());
                    pp.put("workspace", workspace.getName());
                    pp.put("storeNew", true);
                    pp.put("workspaceNew", false);
                    setResponsePage(VectorLayerChooserPage.class, pp);
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error while setting up mass import", e);
                }

            }
        };
    }

}
