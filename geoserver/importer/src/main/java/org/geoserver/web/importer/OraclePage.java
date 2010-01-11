/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;

import static org.geotools.data.oracle.OracleNGDataStoreFactory.*;
import static org.geotools.data.oracle.OracleNGOCIDataStoreFactory.*;
import static org.geotools.jdbc.JDBCDataStoreFactory.*;
import static org.geotools.jdbc.JDBCJNDIDataStoreFactory.*;

import java.io.Serializable;
import java.net.URI;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;

import org.apache.wicket.AttributeModifier;
import org.apache.wicket.Component;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.SubmitLink;
import org.apache.wicket.model.AbstractReadOnlyModel;
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
import org.geotools.data.oracle.OracleNGDataStoreFactory;
import org.geotools.data.oracle.OracleNGJNDIDataStoreFactory;
import org.geotools.data.oracle.OracleNGOCIDataStoreFactory;
import org.geotools.data.postgis.PostgisNGDataStoreFactory;
import org.geotools.jdbc.JDBCDataStoreFactory;

/**
 * Connection params form for the Oracle database
 * @author Andrea Aime - OpenGeo
 * TODO: factor out a superclass of PostgisPage and OraclePage once all of the pages for the
 * various database types have been built and we know exactly what the moving parts are
 */
@SuppressWarnings("serial")
public class OraclePage extends GeoServerSecuredPage {
    /** The Oracle connection types */
    enum ConnectionType {
        Default, OCI, JNDI;

        public String toString() {
            return new ParamResourceModel("ConnectionType." + this.name(), null).getString();
        };
    };

    ConnectionType connectionType = ConnectionType.Default;

    String schema;

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

    private OracleOCIParamPanel ociParamsPanel;

    public OraclePage() {
        form = new Form("form");
        add(form);

        // general parameters panel
        form.add(generalParams = new GeneralStoreParamPanel("generalParams"));

        // connection type chooser
        form.add(connectionTypeSelector());

        // default param panels
        connParamContainer = new WebMarkupContainer("connectionParamsContainer");
        connParamContainer.setOutputMarkupId(true);

        basicDbmsPanel = new BasicDbmsParamPanel("basicParameters", "localhost", 1521, true);
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
        
        // oci param panel
        ociParamsPanel = new OracleOCIParamPanel("ociParameters");
        ociParamsPanel.setVisible(false);
        connParamContainer.add(ociParamsPanel);

        // other params
        otherParamsPanel = new OtherDbmsParamPanel("otherParams", "", true, true);
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
        AjaxLink connPool = new AjaxLink("connectionPoolLink") {

            @Override
            public void onClick(AjaxRequestTarget target) {
                connectionPoolPanel.setVisible(!connectionPoolPanel.isVisible());
                target.addComponent(connPoolParametersContainer);
                target.addComponent(this);
            }
        };
        connPool.add(new AttributeModifier("class", true, new AbstractReadOnlyModel() {
            
            @Override
            public Object getObject() {
                return connectionPoolPanel.isVisible() ? "expanded" : "collapsed";
            }
        }));
        connPool.setOutputMarkupId(true);
        return connPool;
    }

    /**
     * Switches between the types of param panels
     * 
     * @return
     */
    Component connectionTypeSelector() {
        final DropDownChoice choice = new DropDownChoice("connType", new PropertyModel(this,
                "connectionType"), Arrays.asList(ConnectionType.values()));
        choice.add(new AjaxFormComponentUpdatingBehavior("onchange") {

            @Override
            protected void onUpdate(AjaxRequestTarget target) {
                boolean jndi = choice.getModelObject() == ConnectionType.JNDI;
                boolean oci = choice.getModelObject() == ConnectionType.OCI;
                
                basicDbmsPanel.setVisible(!jndi && !oci);
                connPoolLink.setVisible(!jndi && !oci);
                connectionPoolPanel.setVisible(false);
                jndiParamsPanel.setVisible(jndi);
                ociParamsPanel.setVisible(oci);

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
                                OraclePage.this, generalParams.name, workspace.getName()).getString());
                        return;
                    }

                    // build up the store connection param map
                    Map<String, Serializable> params = new HashMap<String, Serializable>();
                    params.put(JDBCDataStoreFactory.DBTYPE.key, "oracle");
                    DataStoreFactorySpi factory;
                    if (connectionType == ConnectionType.JNDI) {
                        factory = new OracleNGJNDIDataStoreFactory();

                        params.put(JNDI_REFNAME.key, jndiParamsPanel.jndiReferenceName);
                    } else if (connectionType == ConnectionType.OCI) {
                        factory = new OracleNGOCIDataStoreFactory();
                        
                        params.put(ALIAS.key, ociParamsPanel.alias);
                        params.put(USER.key, ociParamsPanel.username);
                        params.put(PASSWD.key, ociParamsPanel.password);
                    } else {
                        factory = new OracleNGDataStoreFactory();

                        // basic params
                        params.put(HOST.key, basicDbmsPanel.host);
                        params.put(PostgisNGDataStoreFactory.PORT.key, basicDbmsPanel.port);
                        params.put(USER.key, basicDbmsPanel.username);
                        params.put(PASSWD.key, basicDbmsPanel.password);
                        params.put(DATABASE.key, basicDbmsPanel.database);
                    }
                    if(connectionType != ConnectionType.JNDI) {
                        // connection pool params common to OCI and default connections
                        params.put(MINCONN.key, connectionPoolPanel.minConnection);
                        params.put(MAXCONN.key, connectionPoolPanel.maxConnection);
                        params.put(FETCHSIZE.key, connectionPoolPanel.fetchSize);
                        params.put(MAXWAIT.key, connectionPoolPanel.timeout);
                        params.put(VALIDATECONN.key, connectionPoolPanel.validate);

                    }
                    if(otherParamsPanel.userSchema) {
                        params.put(JDBCDataStoreFactory.SCHEMA.key, ((String) params.get(USER.key)).toUpperCase());
                    } else { 
                        params.put(JDBCDataStoreFactory.SCHEMA.key, otherParamsPanel.schema);
                    }
                    params.put(NAMESPACE.key, new URI(namespace.getURI()).toString());
                    params.put(LOOSEBBOX.key, otherParamsPanel.looseBBox);
                    params.put(PK_METADATA_TABLE.key, otherParamsPanel.pkMetadata);

                    // ok, check we can connect
                    DataAccess store = null;
                    try {
                        store = DataAccessFinder.getDataStore(params);
                        // force the store to open a connection
                        store.getNames();
                        store.dispose();
                    } catch (Throwable e) {
                        LOGGER.log(Level.INFO, "Could not connect to the datastore", e);
                        error(new ParamResourceModel("ImporterError.databaseConnectionError",
                                OraclePage.this, e.getMessage()).getString());
                        return;
                    } finally {
                        if(store != null)
                            store.dispose();
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
                    pp.put("skipGeometryless", otherParamsPanel.excludeGeometryless);
                    setResponsePage(VectorLayerChooserPage.class, pp);
                } catch (Exception e) {
                    LOGGER.log(Level.SEVERE, "Error while setting up mass import", e);
                }

            }
        };
    }

}
