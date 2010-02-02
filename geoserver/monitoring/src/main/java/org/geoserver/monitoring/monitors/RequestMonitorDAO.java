package org.geoserver.monitoring.monitors;

import java.util.Date;
import java.util.List;

public interface RequestMonitorDAO {

   /**
    * Saves a request
    * 
    * @param reqStats
    */
   public void add(RequestStats reqStats);
   
   /**
    * Requests a page of requests from the persistent store between the specified dates
    * @param from The from date, or null if no from is needed
    * @param to The to date, or null if no "to" is needed
    * @param start The index of the first item in the page
    * @param pageSize The numbef of items in the page
    * @return
    */
   public List<RequestStats> getPagedRequests(Date from, Date to, int start, int pageSize);

   /**
    * Returns the number of requests available in the database between the specified dates
    * @param from
    * @param to
    * @return
    */
   public long getRequestsCount(Date from, Date to);
}
