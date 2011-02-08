package org.opengeo.analytics.web;

import static org.opengeo.analytics.web.Analytics.monitor;

import java.util.Arrays;
import java.util.List;

import org.apache.wicket.Component;
import org.apache.wicket.markup.html.IHeaderContributor;
import org.apache.wicket.markup.html.IHeaderResponse;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.link.ExternalLink;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.IModel;
import org.geoserver.monitor.Query;
import org.geoserver.web.wicket.GeoServerDataProvider;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.opengeo.analytics.RequestOriginSummary;
import org.opengeo.analytics.command.CommonOriginCommand;

import freemarker.template.SimpleHash;

public class LocationPanel extends Panel {

    public LocationPanel(String id) {
        super(id);
        
        add(new MapPanel("map"));
        add(new ExternalLink("kml", "../wms/kml?layers=analytics:requests_agg"));
        //add(new ExternalLink("pdf", "../wms/reflect?layers=analytics:requests_agg&format=pdf"));
        
        CommonOriginTable table = 
            new CommonOriginTable("commonOrigin", new CommonOriginProvider());
        table.setPageable(false);
        table.setFilterable(false);
        add(table);
        
    }

    static class MapPanel extends Panel implements IHeaderContributor {

        public MapPanel(String id) {
            super(id);
            setOutputMarkupId(true);
        }

        public void renderHead(IHeaderResponse response) {
            try {
                //render css
                SimpleHash model = new SimpleHash();
                model.put("markupId", getMarkupId());
                response.renderString( Analytics.renderTemplate(model, "location-ol-css.ftl"));
                
                //TODO: point back to GeoServer
                response.renderJavascriptReference("http://openlayers.org/api/OpenLayers.js");  
                response.renderOnLoadJavascript(
                    Analytics.renderTemplate(model, "location-ol-onload.ftl"));
            }
            catch( Exception e ) {
                throw new RuntimeException(e);
            }
        }
    }
    
    static class CommonOriginProvider extends GeoServerDataProvider<RequestOriginSummary> {

        public static Property<RequestOriginSummary> REQUESTS = 
            new BeanProperty<RequestOriginSummary>("requests", "count");
        
        public static Property<RequestOriginSummary> PERCENT = 
            new BeanProperty<RequestOriginSummary>("percent", "percent");
        
        public static Property<RequestOriginSummary> ORIGIN = 
            new AbstractProperty<RequestOriginSummary>("origin") {

            public Object getPropertyValue(RequestOriginSummary item) {
                return item.getHost() + " (" + item.getIP() + ")"; 
            }
            
        };
        
        
        public static Property<RequestOriginSummary> LOCATION = 
            new AbstractProperty<RequestOriginSummary>("location") {
         
            public Object getPropertyValue(RequestOriginSummary item) {
                return item.getCity() != null ? item.getCity() + ", " + item.getCountry() : "";
            }
        };
        @Override
        protected List<Property<RequestOriginSummary>> getProperties() {
            return Arrays.asList(ORIGIN, LOCATION, REQUESTS, PERCENT);
        }

        @Override
        protected List<RequestOriginSummary> getItems() {
            return new CommonOriginCommand(new Query(), monitor(), 5).execute();
        }
    }
    
    static class CommonOriginTable extends GeoServerTablePanel<RequestOriginSummary> {

        public CommonOriginTable(String id, CommonOriginProvider dataProvider) {
            super(id, dataProvider);
        }

        @Override
        protected Component getComponentForProperty(String id, IModel itemModel,
                Property<RequestOriginSummary> property) {
            
            return new Label(id, property.getModel(itemModel));
        }
        
    }
}
