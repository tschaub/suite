package org.opengeo.analytics;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import freemarker.template.SimpleHash;
import freemarker.template.TemplateException;

public class PerformanceLineChart extends Chart {

    protected int steps;
    protected View zoom;
    protected Date from, to;
    double[] data;
    
    
    public void setFrom(Date from) {
        this.from = from;
    }
   
    public Date getFrom() {
        return from;
    }
    
    public void setTo(Date to) {
        this.to = to;
    }
    
    public Date getTo() {
        return to;
    }
    
    public void setZoom(View zoom) {
        this.zoom = zoom;
    }
    
    public View getZoom() {
        return zoom;
    }
    
    public void setSteps(int steps) {
        this.steps = steps;
    }
    
    public int getSteps() {
        return steps;
    }
    
    public void setData(double[] data) {
        this.data = data;
    }
    
    public double[] getData() {
        return data;
    }
    
    @Override
    public void render(Writer writer) throws IOException, TemplateException {
        //build up the xy data
        StringBuilder x = new StringBuilder();
        StringBuilder y = new StringBuilder();
        
        x.append("["); y.append("[");
        for (int i = 0; i < data.length; i++) {
            x.append(i).append(",");
            y.append(data[i]).append(",");
        }
        
        x.setLength(x.length()-1);
        x.append("]");
        
        y.setLength(y.length()-1);
        y.append("]");
        
        //build the labels
        List<Date> dates = zoom.period().divide(from, to, steps);
        int steps = dates.size()-1;
        
        StringBuilder labels = new StringBuilder().append("[");
        for (Date d : dates) {
            labels.append("'").append(zoom.label(d)).append("',");
        }
        labels.setLength(labels.length()-1);
        labels.append("]");
        
        //figure out where the breaks occur at the higher zoom
        TimePeriod up;
        switch(zoom) {
            case HOURLY:
            case DAILY:
                up = TimePeriod.DAY;
                break;
            case WEEKLY:
                up = TimePeriod.WEEK;
                break;
                
            default:
                up = null;
        }
        
        List<Object[]> breaks = new ArrayList();
        
        if (up != null) {
            int dx = (int) zoom.period().diff(dates.get(0), dates.get(1));
            for (int i = 0; i < dates.size()-1; i++) {
                Date d1 = dates.get(i);
                Date d2 = dates.get(i+1);
                
                //figure out if a boundary is crossed at the higher zoom
                if (up.diff(d1, d2) > 0) {
                    int diff = (int) zoom.period().diff(d1, up.floor(d2));
                    breaks.add(new Object[]{i, diff, dx, View.MONTHLY.label(up.floor(d2))});
                }
            }
        }
        
        SimpleHash model = createTemplate();
        model.put("xdata", x.toString());
        model.put("xlen",  data.length != 0 ? data.length : -1 );
        model.put("ydata", y.toString());
        model.put("labels", labels.toString());
        model.put("xsteps", steps);
        model.put("breaks", breaks);
        
        render(model, "performance-line.ftl", writer);
    }

}
