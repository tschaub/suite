package org.geoserver.monitoring.monitors.hb;

import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.commons.dbcp.BasicDataSource;
import org.geoserver.config.GeoServerDataDirectory;

public class MonitoringDataSource extends BasicDataSource {

    GeoServerDataDirectory dataDirectory;

    public void setDataDirectory(GeoServerDataDirectory dataDir) {
        this.dataDirectory = dataDir;
    }

    @Override
    public Connection getConnection() throws SQLException {
        if(getDriverClassName() == null) {
            try {
                File monitoringDir = dataDirectory.findOrCreateDataDir("monitoring");
                setDriverClassName("org.h2.Driver");
                setUrl("jdbc:h2:file:" + monitoringDir.getAbsolutePath() + "/monitoring");
                setMinIdle(1);
                setMaxActive(4);
            } catch (Exception e) {
                throw new RuntimeException("Unexpected error setting up the monitoring H2 database", e);
            }
        }
        return super.getConnection();
    }
}
