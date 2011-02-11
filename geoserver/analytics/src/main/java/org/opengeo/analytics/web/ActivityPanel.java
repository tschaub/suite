package org.opengeo.analytics.web;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.wicket.Component;
import org.apache.wicket.ajax.AjaxEventBehavior;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.ajax.markup.html.form.AjaxCheckBox;
import org.apache.wicket.behavior.AttributeAppender;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.yui.calendar.DateTimeField;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.geoserver.monitor.Filter;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.RequestData;
import org.geoserver.monitor.RequestDataVisitor;
import org.geoserver.monitor.Query.Comparison;
import org.opengeo.analytics.LineChart;
import org.opengeo.analytics.PieChart;
import org.opengeo.analytics.Service;
import org.opengeo.analytics.ServiceOpSummary;
import org.opengeo.analytics.ServiceTimeAggregator;
import org.opengeo.analytics.View;

public class ActivityPanel extends Panel {

    Query query;
    View zoom = View.DAILY;
    ServiceSelection services = new ServiceSelection();
    
    DateTimeField fromDateField, toDateField;
    ChartPanel lineChartPanel, pieChartPanel;
    
    public ActivityPanel(String id, Query query) {
        super(id);
        setOutputMarkupId(true);
        this.query = query;
        
        initComponents();
        
        updateLineChart(new AjaxRequestTarget(new WebPage(){}));
        updatePieChart(new AjaxRequestTarget(new WebPage(){}));
    }

    void initComponents() {
        if (query.getToDate() == null) {
            Date now = new Date();
            query.setToDate(now);    
        }
        if (query.getFromDate() == null) {
            query.setFromDate(zoom.initialRange(query.getToDate()));
        }

        Form form = new Form("form");
        add(form);
        
        form.add(new AjaxCheckBox("wms", new PropertyModel<Boolean>(this, "services.wms")) {
            @Override
            protected void onUpdate(AjaxRequestTarget target) {}
        });
        form.add(new AjaxCheckBox("wfs", new PropertyModel<Boolean>(this, "services.wfs")) {
            @Override
            protected void onUpdate(AjaxRequestTarget target) {}
        });
        form.add(new AjaxCheckBox("wcs", new PropertyModel<Boolean>(this, "services.wcs")) {
            @Override
            protected void onUpdate(AjaxRequestTarget target) {}
        });
        form.add(new AjaxCheckBox("other", new PropertyModel<Boolean>(this, "services.other")) {
            @Override
            protected void onUpdate(AjaxRequestTarget target) {}
        });
        form.add(fromDateField = new RequestDateTimeField("from", new PropertyModel<Date>(this,"query.fromDate")));
        fromDateField.setOutputMarkupId(true);
        
        form.add(toDateField = new RequestDateTimeField("to", new PropertyModel<Date>(this,"query.toDate")));
        toDateField.setOutputMarkupId(true);
        
        form.add(new AjaxButton("refresh", form) {
            @Override
            protected void onSubmit(AjaxRequestTarget target, Form<?> form) {
                handleZoomClick(zoom, target);
            }
        });
        
        List<AjaxLink> zoomLinks = new ArrayList();
        zoomLinks.add(new AjaxLink<View>("hour", new Model<View>(View.HOURLY)) {
            @Override
            public void onClick(AjaxRequestTarget target) {
               handleZoomClick(getModelObject(), target);
            } 
        });
        zoomLinks.add(new AjaxLink<View>("day", new Model<View>(View.DAILY)) {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleZoomClick(getModelObject(), target);
            }
        });
        zoomLinks.add(new AjaxLink<View>("week", new Model<View>(View.WEEKLY)) {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleZoomClick(getModelObject(), target);
            }
        });
        zoomLinks.add(new AjaxLink<View>("month", new Model<View>(View.MONTHLY)) {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleZoomClick(getModelObject(), target);
            }
        });
        for (AjaxLink link : zoomLinks) {
            form.add(link);
        }
        setMutuallyExclusive(zoomLinks, 
            Arrays.asList("button button-hour", "button button-day", "button button-week", 
                "button button-month"), zoomLinks.get(1));

        form.add(lineChartPanel = new ChartPanel("lineChart"));
        form.add(pieChartPanel = new ChartPanel("pieChart"));
    }
    
    protected void onChange(AjaxRequestTarget target) {
    }
    
    void handleZoomClick(View zoom, AjaxRequestTarget target) {
        this.zoom = zoom;
        
        //adjust the time period for the zoom
        query.setFromDate(zoom.minimumRange(query.getFromDate(), query.getToDate()));
        target.addComponent(fromDateField);
        
        //update the charts
        updateLineChart(target);
        updatePieChart(target);
        
        onChange(target);
        //updateSummaries(target);
    }
    
    void updateLineChart(AjaxRequestTarget target) {
        ServiceTimeAggregator agg = 
            new ServiceTimeAggregator(query, zoom, services.getSelectedAsString());
        Analytics.monitor().query(agg.getQuery(), agg);
        
        LineChart chart = new LineChart();
        chart.setContainer(lineChartPanel.getMarkupId());
        chart.setFrom(query.getFromDate());
        chart.setTo(query.getToDate());
        chart.setSteps(10);
        chart.setWidth(550);
        chart.setHeight(300);
        chart.setZoom(zoom);
        chart.setData(agg.getData());
        
        lineChartPanel.setChart(chart);
        target.addComponent(lineChartPanel);
    }
    
    void updatePieChart(AjaxRequestTarget target) {
        Query q = query.clone();
        q.getProperties().clear();
        q.getAggregates().clear();
        q.getGroupBy().clear();
        q.properties("service", "operation").aggregate("count()").group("service", "operation");
        
        Filter filter = 
            new Filter("service", new ArrayList(services.getSelectedAsString()), Comparison.IN);
        if (services.isSet(Service.OTHER)) {
            filter = filter.or(new Filter("service", null, Comparison.EQ));
        }
        q.and(filter);
        
        final HashMap<String,ServiceOpSummary> data = new HashMap();
        Analytics.monitor().query(q, new RequestDataVisitor() {
            public void visit(RequestData req, Object... aggregates) {
                ServiceOpSummary summary = data.get(req.getService());
                if (summary == null) {
                    summary = new ServiceOpSummary(req.getService());
                    data.put(req.getService(), summary);
                }
                summary.set(req.getOperation(), ((Number)aggregates[0]).longValue());
            }
        });
        if (data.containsKey(null)) {
            ServiceOpSummary summary = data.get(null);
            summary.setService(Service.OTHER.name());
            data.put(summary.getService(), summary);
            data.remove(null);
        }
        
        PieChart chart = new PieChart();
        chart.setContainer(pieChartPanel.getMarkupId());
        chart.setWidth(150);
        chart.setHeight(150);
        chart.setData(data);
        
        pieChartPanel.setChart(chart);
        target.addComponent(pieChartPanel);
    }
    
    void setMutuallyExclusive(List<AjaxLink> links, List<String> classes, AjaxLink initial) {
        for (int i = 0; i < links.size(); i++) {
            AjaxLink link = links.get(i);
            link.add(new MutuallyExclusingBehaviour("onclick", link, links, classes));
        }
        initial.add(new AttributeAppender("class", new Model("active"), " "));
    }
    
    static class MutuallyExclusingBehaviour extends AjaxEventBehavior {

        List<AjaxLink> group;
        AjaxLink self;
        List<String> classes;
        
        public MutuallyExclusingBehaviour(
            String event, AjaxLink self, List<AjaxLink> group, List<String> classes) {
            
            super(event);
            this.self = self;
            this.group = group;
            this.classes = classes;
        }

        @Override
        protected void onEvent(AjaxRequestTarget target) {
            self.onClick(target);
            
            self.add(new AttributeAppender("class", new Model("active"), " "));
            target.addComponent(self);
        
            for (int i = 0; i < group.size(); i++) {
                Component c = group.get(i);
                if (c == self) continue;
                
                String clazz = classes.get(i);
                c.add(new SimpleAttributeModifier("class", clazz));
                target.addComponent(c);
            }
        }
    }
    
    /**
     * Maintains state of selected services.
     */
    static class ServiceSelection implements Serializable {
        
        Set<Service> selected = new HashSet(Arrays.asList(Service.values()));
        
        public void setWms(boolean selected) { set(Service.WMS, selected ); }
        public boolean isWms() { return isSet(Service.WMS); }
        
        public void setWfs(boolean selected) { set(Service.WFS, selected ); }
        public boolean isWfs() { return isSet(Service.WFS); }
        
        public void setWcs(boolean selected) { set(Service.WCS, selected ); }
        public boolean isWcs() { return isSet(Service.WCS); }
        
        public void setOther(boolean selected) { set(Service.OTHER, selected ); }
        public boolean isOther() { return isSet(Service.OTHER); }
        
        public boolean isSet(Service s) {
            return selected.contains(s);
        }
        
        public void set(Service s, boolean set) {
            if (set) {
                selected.add(s);
            }
            else {
                selected.remove(s);
            }
        }
        
        public Set<Service> getSelected() {
            return selected;
        }
        
        public Set<String> getSelectedAsString() {
            Set<String> set = new HashSet();
            for (Service s : selected) {
                set.add(s.name());
            }
            return set;
        }
    }
}
