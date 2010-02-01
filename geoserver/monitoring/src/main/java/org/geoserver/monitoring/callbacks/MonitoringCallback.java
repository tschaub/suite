package org.geoserver.monitoring.callbacks;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.InetAddress;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.atomic.AtomicLong;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.namespace.QName;

import net.opengis.wfs.GetFeatureType;
import net.opengis.wfs.QueryType;

import org.geoserver.monitoring.monitors.RequestMonitor;
import org.geoserver.monitoring.monitors.RequestStats;
import org.geoserver.monitoring.monitors.RequestStats.Status;
import org.geoserver.ows.DispatcherCallback;
import org.geoserver.ows.Request;
import org.geoserver.ows.Response;
import org.geoserver.platform.Operation;
import org.geoserver.platform.Service;
import org.geoserver.platform.ServiceException;
import org.geoserver.wms.MapLayerInfo;
import org.geotools.util.Version;
import org.geotools.util.logging.Logging;
import org.vfny.geoserver.wms.requests.GetMapRequest;

public class MonitoringCallback implements DispatcherCallback {
    
    static final Logger LOGGER = Logging.getLogger(MonitoringCallback.class); 

    /**
     * A very simple unique id generator for {@link RequestStats} objects
     */
    private static final AtomicLong REQ_ID_GEN = new AtomicLong();

    String host;

    public MonitoringCallback() {
        try { 
            InetAddress addr = InetAddress.getLocalHost(); 
            host = addr.getHostName(); 
        } catch (Throwable t) { 
            LOGGER.log(Level.SEVERE, "Could not get host name of the server", t);
        } 
    }

    public Request init(Request request) {
        HttpServletRequest req = request.getHttpRequest();
        HttpServletResponse resp = request.getHttpResponse();

        RequestStats reqStats = new RequestStats();
        RequestMonitor.getThreadRequestStats().set(reqStats);

        reqStats.setHost(host);
        reqStats.setRequestId(REQ_ID_GEN.incrementAndGet());

        reqStats.setHttpMethod(req.getMethod());
        reqStats.setQueryString(req.getQueryString());
        reqStats.setStatus(Status.RUNNING);

        reqStats.setStartTime(System.currentTimeMillis());

        /*
         * Send it to the Monitor so it knows this request is alive
         */
        RequestMonitor.getInstance().add(reqStats);

        // replace the servlet response parameter in the pointcut by one that counts the number of
        // bytes written
        final CountingServletResponse countingResponse = new CountingServletResponse(resp);
        request.setHttpResponse(countingResponse);
        return request;
    }

    public void finished(Request request) {
        RequestStats reqStats = RequestMonitor.getThreadRequestStats().get();

        /*
         * After calling the actual handleRequestInternal method
         */
        reqStats.setTotalTime(System.currentTimeMillis() - reqStats.getStartTime());
        RequestMonitor.getThreadRequestStats().remove();

        HttpServletResponse httpResponse = request.getHttpResponse();
        HttpServletRequest httpRequest = request.getHttpRequest();

        if (httpResponse instanceof CountingServletResponse)
            reqStats.setRespponseLength(((CountingServletResponse) httpResponse).getWrittenCount());
        reqStats.setResponseContentType(httpResponse.getContentType());
        // handle reverse proxies that might hide the actual original IP.
        // TODO: this should probably be GUI configurable, what if the incoming request
        // is poisoned with a fake X-Forwarded-For header and there is no actual reverse proxy?
        String forwardedFor = httpRequest.getHeader("X-Forwarded-For");
        if (forwardedFor != null) {
            String[] ips = forwardedFor.split(", ");
            reqStats.setRemoteAddr(ips[0]);
        } else {
            reqStats.setRemoteAddr(httpRequest.getRemoteAddr());
        }

        /*
         * Ask for remotHost here after the request finished execution to prevent a possible DNS
         * lookup to slow down the request processing
         */
        reqStats.setRemoteHost(httpRequest.getRemoteHost());

        if (reqStats.getStatus() != Status.FAILED) {
            reqStats.setStatus(Status.FINISHED);
        }

        if (reqStats != null && request.getError() != null) {
            reqStats.setStatus(Status.FAILED);
            reqStats.setServiceException(request.getError().getMessage());
            StringWriter out = new StringWriter();

            Throwable cause = request.getError();
            while (cause.getCause() != null) {
                /*
                 * Usually the top most exception adds no value and it's stack trace is larger than
                 * MAX_STACK_TRACE_CHARS without even getting to the first cause
                 */
                cause = cause.getCause();
            }

            cause.printStackTrace(new PrintWriter(out));
            // NOTE: this constant doesn't belong here, but... config option? (note 1024 was too low
            // a limit as to even get to the first cause)
            final int MAX_STACK_TRACE_CHARS = 4096;
            reqStats.setExceptionStackTrace(out.getBuffer().substring(0, MAX_STACK_TRACE_CHARS));
        }
    }

    public Operation operationDispatched(Request request, Operation operation) {
        RequestStats reqStats = RequestMonitor.getThreadRequestStats().get();
        if (reqStats != null) {
            Service serviceDescriptor = operation.getService();
            reqStats.setServiceName(serviceDescriptor.getId());
            Version version = serviceDescriptor.getVersion();
            if (version != null) {
                reqStats.setServiceVersion(version.toString());
            }
            reqStats.setOperationName(operation.getId());

            // TODO: this should be replaced with pluggable extractors
            List<String> layerNames = reqStats.getLayerNames();
            if (reqStats.getServiceName().equalsIgnoreCase("WMS")
                    && reqStats.getOperationName().equalsIgnoreCase("GetMap")) {
                GetMapRequest getMap = (GetMapRequest) operation.getParameters()[0];
                for (MapLayerInfo layer : getMap.getLayers()) {
                    String layerName = null;
                    if (layer.getType() == MapLayerInfo.TYPE_VECTOR) {
                        layerName = layer.getFeature().getName();
                    } else if (layer.getType() == MapLayerInfo.TYPE_RASTER) {
                        layerName = layer.getCoverage().getName();
                    }
                    if (layerName != null && !layerNames.contains(layerName))
                        layerNames.add(layerName);
                }
            } else if (reqStats.getServiceName().equalsIgnoreCase("WFS")) {
                if (operation.getParameters().length > 0
                        && operation.getParameters()[0] instanceof GetFeatureType) {
                    GetFeatureType getFeature = (GetFeatureType) operation.getParameters()[0];
                    for (Iterator it = getFeature.getQuery().iterator(); it.hasNext();) {
                        QueryType q = (QueryType) it.next();
                        String typeName = ((QName) q.getTypeName().get(0)).getLocalPart();
                        if (typeName != null && !layerNames.contains(typeName))
                            layerNames.add(typeName);
                    }
                }
            }
        }

        return operation;
    }

    public Object operationExecuted(Request request, Operation operation, Object result) {
        return result;
    }

    public Response responseDispatched(Request request, Operation operation, Object result,
            Response response) {
        return response;
    }

    public Service serviceDispatched(Request request, Service service) throws ServiceException {
        return service;
    }

}
