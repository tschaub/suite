package org.opengeo.geoserver.monitor;

import java.util.ArrayList;
import java.util.List;

import org.apache.wicket.extensions.markup.html.tabs.AbstractTab;
import org.apache.wicket.extensions.markup.html.tabs.ITab;
import org.apache.wicket.extensions.markup.html.tabs.TabbedPanel;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.ResourceModel;
import org.geoserver.monitor.web.MonitorBasePage;

public class MonitorPage extends MonitorBasePage {

    public MonitorPage() {
        List<ITab> tabs = new ArrayList();
        tabs.add(new AbstractTab(new ResourceModel("summary")) {
            @Override
            public Panel getPanel(String panelId) {
                return new SummaryPanel(panelId);
            }
        });
        tabs.add(new AbstractTab(new ResourceModel("requests")) {
            @Override
            public Panel getPanel(String panelId) {
                return new RequestPanel(panelId);
            }
        });
        tabs.add(new AbstractTab(new ResourceModel("locations")) {
            @Override
            public Panel getPanel(String panelId) {
                return new LocationPanel(panelId);
            }
        });
        
        add(new TabbedPanel("tabs", tabs));
    }
}
