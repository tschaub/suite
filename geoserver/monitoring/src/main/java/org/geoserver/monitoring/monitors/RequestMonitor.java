package org.geoserver.monitoring.monitors;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentLinkedQueue;
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
    
    Queue<RequestStats> liveRequests = new ConcurrentLinkedQueue<RequestStats>();
    
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
        RequestStats rs = new RequestStats();
        // TODO: initialize the request id from the last id in the database
        rs.setRequestId(REQ_ID_GEN.incrementAndGet());
        STATS.set(rs);
        liveRequests.add(rs);
        return rs;
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
        // TODO: here we have to launch the threads that process the request like DNS reverse lookup and some such,
        // and the following operations should be done when the last of those threads is done processing
        dao.add(rs);
        liveRequests.remove(rs);
        return rs;
    }

    public List<RequestStats> getPagedRequests(Date from, Date to, int start, int pageSize) {
        // keep only the elements in the live requests that are between from and to and are 
        // in the current page considering the elements of the live requests are the first
        // one we'd return if everything was on the database
        List<RequestStats> result = getLiveRequestsBetween(from, to);
        if(start > result.size()) {
            // none of the requests we're looking for is in memory
            return dao.getPagedRequests(from, to, start, pageSize);
        } 

        // at least one in memory
        Collections.reverse(result);
        if(start + pageSize <= result.size()) {
            // they are all in memory
            return result.subList(start, start + pageSize);
        } else {
            // part in memory, part in the database
            result.addAll(dao.getPagedRequests(from, to, start - result.size(), pageSize - result.size()));
            return result;
        }
    }
    
    public long getRequetsCount(Date from, Date to) {
        // keep only the elements in the live requests that are between from and to and are 
        // in the current page considering the elements of the live requests are the first
        // one we'd return if everything was on the database
        List<RequestStats> result = getLiveRequestsBetween(from, to);
        return result.size() + dao.getRequestsCount(from, to);
    }
    
    /**
     * Returns the live requests contained in the specified time range
     * @param from the beginning, or null if no minimum
     * @param to the end, of null if no maximum
     * @return
     */
    private List<RequestStats> getLiveRequestsBetween(Date from, Date to) {
        List<RequestStats> result = new ArrayList<RequestStats>(liveRequests);
        for (Iterator<RequestStats> it = result.iterator(); it.hasNext();) {
            RequestStats rs = it.next();
            if((from != null && from.compareTo(rs.getStartTime()) > 0) &&
               (to != null && rs.getStartTime().compareTo(to) > 0)) {
                it.remove();
            }
        }
        
        return result;
    }
}
