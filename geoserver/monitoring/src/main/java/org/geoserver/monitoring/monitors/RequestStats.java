package org.geoserver.monitoring.monitors;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.geoserver.ows.Dispatcher;
import org.geoserver.platform.ServiceException;

/**
 * Placeholder for the statistics information gathered for a single OWS request
 */
public class RequestStats implements Serializable {

    private static final long serialVersionUID = 4115701065212157258L;

    public static enum Status {
        WAITING, RUNNING, CANCELLING, FAILED, FINISHED
    };

    private long requestId;

    private Status status = Status.WAITING;

    /**
     * The OWS name (such as WMS, WFS, WCS, WPS, etc.)
     */
    private String serviceName;

    /**
     * The OWS version
     */
    private String serviceVersion;

    /**
     * The OWS operation name (such as GetMap, GetFeature, etc.)
     */
    private String operationName;

    private List<String> layerNames = new ArrayList<String>(1);

    /**
     * The HTTP method of the request
     */
    private String httpMethod;

    /**
     * The request start timestamp in the Server's local time (as per
     * {@link System#currentTimeMillis()})
     */
    private long startTime;

    /**
     * The total time, in milliseconds, the request took to complete, since the {@link Dispatcher}
     * handled it.
     */
    private long totalTime;

    /**
     * The HTTP response length, in bytes
     */
    private long responseLength;

    private String userName;

    /**
     * The response content MIME type, might be {@code null}
     */
    private String responseContentType;

    /**
     * The {@link ServiceException} message, or {@code null}
     */
    private String serviceException;

    /**
     * The printed stack trace for the exception occurred while processing the request, if any.
     */
    private String exceptionStackTrace;

    /**
     * The Internet Protocol (IP) address of the client or last proxy that sent the request.
     */
    private String remoteAddr;

    /**
     * The fully qualified name of the client or the last proxy that sent the request. If the engine
     * cannot or chooses not to resolve the hostname (to improve performance), the the dotted-string
     * form of the IP address.
     */
    private String remoteHost;
    
    /**
     * The server host (useful in case we are dealing with a cluster of GeoServer instances)
     */
    private String host;

    /**
     * The query string that is contained in the request URL after the path, or {@code null} if the
     * URL does not have a query string.
     */
    private String queryString;

    public void setStatus(Status status) {
        this.status = status;
    }

    public String getHost() {
        return host;
    }

    public void setHost(String host) {
        this.host = host;
    }

    public Status getStatus() {
        return status;
    }

    public void setRequestId(long requestId) {
        this.requestId = requestId;
    }

    public long getRequestId() {
        return requestId;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceVersion(String serviceVersion) {
        this.serviceVersion = serviceVersion;
    }

    public String getServiceVersion() {
        return serviceVersion;
    }

    public void setOperationName(String operationName) {
        this.operationName = operationName;
    }

    public String getOperationName() {
        return operationName;
    }

    public List<String> getLayerNames() {
        return layerNames;
    }

    public void setHttpMethod(String httpMethod) {
        this.httpMethod = httpMethod;
    }

    public String getHttpMethod() {
        return httpMethod;
    }

    public void setStartTime(long startTime) {
        this.startTime = startTime;
    }

    public long getStartTime() {
        return startTime;
    }

    public void setTotalTime(long totalTime) {
        this.totalTime = totalTime;
    }

    public long getTotalTime() {
        return totalTime;
    }

    public void setResponseLength(long respponseLength) {
        this.responseLength = respponseLength;
    }

    public long getResponseLength() {
        return responseLength;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserName() {
        return userName;
    }

    public void setResponseContentType(String responseContentType) {
        this.responseContentType = responseContentType;
    }

    public String getResponseContentType() {
        return responseContentType;
    }

    public void setServiceException(String serviceException) {
        this.serviceException = serviceException;
    }

    public String getServiceException() {
        return serviceException;
    }

    public void setExceptionStackTrace(String exceptionStackTrace) {
        this.exceptionStackTrace = exceptionStackTrace;
    }

    public String getExceptionStackTrace() {
        return exceptionStackTrace;
    }

    public void setRemoteAddr(String remoteAddr) {
        this.remoteAddr = remoteAddr;
    }

    public String getRemoteAddr() {
        return remoteAddr;
    }

    public void setRemoteHost(String remoteHost) {
        this.remoteHost = remoteHost;
    }

    public String getRemoteHost() {
        return remoteHost;
    }

    public void setQueryString(String queryString) {
        this.queryString = queryString;
    }

    public String getQueryString() {
        return queryString;
    }

}
