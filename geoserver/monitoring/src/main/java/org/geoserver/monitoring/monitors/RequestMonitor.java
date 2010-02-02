package org.geoserver.monitoring.monitors;

import java.net.InetAddress;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.geoserver.monitoring.callbacks.MonitoringCallback;
import org.geotools.util.logging.Logging;

public class RequestMonitor {
    
    static final Logger LOGGER = Logging.getLogger(MonitoringCallback.class);
    
    /**
     * Thread local variable for the request statistics, meant to be set when running on the Thread
     * where the Dispatcher inits the request handling
     */
    private static final ThreadLocal<RequestStats> STATS = new ThreadLocal<RequestStats>();
    
    /**
     * A very simple unique id generator for {@link RequestStats} objects
     */
    private static final AtomicLong REQ_ID_GEN = new AtomicLong();

    RequestMonitorDAO dao;
    
    Map<Long, RequestStats> liveRequests = new ConcurrentHashMap<Long, RequestStats>();
    
    String host;
    
    public RequestMonitor(RequestMonitorDAO dao) {
        this.dao = dao;
        
        try { 
            InetAddress addr = InetAddress.getLocalHost(); 
            host = addr.getHostName(); 
        } catch (Throwable t) { 
            LOGGER.log(Level.SEVERE, "Could not get host name of the server", t);
        } 
    }

    /**
     * Builds a new {@link RequestStats}, sets its identifier, the server host, binds it
     * to the thread and returns it. The same request can be retrieved from the originating thread by calling 
     * {@link #getThreadRequestStats()}
     * 
     * @param reqStats
     */
    public RequestStats newRequestStats() {
        RequestStats reqStats = new RequestStats();
        reqStats.setRequestId(REQ_ID_GEN.incrementAndGet());
        STATS.set(reqStats);
        return reqStats;
    }
    
    /**
     * Returns the {@link RequestStats} currently bound to this thread
     * @return the {@link RequestStats} bound to this thread, or null if there is none
     */
    public RequestStats getCurrentRequestStats() {
        return STATS.get();
    }
    
    /**
     * Stores the {@link RequestStats} bound to the current thread and cleans up the thread local
     */
    public RequestStats requestCompleted() {
        RequestStats rs = STATS.get();
        STATS.remove();
        dao.add(rs);
        return rs;
    }

    public List<RequestStats> getLastNRequests(final int requestCount) {
        return dao.getPagedRequests(0, requestCount);
    }
}
