package org.opengeo.geoserver.monitor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.wicket.Component;
import org.apache.wicket.ajax.AjaxSelfUpdatingTimerBehavior;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.util.time.Duration;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.Query.Comparison;
import org.geoserver.monitor.Query.SortOrder;
import org.geoserver.monitor.RequestData.Status;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;

public class SummaryPanel extends Panel {

    public SummaryPanel(String id) {
        super(id);
        
        initComponents();
    }

    void initComponents() {
        RequestDataProvider recentRequestProvider = new RequestDataProvider(new Query()
            .properties("id", "status", "path").page(0l, 5l).sort("startTime", SortOrder.DESC), 
            Arrays.asList(RequestDataProvider.ID, RequestDataProvider.STATUS, RequestDataProvider.PATH));
//        RequestDataProvider recentRequestProvider = new RequestDataProvider(new Query()
//        .properties("id", "status", "path").sort("startTime", SortOrder.DESC), 
//        Arrays.asList(RequestDataProvider.ID, RequestDataProvider.STATUS, RequestDataProvider.PATH));
        
        RequestTablePanel recentRequestPanel = 
            new RequestTablePanel("recentActivity", recentRequestProvider); 
        recentRequestPanel.setFilterable(false);
        recentRequestPanel.setPageable(false);
        add(recentRequestPanel);
        
        recentRequestPanel.add(new AjaxSelfUpdatingTimerBehavior(Duration.seconds(5)));
    
        CommonResourceProvider commonResourceProvider = new CommonResourceProvider() {};
        GeoServerTablePanel<CommonResource> panel = 
            new GeoServerTablePanel<CommonResource>("commonResources", commonResourceProvider) {
            @Override
            protected Component getComponentForProperty(String id, IModel itemModel,
                    Property<CommonResource> property) {
                
                if (property == CommonResourceProvider.OPERATIONS) {
                    CommonResource resource = (CommonResource) itemModel.getObject();
                    return new CommonResourceLinkPanel(id, resource);
                }
                else {
                    return new Label(id, property.getModel(itemModel));
                }
            }
        };
        panel.setFilterable(false);
        panel.setPageable(false);
        add(panel);
        
        RequestDataProvider failedRequestProvider =  new RequestDataProvider(new Query()
        .properties("id", "status", "path").sort("startTime", SortOrder.DESC).filter("status", Status.FAILED, Comparison.EQ), 
        Arrays.asList(RequestDataProvider.ID, RequestDataProvider.STATUS, RequestDataProvider.PATH));
     
        RequestTablePanel failedRequestPanel = 
            new RequestTablePanel("failedRequests", failedRequestProvider); 
        failedRequestPanel.setFilterable(false);
        failedRequestPanel.setPageable(true);
        failedRequestPanel.setItemsPerPage(5);
        add(failedRequestPanel);
    }

    class CommonResourceLinkPanel extends Panel {

        public CommonResourceLinkPanel(String id, final CommonResource resource) {
            super(id);
            
            List<Map.Entry<String,Long>> summary = 
                new ArrayList(resource.getOperations().entrySet());
            
            ListView<Map.Entry<String,Long>> list = new ListView<Map.Entry<String,Long>>("links", summary) {
                @Override
                protected void populateItem(ListItem<Entry<String, Long>> item) {
                    Map.Entry<String, Long> map = item.getModelObject();
                    final String op = map.getKey();
                    final Long count = map.getValue();
                    
                    Link link = new Link("link") {
                        @Override
                        public void onClick() {
                            Query q = new Query();
                            q.filter(resource.getResource(), "resources", Comparison.IN);
                            q.filter("operation", op, Comparison.EQ);
                            
                            setResponsePage(new RequestTablePage(q));
                        }
                    };
                    item.add(link);
                    
                    String title = count + " " + op;
                    link.add(new Label("linkTitle", title));
                }
            };
            add(list);
        }
    }
}
