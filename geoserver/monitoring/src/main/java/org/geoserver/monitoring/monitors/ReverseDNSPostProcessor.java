package org.geoserver.monitoring.monitors;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Map;
import java.util.concurrent.BlockingQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.geotools.util.SoftValueHashMap;
import org.geotools.util.logging.Logging;

public class ReverseDNSPostProcessor implements Runnable {
    static final Logger LOGGER = Logging.getLogger(ReverseDNSPostProcessor.class);
    
    BlockingQueue<RequestStats> inputQueue;
    BlockingQueue<RequestStats> outputQueue;
    
    Map<String, String> reverseLookupCache = new SoftValueHashMap<String, String>(100);

    public void setInputQueue(BlockingQueue<RequestStats> inputQueue) {
        this.inputQueue = inputQueue;
    }
    
    public void setOutputQueue(BlockingQueue<RequestStats> outputQueue) {
        this.outputQueue = outputQueue;
    }

    public void run() {
        while(true) {
            RequestStats rs;
            try {
                rs = inputQueue.take();
            } catch(InterruptedException e) {
                continue;
            }
            
            // kill thread by poison token
            if(rs == null)
                return;

            String host = reverseLookupCache.get(rs.getRemoteAddr());
            if(host == null) {
                try {
                    InetAddress addr = InetAddress.getByName(rs.getRemoteAddr());
                    host = addr.getHostName();
                } catch(UnknownHostException e) {
                    LOGGER.log(Level.FINE, "Error reverse looking up " + rs.getRemoteAddr(), e);
                }
            }
            
            rs.setRemoteHost(host);
            
            while(true) {
                try {
                    outputQueue.put(rs);
                    break;
                } catch(InterruptedException e) {
                    // I do really want to put the rs in the next queue!
                }
            }
            
        }
    }

}
