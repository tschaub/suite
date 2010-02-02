package org.geoserver.monitoring.monitors;

import java.util.List;

public interface RequestMonitorDAO {

   /**
    * Saves a request
    * 
    * @param reqStats
    */
   public void add(RequestStats reqStats);
   
   /**
    * Requests a page of requests from the persistent store
    * @param start
    * @param pageSize
    * @return
    */
   public List<RequestStats> getPagedRequests(int start, int pageSize);
}
