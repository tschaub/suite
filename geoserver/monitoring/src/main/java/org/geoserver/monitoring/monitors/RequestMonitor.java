package org.geoserver.monitoring.monitors;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class RequestMonitor {
    
    /**
     * Thread local variable for the request statistics, meant to be set when running on the Thread
     * where the Dispatcher inits the request handling
     */
    private static final ThreadLocal<RequestStats> STATS = new ThreadLocal<RequestStats>();

    private static final int MAX_REQUEST_POOL = 1000;

    private static final RequestMonitor INSTANCE = new RequestMonitor();

    private LinkedList<RequestStats> requests = new LinkedList<RequestStats>();
    
    public static ThreadLocal<RequestStats> getThreadRequestStats() {
        return STATS;
    }

    public static RequestMonitor getInstance() {
        return INSTANCE;
    }

    /**
     * Registers a request as being processed
     * 
     * @param reqStats
     */
    public void add(RequestStats reqStats) {
        synchronized (requests) {
            if (requests.size() == MAX_REQUEST_POOL) {
                // remove older
                requests.removeLast();
            }
            requests.addFirst(reqStats);
        }
    }

    public List<RequestStats> getLastNRequests(final int requestCount) {
        synchronized (requests) {
            final int howMany = Math.min(requestCount, requests.size());
            List<RequestStats> retVal = new ArrayList<RequestStats>(howMany);
            retVal.addAll(requests.subList(0, howMany));
            return retVal;
        }
    }
}
