package org.opengeo.jetty;

import java.io.File;

import org.ini4j.Wini;

/**
 * Wrapper around Jetty main which reads the configuration file prior to starting jetty.
 * 
 * @author Justin Deoliveira, OpenGeo
 *
 */
public class Start {

    public static void main(String[] args) throws Exception {
        
        Wini ini = null;
        File f = new File(
            System.getProperty("user.home")+File.separator+".opengeo"+File.separator+"config.ini");
        
        if (f.exists()) {
            ini = new Wini(f);
        }
        else {
            ini = new Wini();
            System.out.println(f.getAbsolutePath() + " not found, continuing with default parameters.");
        }
        
        String startPort = ini.get("suite", "port");
        if (startPort == null) {
            startPort = ini.get("?", "port");
        }
        if (startPort != null) {
            System.setProperty("jetty.port", startPort);
        }
        
        String stopPort = ini.get("suite", "stop_port");
        if (stopPort == null) {
            stopPort = ini.get("?", "stop_port");
        }
        if (stopPort == null) {
            stopPort = "8079";
        }
        System.setProperty("STOP.PORT", stopPort);
        System.setProperty("STOP.KEY", "opengeo");
        
        String gsDataDirectory = ini.get("geoserver", "data_dir" );
        if (gsDataDirectory == null) {
            File dd = new File("data_dir");
            if (dd.exists()) {
                gsDataDirectory = dd.getCanonicalPath();
            }
        }
        if (gsDataDirectory != null) {
            System.setProperty("GEOSERVER_DATA_DIR", gsDataDirectory);    
        }
        
        System.setProperty("RELINQUISH_LOG4J_CONTROL", "true");
        
        org.mortbay.start.Main.main(args);
    }
}
