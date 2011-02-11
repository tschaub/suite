package org.opengeo.analytics.web;

import java.util.ArrayList;
import java.util.List;

import org.apache.wicket.extensions.markup.html.tabs.AbstractTab;
import org.apache.wicket.extensions.markup.html.tabs.ITab;
import org.apache.wicket.extensions.markup.html.tabs.TabbedPanel;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.ResourceModel;
import org.geoserver.monitor.Monitor;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.web.MonitorBasePage;
import org.geoserver.web.GeoServerApplication;

public class AnalyticsHomePage extends MonitorBasePage {

    Query query;
    
    public AnalyticsHomePage() {
        query = new Query();
        
        List<ITab> tabs = new ArrayList();
        tabs.add(new AbstractTab(new ResourceModel("summary")) {
            @Override
            public Panel getPanel(String panelId) {
                return new SummaryPanel(panelId, query);
            }
        });
//        tabs.add(new AbstractTab(new ResourceModel("requests")) {
//            @Override
//            public Panel getPanel(String panelId) {
//                return new RequestPanel(panelId);
//            }
//        });
        tabs.add(new AbstractTab(new ResourceModel("locations")) {
            @Override
            public Panel getPanel(String panelId) {
                return new LocationPanel(panelId);
            }
        });
        
        tabs.add(new AbstractTab(new ResourceModel("performance")) {
            @Override
            public Panel getPanel(String panelId) {
                return new PerformancePanel(panelId, query);
            }
        });
        
        add(new TabbedPanel("tabs", tabs));
    }
}
