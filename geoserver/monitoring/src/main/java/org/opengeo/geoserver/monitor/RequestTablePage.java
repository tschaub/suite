package org.opengeo.geoserver.monitor;

import org.geoserver.monitor.Query;
import org.geoserver.web.GeoServerSecuredPage;

public class RequestTablePage extends GeoServerSecuredPage {

    public RequestTablePage(Query q) {
        add(new RequestTablePanel("table", new RequestDataProvider(q)));
    }
}
