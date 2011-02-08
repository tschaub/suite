package org.opengeo.geoserver.monitor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.geoserver.monitor.Monitor;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.Query.Comparison;
import org.geoserver.monitor.Query.SortOrder;
import org.geoserver.monitor.RequestData;
import org.geoserver.monitor.RequestDataVisitor;
import org.geoserver.web.GeoServerApplication;
import org.geoserver.web.wicket.GeoServerDataProvider;
import org.geoserver.web.wicket.GeoServerDataProvider.AbstractProperty;
import org.geoserver.web.wicket.GeoServerDataProvider.BeanProperty;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;
import org.opengeo.geoserver.monitor.RequestPanel.LayerAccess;

public class CommonResourceProvider extends GeoServerDataProvider<CommonResource> {
    
    public static Property<CommonResource> REQUESTS = 
        new BeanProperty<CommonResource>("requests", "requests");
    
    public static Property<CommonResource> RESOURCE = 
        new BeanProperty<CommonResource>("resource", "resource");
    
    public static Property<CommonResource> OPERATIONS = 
        new BeanProperty<CommonResource>("operations", "operations");
        
//    @SuppressWarnings("unchecked")
//    public Property<LayerData> TYPE = new AbstractProperty("type") {
//        public Object getPropertyValue(Object item) {
//            LayerData l = (LayerData) item;
//            final List<LayerAccess> accesses = new ArrayList();
//            MonitorQuery q = new MonitorQuery().properties("owsService", "owsOperation")
//                .aggregate("count()").filter(l.getName(), "layerNames", Comparison.IN)
//                .group("owsService", "owsOperation").sort("count()", SortOrder.DESC);
//            filterQuery(q);
//            
//            getMonitor().query(q, new RequestDataVisitor() {
//                public void visit(RequestData data, Object... aggregates) {
//                    long count = ((Number)aggregates[0]).longValue();
//                    accesses.add(new LayerAccess(count, data));
//                }
//            });
//            
//            return accesses;
//        }
//    };
     
    @Override
    protected List<Property<CommonResource>> getProperties() {
        return Arrays.asList(REQUESTS, RESOURCE, OPERATIONS);
    }

    @Override
    protected List<CommonResource> getItems() {
        Monitor m = getMonitor();
        
        Query q = new Query().properties("resource").aggregate("count()")
            .filter("resource", null, Comparison.NEQ).group("resource")
            .sort("count()", SortOrder.DESC).page(0l, 5l);
        filterQuery(q);
        
        final List<String> resources = new ArrayList();
        m.query(q, new RequestDataVisitor() {
            public void visit(RequestData data, Object... aggregates) {
                resources.add(data.getResources().get(0));
            }
        });
        
        q = new Query().properties("resource", "operation").aggregate("count()")
            .filter("resource", resources, Comparison.IN).group("resource", "operation")
            .sort("count()", SortOrder.DESC);
        filterQuery(q);
        
        final Map<String,CommonResource> commonResources = new HashMap();
        m.query(q, new RequestDataVisitor() {
            public void visit(RequestData data, Object... aggregates) {
                String resource = data.getResources().get(0);
                CommonResource commonResource = commonResources.get(resource);
                if (commonResource == null) {
                    commonResource = new CommonResource(resource);
                    commonResources.put(resource, commonResource);
                }
                
                long count = ((Number)aggregates[0]).longValue();
                commonResource.getOperations().put(data.getOperation(), count);
            }
        });
        
        List<CommonResource> list = new ArrayList(commonResources.values());
        Collections.sort(list);
        return list;
    }
    
    Monitor getMonitor() {
        return GeoServerApplication.get().getBeanOfType(Monitor.class);
    }

    protected void filterQuery(Query query) {
    }
}
