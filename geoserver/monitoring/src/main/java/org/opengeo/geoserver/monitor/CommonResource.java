package org.opengeo.geoserver.monitor;

import java.io.Serializable;
import java.util.LinkedHashMap;


public class CommonResource implements Comparable<CommonResource>, Serializable {

    String resource;
    LinkedHashMap<String, Long> operations = new LinkedHashMap<String, Long>();
    
    public CommonResource(String resource) {
        this.resource = resource;
    }
    
    public String getResource() {
        return resource;
    }
    
    public LinkedHashMap<String, Long> getOperations() {
        return operations;
    }
    
    public Long getRequests() {
        long requests = 0;
        for (Long i : operations.values()) {
            requests += i;
        }
        return requests;
    }

    public int compareTo(CommonResource o) {
        return -1*getRequests().compareTo(o.getRequests());
    }
}
