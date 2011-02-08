package org.opengeo.analytics.web;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import org.apache.wicket.WicketRuntimeException;
import org.apache.wicket.markup.html.link.ExternalLink;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.web.MonitorBasePage;
import static org.geoserver.monitor.rest.RequestResource.toQueryString;

public class RequestsPage extends MonitorBasePage {

    public RequestsPage(Query query) {
        this(new RequestDataProvider(query));
    }
    
    public RequestsPage(RequestDataProvider provider) {
        RequestDataTablePanel table = new RequestDataTablePanel("table", provider);
        table.setPageable(true);
        table.setItemsPerPage(25);
        table.setFilterable(false);
        add(table);
        
        ExternalLink csvLink = new ExternalLink("csv", 
                "../rest/monitor/requests.csv" + toQueryString(provider.getQuery()));;
        add(csvLink);
        
        ExternalLink excelLink = new ExternalLink("excel", 
                "../rest/monitor/requests.xls" + toQueryString(provider.getQuery()));;
        add(excelLink);
      
    }
}
