package org.opengeo.geoserver.monitor;

import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.apache.wicket.PageParameters;
import org.apache.wicket.extensions.markup.html.tabs.AbstractTab;
import org.apache.wicket.extensions.markup.html.tabs.ITab;
import org.apache.wicket.extensions.markup.html.tabs.TabbedPanel;
import org.apache.wicket.markup.html.WebMarkupContainer;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.TextArea;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.markup.repeater.RepeatingView;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.model.ResourceModel;
import org.geoserver.monitor.Monitor;
import org.geoserver.monitor.RequestData;
import org.geoserver.monitor.RequestData.Category;
import org.geoserver.web.GeoServerApplication;
import org.geoserver.web.GeoServerSecuredPage;
import org.geoserver.web.wicket.OpenLayersMapPanel;
import org.geoserver.web.wicket.OpenLayersMapPanel.Layer;
import org.geoserver.web.wicket.OpenLayersMapPanel.LayerType;

public class RequestDetailsPage extends GeoServerSecuredPage {

    RequestData request;
    
    public RequestDetailsPage(PageParameters params) {
        this(params.getAsLong("id", -1l));
    }
    
    public RequestDetailsPage(long id) {
        this(GeoServerApplication.get().getBeanOfType(Monitor.class).getDAO().getRequest(id));
    }
    
    public RequestDetailsPage(final RequestData request) {
        this.request = request;
        
        add(new Label("id", new PropertyModel<RequestData>(request, "id")));
        add(new Label("httpMethod", new PropertyModel<RequestData>(request, "httpMethod")));
        add(new Label("path", new PropertyModel<RequestData>(request, "path")));
        add(new Label("status", new PropertyModel<RequestData>(request, "status")));
        add(new Label("totalTime", new PropertyModel<RequestData>(request, "totalTime")));
    
        List<ITab> tabs = new ArrayList();
        if (request.getQueryString() != null) {
            tabs.add(new AbstractTab(new ResourceModel("queryString")) {
                @Override
                public Panel getPanel(String panelId) {
                    return new QueryStringPanel(panelId, request);
                }
            });    
        }
        
        if (request.getBody() != null) {
            tabs.add(new AbstractTab(new ResourceModel("body")) {
                @Override
                public Panel getPanel(String panelId) {
                    return new BodyPanel(panelId, request);
                }
            });
        }
        
        if (request.getCategory() == Category.OWS) {
            tabs.add(new AbstractTab(new ResourceModel("ows")) {
                @Override
                public Panel getPanel(String panelId) {
                    return new OWSPanel(panelId, request);
                }
            });
        }
        
        if (request.getError() != null) {
            tabs.add(new AbstractTab(new ResourceModel("error")) {
                @Override
                public Panel getPanel(String panelId) {
                    return new ErrorPanel(panelId, request);
                }
            });
        }
        tabs.add(new AbstractTab(new ResourceModel("origin")) {
            @Override
            public Panel getPanel(String panelId) {
                return new OriginPanel(panelId, request);
            }
        });
      
        add(new TabbedPanel("details", tabs));
    }
    
    class OriginPanel extends Panel {

        public OriginPanel(String id, RequestData data) {
            super(id);
        
            add(new Label("ip", new PropertyModel<RequestData>(data, "remoteAddr")));
            add(new Label("host", new PropertyModel<RequestData>(data, "remoteHost")));
            //add(new Label("user", new PropertyModel<RequestData>(data, "remoteUser")));
            add(new Label("lat", new PropertyModel<RequestData>(data, "remoteLat")));
            add(new Label("lon", new PropertyModel<RequestData>(data, "remoteLon")));
            add(new Label("country", new PropertyModel<RequestData>(data, "remoteCountry")));
            add(new Label("city", new PropertyModel<RequestData>(data, "remoteCity")));
            
            OpenLayersMapPanel mapPanel = new OpenLayersMapPanel("map");
            mapPanel.add(getCatalog().getLayerByName("monitor:monitor_world"));
            
            Layer l = mapPanel.add(getCatalog().getLayerByName("monitor:monitor_requests")); 
            l.getParams().put("cql_filter", "request_id = '" + data.getId() + "'");
            l.getParams().put("transparent", "true");
            l.setBaseLayer(false);
            
                
            add(mapPanel);
        }
        
    }
    
    class QueryStringPanel extends Panel {

        public QueryStringPanel(String id, RequestData data) {
            super(id);
            
            RepeatingView paramView = new RepeatingView("params");
            add(paramView);
            
            String queryString = data.getQueryString();
            if (queryString != null) {
                String[] kvps = queryString.split("&");
                for (String kvp : kvps) {
                    String[] split = kvp.split("=");
                    
                    WebMarkupContainer param = new WebMarkupContainer(paramView.newChildId());
                    param.add(new Label("key", split[0]));
                    param.add(new Label("value", split.length > 1 ? split[1] : ""));
                    
                    paramView.add(param);
                }
            }
        }
        
    }
    
    class BodyPanel extends Panel {

        public BodyPanel(String id, RequestData data) {
            super(id);
            
            add(new Label("contentType", new PropertyModel<RequestData>(data, "bodyContentType")));
            add(new Label("contentLength", new PropertyModel<RequestData>(data, "bodyContentLength")));
            add(new TextArea<RequestData>("body", new Model(handleBodyContent(data))));
        }
        
        String handleBodyContent(RequestData request) {
            byte[] bytes = request.getBody();
            try {
                return new String(bytes, "UTF-8");
            } 
            catch (UnsupportedEncodingException e) {
                throw new RuntimeException(e);
            }
        }
    }
    
    class OWSPanel extends Panel {
        public OWSPanel(String id, RequestData data) {
            super(id);
            
            add(new Label("service", new PropertyModel<RequestData>(data, "service")));
            add(new Label("operation", new PropertyModel<RequestData>(data, "operation")));
            add(new Label("version", new PropertyModel<RequestData>(data, "owsVersion")));
        }
    }
    
    class ResponsePanel extends Panel {

        public ResponsePanel(String id, RequestData data) {
            super(id);
        }
        
    }
    
    class ErrorPanel extends Panel {

        public ErrorPanel(String id, RequestData data) {
            super(id);
            
            add(new Label("message", new PropertyModel(data, "errorMessage")));
            add(new TextArea("stackTrace", new Model(handleStackTrace(data))));
        }

        String handleStackTrace(RequestData data) {
            ByteArrayOutputStream out = new ByteArrayOutputStream();
            PrintWriter writer = new PrintWriter(out);
            data.getError().printStackTrace(writer);
            writer.flush();
            
            return new String(out.toByteArray());
        }
    }
}
