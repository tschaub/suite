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
        
        File f = new File(
            System.getProperty("user.home")+File.separator+".opengeo"+File.separator+"config.ini");
        if (f.exists()) {
            Wini ini = new Wini(f);
            
            String startPort = ini.get("?", "port");
            if (startPort != null) {
                System.setProperty("jetty.port", startPort);
            }
            
            String stopPort = ini.get("?", "stop_port");
            if (stopPort != null) {
                System.setProperty("STOP.PORT", stopPort);
            }
        }
        else {
            System.out.println(f.getAbsolutePath() + " not found, starting with default parameters.");
        }
        
        if (System.getProperty("STOP.PORT") == null) {
            System.setProperty("STOP.PORT", "8079");
        }
        System.setProperty("STOP.KEY", "opengeo");
        org.mortbay.start.Main.main(args);
    }
}
