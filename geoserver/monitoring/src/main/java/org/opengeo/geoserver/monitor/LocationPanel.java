package org.opengeo.geoserver.monitor;

import org.apache.wicket.markup.html.panel.Panel;
import org.geoserver.web.GeoServerApplication;
import org.geoserver.web.wicket.OpenLayersMapPanel;

public class LocationPanel extends Panel {

    public LocationPanel(String id) {
        super(id);
        
        OpenLayersMapPanel mapPanel = new OpenLayersMapPanel("map");
        mapPanel.add(GeoServerApplication.get().getCatalog().getLayerGroupByName("requests"));
    
        add(mapPanel);
    }

}
