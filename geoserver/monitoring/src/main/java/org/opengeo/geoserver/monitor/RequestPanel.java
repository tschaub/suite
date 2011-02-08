package org.opengeo.geoserver.monitor;

import java.awt.Color;
import java.awt.Font;
import java.awt.geom.Rectangle2D;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.wicket.Component;
import org.apache.wicket.Page;
import org.apache.wicket.ajax.AjaxRequestTarget;
import org.apache.wicket.ajax.form.AjaxFormComponentUpdatingBehavior;
import org.apache.wicket.ajax.markup.html.AjaxLink;
import org.apache.wicket.ajax.markup.html.form.AjaxButton;
import org.apache.wicket.behavior.AttributeAppender;
import org.apache.wicket.behavior.SimpleAttributeModifier;
import org.apache.wicket.extensions.ajax.markup.html.modal.ModalWindow;
import org.apache.wicket.extensions.markup.html.repeater.data.table.IColumn;
import org.apache.wicket.extensions.markup.html.repeater.data.table.PropertyColumn;
import org.apache.wicket.extensions.yui.calendar.DateTimeField;
import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.Radio;
import org.apache.wicket.markup.html.form.RadioChoice;
import org.apache.wicket.markup.html.form.RadioGroup;
import org.apache.wicket.markup.html.image.NonCachingImage;
import org.apache.wicket.markup.html.image.resource.BufferedDynamicImageResource;
import org.apache.wicket.markup.html.link.Link;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.apache.wicket.model.PropertyModel;
import org.geoserver.catalog.LayerInfo;

import org.geoserver.monitor.Monitor;
import org.geoserver.monitor.MonitorVisitor;
import org.geoserver.monitor.Query;
import org.geoserver.monitor.Query.Comparison;
import org.geoserver.monitor.Query.SortOrder;
import org.geoserver.monitor.RequestData;
import org.geoserver.monitor.RequestDataVisitor;
import org.geoserver.web.GeoServerApplication;
import org.geoserver.web.data.store.StorePanel;
import org.geoserver.web.wicket.GeoServerDataProvider;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.geoserver.web.wicket.GeoServerDataProvider.BeanProperty;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.CategoryAxis;
import org.jfree.chart.axis.CategoryLabelPositions;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.block.BlockBorder;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.Plot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.CategoryDataset;
import org.jfree.data.general.DatasetUtilities;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.time.Day;
import org.jfree.data.time.Hour;
import org.jfree.ui.HorizontalAlignment;
import org.jfree.ui.RectangleAnchor;
import org.jfree.ui.RectangleEdge;
import org.jfree.ui.Size2D;
import org.jfree.ui.VerticalAlignment;

public class RequestPanel extends Panel {

    static enum View {
        DAILY {
            @Override
            DataGatherer createGatherer() { return new DailyGatherer(); };
        }, 
        WEEKLY {
            @Override
            DataGatherer createGatherer() { return new WeeklyGatherer(); };
        }, 
        MONTHLY {
            @Override
            DataGatherer createGatherer() { return new MonthlyGatherer(); };
        };
        
        abstract DataGatherer createGatherer();
    };
    static enum Chart {
        AREA, PIE
    }
    AjaxLink dailyLink, weeklyLink, monthlyLink;
    View chartView = View.DAILY;
    
    AjaxLink areaLink, pieLink;
    Chart chartType = Chart.AREA;
    
    DateTimeField fromDateField, toDateField;
    Date to, from;
    
    NonCachingImage requestChartImage;
    
    public RequestPanel(String id) {
        super(id);
        
        initComponents();
    }

    static Monitor getMonitor() {
        return GeoServerApplication.get().getBeanOfType(Monitor.class);
    }
    
    void initComponents() {
        Form form = new Form("form");
        add(form);
        
        form.add(dailyLink = new AjaxLink("daily") {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleDailyClick(target);
            }
        });
        form.add(weeklyLink = new AjaxLink("weekly") {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleWeeklyClick(target);
            }
        });
        form.add(monthlyLink = new AjaxLink("monthly") {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleMonthlyClick(target);
            }
        });
        form.add(areaLink = new AjaxLink("area") {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handleAreaClick(target);
            }
        });
        form.add(pieLink = new AjaxLink("pie") {
            @Override
            public void onClick(AjaxRequestTarget target) {
                handlePieClick(target);
            }
        });
        
        form.add(fromDateField = new DateTimeField("from", new PropertyModel<Date>(this,"from")) {
            @Override
            protected boolean use12HourFormat() {
                return false;
            }
        });
        fromDateField.setOutputMarkupId(true);
        
        form.add(toDateField = new DateTimeField("to", new PropertyModel<Date>(this,"to")) {
            @Override
            protected boolean use12HourFormat() {
                return false;
            }
        });
        toDateField.setOutputMarkupId(true);
        
        form.add(new AjaxButton("refresh", form) {
            @Override
            protected void onSubmit(AjaxRequestTarget target, Form<?> form) {
                updateChart(target);
            }
        });
        
        //BufferedDynamicImageResource resource = createRequestChart(new DailyGatherer());
        //add(requestChartImage = new NonCachingImage("requestChart", resource));
        form.add(requestChartImage = new NonCachingImage("requestChart"));
        requestChartImage.setOutputMarkupId(true);

        
        
        handleDailyClick(new AjaxRequestTarget(new WebPage(){}));
    }

    void updateChart(AjaxRequestTarget target) {
        DataGatherer g = chartView.createGatherer();
        
        target.addComponent(fromDateField);
        target.addComponent(toDateField);
        requestChartImage.setImageResource(createRequestChart(g));
        target.addComponent(requestChartImage);
    }
    
    void updateDateRange(AjaxRequestTarget target) {
        DataGatherer g = chartView.createGatherer();
        Date[] range = g.getDateRange();
        from = range[0];
        to = range[1];
        
        target.addComponent(fromDateField);
        target.addComponent(toDateField);
    }
    
    void handleDailyClick(AjaxRequestTarget target) {
        chartView = View.DAILY;
        updateDateRange(target);
        updateChart(target);
        updateLinks(target, dailyLink,  new AjaxLink[]{weeklyLink, monthlyLink}, "selectable");
    }
    
    void handleWeeklyClick(AjaxRequestTarget target) {
        chartView = View.WEEKLY;
        updateDateRange(target);
        updateChart(target);
        updateLinks(target, weeklyLink, new AjaxLink[]{dailyLink, monthlyLink}, "selectable");
    }

    void handleMonthlyClick(AjaxRequestTarget target) {
        chartView = View.MONTHLY;
        updateDateRange(target);
        updateChart(target);
        updateLinks(target, monthlyLink,  new AjaxLink[]{dailyLink, weeklyLink}, "selectable");
    }
    
    void handleAreaClick(AjaxRequestTarget target) {
        chartType = Chart.AREA;
        updateChart(target);
        updateLinks(target, areaLink, new AjaxLink[]{pieLink}, "button-chart-pie");
    }
    
    void handlePieClick(AjaxRequestTarget target) {
        chartType = Chart.PIE;
        updateChart(target);
        updateLinks(target, pieLink,  new AjaxLink[]{areaLink}, "button-chart-area");
    }
    
    void updateLinks(AjaxRequestTarget target, AjaxLink selected, AjaxLink[] other, String classes) {
        selected.add(new AttributeAppender("class", new Model("selected"), " "));
        target.addComponent(selected);
        
        for(AjaxLink link : other) {
            link.add(new SimpleAttributeModifier("class", classes));
            target.addComponent(link);
        }
    }
    
    BufferedDynamicImageResource createRequestChart(DataGatherer g) {
        Monitor monitor = getMonitor();
        
        Date[] range = new Date[]{from, to};
        
        Query q = new Query().properties("service", "startTime")
            .between(range[0], range[1]);
        monitor.query(q, g);
        
        JFreeChart chart;
        if (chartType == Chart.PIE) {
            chart = createPieChart(g, range);
        }
        else {
            chart = createAreaChart(g, range);
        }
       
        if (chart.getLegend() != null) {
            chart.getLegend().setPosition(RectangleEdge.TOP);
            chart.getLegend().setHorizontalAlignment(HorizontalAlignment.LEFT);
            chart.getLegend().setBorder(BlockBorder.NONE);
        }
        //chart.getLegend().setItemFont(Font.decode("SansSerif-PLAIN-14"));
        
        chart.setTitle((TextTitle)null);
        chart.setBackgroundPaint(Color.white);
        
        Plot plot = chart.getPlot();
        plot.setForegroundAlpha(0.5f);
        plot.setBackgroundPaint(Color.lightGray);
        
        BufferedDynamicImageResource resource = new BufferedDynamicImageResource();
        resource.setImage(chart.createBufferedImage(600,400));
        return resource;
    }

    JFreeChart createAreaChart(DataGatherer g, Date[] range) {
        final Map<String,long[]> results = g.getData();
        List<String> requestTypes = new ArrayList(results.keySet());
        
        //sort so that request types with smaller count shows up front
        Collections.sort(requestTypes, new Comparator<String>() {
            public int compare(String o1, String o2) {
                Long c1 = results.get(o1)[0];
                Long c2 = results.get(o2)[0];
                
                return -1*c1.compareTo(c2);
            }
        });
        
        //only tally values within the data range
        int low = g.getInterval(range[0]);
        int high = g.getInterval(range[1]) + 1;
        
        String[] colLabels = new String[high-low];
        for (int i = low; i < high; i++) {
            colLabels[i-low] = g.label(i);
        }
        
        double[][] data;
        if (requestTypes.isEmpty()) {
            //no data over this time period, fill out zeros
            data = new double[1][colLabels.length];
            requestTypes.add("");
        }
        else {
            data = new double[requestTypes.size()][colLabels.length];
            for (int i = 0; i < requestTypes.size(); i++ ) {
                String key = requestTypes.get(i);
                long[] requests = results.get(key);
                for (int j = 0; j < colLabels.length; j++) {
                    data[i][j] = requests[low+j+1];
                }
            }
        }
        
        CategoryDataset dataset = DatasetUtilities.createCategoryDataset(
            requestTypes.toArray(new Comparable[requestTypes.size()]), colLabels, data);
        
        boolean showLegend = !(requestTypes.size() == 1 && "".equals(requestTypes.get(0)));
        
        JFreeChart chart = ChartFactory.createAreaChart("Request Activity", g.getTimeUnit(), "Requests", 
            dataset, PlotOrientation.VERTICAL, showLegend, true, false);
        if (showLegend) {
            chart.getLegend().setPadding(0, 75, 0, 0);
        }
        
        CategoryPlot plot = chart.getCategoryPlot();
        
        plot.setDomainGridlinesVisible(true);
        plot.setDomainGridlinePaint(Color.white);
        plot.setRangeGridlinesVisible(true);
        plot.setRangeGridlinePaint(Color.white);

        final CategoryAxis domainAxis = plot.getDomainAxis();
        //domainAxis.setCategoryLabelPositions(CategoryLabelPositions.UP_45);

        final NumberAxis rangeAxis = (NumberAxis) plot.getRangeAxis();
        //rangeAxis.setStandardTickUnits(NumberAxis.createIntegerTickUnits());
        //rangeAxis.setLabelAngle(0 * Math.PI / 2.0);
        
        return chart;
    }

    JFreeChart createPieChart(DataGatherer g, Date[] range) {
        final Map<String,long[]> results = g.getData();
        
        DefaultPieDataset dataset = new DefaultPieDataset();
        for (Map.Entry<String, long[]> e : results.entrySet()) {
            dataset.setValue(e.getKey(), e.getValue()[0]);
        }
        
        JFreeChart chart = 
            ChartFactory.createPieChart(null, dataset,  true, true, false);
        chart.setBackgroundPaint(Color.WHITE);
        chart.getLegend().setPadding(0, 10, 0, 0);
        return chart;
    }
    
    static abstract class DataGatherer implements RequestDataVisitor {

        protected Date now;
        protected Map<String,long[]> data = new HashMap();
         
        protected DataGatherer() {
            this(new Date());
        }
        
        protected DataGatherer(Date now) {
            this.now = now;
        }
        
        public void visit(RequestData r, Object... aggregates) {
            String key = r.getService();
            key = key != null ? key.toUpperCase() : "Other";
            
            long[] requests = data.get(key);
            if (requests == null) {
                requests = new long[getNumIntervals()+1];
                data.put(key, requests);
            }
            
            requests[getInterval(r.getStartTime())+1]++;
            requests[0]++;
        }
        
        public Map<String, long[]> getData() {
            return data;
        }
        
        protected String toDay(int i) {
            switch(i) {
                case 0: return "Sun";
                case 1: return "Mon";
                case 2: return "Tue";
                case 3: return "Wed";
                case 4: return "Thu";
                case 5: return "Fri";
                case 6: return "Sat";
                default: 
                    throw new IllegalArgumentException();
            }
        }
        
        protected String toMonth(int i) {
            switch(i) {
                case 0: return "Jan";
                case 1: return "Feb";
                case 2: return "Mar";
                case 3: return "Apr";
                case 4: return "May";
                case 5: return "Jun";
                case 6: return "Jul";
                case 7: return "Aut";
                case 8: return "Sep";
                case 9: return "Oct";
                case 10: return "Nov";
                case 11: return "Dec";
                default: 
                    throw new IllegalArgumentException();
            }
        }
        public abstract Date[] getDateRange();
        
        public abstract int getNumIntervals();
        
        public abstract int getInterval(Date time);
        
        public abstract String label(int i);
        
        public abstract String getTimeUnit();
    }
    
    static class DailyGatherer extends DataGatherer { 
        
        @Override
        public Date[] getDateRange() {
            Calendar then = Calendar.getInstance();
            then.setTime(now);
            then.set(Calendar.HOUR_OF_DAY, 0);
            then.set(Calendar.MINUTE, 0);
            then.set(Calendar.SECOND, 0);
            
            return new Date[]{then.getTime(), now};
        }
        
        public int getNumIntervals() {
            return 24;
        }
        
        public int getInterval(Date time) {
            return new Hour(time).getHour();
        }
        
        public String label(int i) {
            return String.valueOf(i) + ":00";
        }
        
        @Override
        public String getTimeUnit() {
            return "Hour";
        }
    }
    
    static class WeeklyGatherer extends DataGatherer {
        @Override
        public Date[] getDateRange() {
            Calendar then = Calendar.getInstance();
            then.setTime(now);
            then.set(Calendar.DAY_OF_WEEK, Calendar.SUNDAY);
            
            return new Date[]{then.getTime(), now};
        }
        
        public int getNumIntervals() {
            return 7;
        }
        
        public int getInterval(Date time) {
            Calendar c = Calendar.getInstance();
            c.setTime(time);
            return c.get(Calendar.DAY_OF_WEEK) -1;
        }
        
        public String label(int i) {
            String day = toDay(i);
            
            Calendar c = Calendar.getInstance();
            c.setTime(now);
            c.set(Calendar.DAY_OF_WEEK, i+1);
            
            return String.format("%s %d/%d", day, 
                c.get(Calendar.DAY_OF_MONTH), c.get(Calendar.MONTH)+1);
        }
        
        @Override
        public String getTimeUnit() {
            return "Day";
        }
    }
    
    static class MonthlyGatherer extends DataGatherer {

        @Override
        public Date[] getDateRange() {
            Calendar c = Calendar.getInstance();
            c.setTime(now);
            c.set(Calendar.DAY_OF_MONTH, 1);
            return new Date[]{c.getTime(), now};
        }

        @Override
        public int getNumIntervals() {
            Calendar c = Calendar.getInstance();
            c.setTime(now);
            return c.getMaximum(Calendar.WEEK_OF_MONTH);
        }

        @Override
        public int getInterval(Date time) {
            Calendar c = Calendar.getInstance();
            c.setTime(time);
            return c.get(Calendar.WEEK_OF_MONTH)-1;
        }

        @Override
        public String label(int i) {
            Calendar c = Calendar.getInstance();
            c.setTime(now);
            c.set(Calendar.WEEK_OF_MONTH, i+1);
            
            c.set(Calendar.DAY_OF_WEEK, 1);
            int begin = c.get(Calendar.DAY_OF_MONTH);
            String m1 = toMonth(c.get(Calendar.MONTH));
            
            c.set(Calendar.DAY_OF_WEEK, 7);
            int end = c.get(Calendar.DAY_OF_MONTH);
            String m2 = toMonth(c.get(Calendar.MONTH));
            
            if (m1.equals(m2)) {
                return String.format("%s %d - %d", m1, begin, end);
            }
            else {
                return String.format("%s %d - %s %d", m1, begin, m2, end);
            }
            
        }
        
        @Override
        public String getTimeUnit() {
             return "Week";
        }
    }

    static class LayerAccess implements Serializable {
        long count;
        RequestData request;
        
        public LayerAccess(long count, RequestData request) {
            this.count = count;
            this.request = request;
        }
        
        public long getCount() {
            return count;
        }
        
        public RequestData getRequest() {
            return request;
        }
    }
    
}
