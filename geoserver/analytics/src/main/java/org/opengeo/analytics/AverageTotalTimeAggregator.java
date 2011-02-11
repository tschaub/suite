package org.opengeo.analytics;

import java.util.Date;

import org.geoserver.monitor.Query;
import org.geoserver.monitor.RequestData;

//TODO: share code with the other aggregators
public class AverageTotalTimeAggregator extends RequestDataAggregator {

    Query query;
    View view;
    long[] total;
    long[] count;
    
    public AverageTotalTimeAggregator(Query query, View view) {
        super(query.getFromDate(), query.getToDate());
        this.view = view;
        this.query = query.clone();
        this.query.getProperties().clear();
        this.query.getAggregates().clear();
        this.query.getGroupBy().clear();
        this.query.properties("startTime", "totalTime");
        
        this.total = new long[(int) (view.period().diff(from, to) + 1)];
        this.count = new long[total.length];
    }

    public Query getQuery() {
        return query;
    }
    
    public void visit(RequestData data, Object... aggregates) {
        int index = index(data.getStartTime());
        count[index]++;
        total[index] += data.getTotalTime();
    }
    
    int index(Date time) {
        return (int) view.period().diff(from, time);
    }
    
    public double[] getData() {
        double[] data = new double[count.length];
        for (int i = 0; i < data.length; i++) {
            if (count[i] == 0) continue;
            data[i] = total[i] / ((double)count[i]);
        }
        
        return data;
    }
}
