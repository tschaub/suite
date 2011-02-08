package org.geoserver.uploader;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.config.util.XStreamPersister;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geotools.util.logging.Logging;

import com.thoughtworks.xstream.XStream;

public class UploaderConfigPersister {

    private static final Logger LOGGER = Logging.getLogger(UploaderConfigPersister.class);

    static final String UPLOADER_CONFIG_FILE_NAME = "uploader.xml";

    private GeoServerResourceLoader resourceLoader;

    private UploaderConfig config;

    private Catalog catalog;

    public UploaderConfigPersister(Catalog catalog, GeoServerResourceLoader resourceLoader) {
        this.catalog = catalog;
        this.resourceLoader = resourceLoader;
        try {
            this.config = loadConfig();
        } catch (IOException e) {
            LOGGER.log(Level.WARNING, "Error loading uploader config from "
                    + UPLOADER_CONFIG_FILE_NAME + ". Using GeoServer's defaults", e);
        }
        if (config == null) {
            config = new UploaderConfig(catalog);
        }
        // if (config.getDefaultWorkspace() == null) {
        // config.setDefaultWorkspace(catalog.getDefaultWorkspace().getName());
        // config.setDefaultDataStore(catalog.getDefaultDataStore(catalog.getDefaultWorkspace())
        // .getName());
        // try {
        // saveConfig();
        // } catch (IOException e) {
        // e.printStackTrace();
        // }
        // }
    }

    public UploaderConfig getConfig() {
        return new UploaderConfig(config);
    }

    public void setDefaults(WorkspaceInfo ws, DataStoreInfo ds) {
        config.setDefaultWorkspace(ws == null ? null : ws.getName());
        config.setDefaultDataStore(ds == null ? null : ds.getName());
        try {
            saveConfig();
        } catch (IOException e) {
            throw new RuntimeException(
                    "Error persisting uploader configuration: " + e.getMessage(), e);
        }
    }

    private UploaderConfig loadConfig() throws IOException {
        UploaderConfig config = null;
        File file = resourceLoader.find(UPLOADER_CONFIG_FILE_NAME);
        if (null == file) {
            return null;
        }
        Persister persister = new Persister();
        InputStream in = new FileInputStream(file);
        try {
            config = persister.load(in, UploaderConfig.class);
            config.setCatalog(catalog);
        } finally {
            in.close();
        }

        return config;
    }

    private void saveConfig() throws IOException {
        File file = resourceLoader.createFile(UPLOADER_CONFIG_FILE_NAME);
        OutputStream out = new FileOutputStream(file);
        Persister persister = new Persister();
        persister.save(config, out);
    }

    private static class Persister extends XStreamPersister {
        public Persister() {
            super();
        }

        @Override
        protected void init(XStream xs) {
            super.init(xs);
            xs.alias("UploaderConfig", UploaderConfig.class);
        }
    }
}
