package org.opengeo.geoserver.monitor;

import org.apache.wicket.MarkupContainer;
import org.apache.wicket.markup.IMarkupResourceStreamProvider;
import org.apache.wicket.markup.html.panel.Panel;
import org.apache.wicket.util.resource.IResourceStream;
import org.apache.wicket.util.resource.UrlResourceStream;
import org.geoserver.monitor.Query;

public class RequestListPanel extends Panel implements IMarkupResourceStreamProvider {

    Query query;
    
    public RequestListPanel(String id, Query query) {
        super(id);
        this.query = query;
    }

    public IResourceStream getMarkupResourceStream(MarkupContainer container,
            Class<?> containerClass) {
        return new UrlResourceStream(RequestListPanel.class.getResource("foo.html"));
    }

}
