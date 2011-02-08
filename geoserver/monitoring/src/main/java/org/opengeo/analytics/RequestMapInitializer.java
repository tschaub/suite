package org.opengeo.analytics;

import java.io.File;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.FeatureTypeInfo;
import org.geoserver.catalog.LayerGroupInfo;
import org.geoserver.catalog.LayerInfo;
import org.geoserver.catalog.NamespaceInfo;
import org.geoserver.catalog.ProjectionPolicy;
import org.geoserver.catalog.StyleInfo;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.config.GeoServer;
import org.geoserver.config.GeoServerInitializer;
import org.geoserver.data.util.IOUtils;
import org.geoserver.monitor.hib.MonitoringDataSource;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geotools.data.postgis.PostgisNGDataStoreFactory;
import org.geotools.data.shapefile.ShapefileDataStoreFactory;
import org.geotools.geometry.jts.ReferencedEnvelope;
import org.geotools.jdbc.JDBCDataStoreFactory;
import org.geotools.jdbc.VirtualTable;
import org.geotools.referencing.CRS;
import org.opengis.referencing.crs.CoordinateReferenceSystem;

import com.vividsolutions.jts.geom.Point;

public class RequestMapInitializer implements GeoServerInitializer {

    MonitoringDataSource dataSource;
    
    public RequestMapInitializer(MonitoringDataSource dataSource) {
        this.dataSource = dataSource;
    }
    
    public void initialize(GeoServer geoServer) throws Exception {
        Catalog cat = geoServer.getCatalog();
        
        //set up a workspace
        WorkspaceInfo ws = null;
        if ((ws = cat.getWorkspaceByName("analytics")) == null) {
            ws = cat.getFactory().createWorkspace();
            ws.setName("analytics");
            cat.add(ws);
                
            NamespaceInfo ns = cat.getFactory().createNamespace();
            ns.setPrefix("analytics");
            ns.setURI("http://opengeo.org/analytics");
            cat.add(ns);
        }
        
        //set up the styles
        addStyle(cat, "analytics_requests_agg");
        
        //setup data files
        GeoServerResourceLoader rl = cat.getResourceLoader();
//        File f = rl.find("data", "monitor", "monitor_world.shp");
//        if (f == null) {
//            File dir = rl.findOrCreateDirectory("data", "monitor");
//            IOUtils.decompress(getClass().getResourceAsStream("monitor_world.zip"), dir);
//            f = rl.find("data", "monitor", "monitor_world.shp");
//        }
//        
//        //setup a datastore for the base layer
//        if (cat.getDataStoreByName("monitor", "monitor_world") == null) {
//            DataStoreInfo ds = cat.getFactory().createDataStore();
//            ds.setWorkspace(ws);
//            ds.setName("monitor_world");
//            ds.getConnectionParameters().put(ShapefileDataStoreFactory.URLP.key, f.toURL());
//            ds.setEnabled(true);
//            cat.add(ds);
//            
//            FeatureTypeInfo ft = cat.getFactory().createFeatureType();
//            ft.setName("monitor_world");
//            ft.setNativeName("monitor_world");
//            ft.setNamespace(cat.getNamespaceByPrefix(ws.getName()));
//            ft.setStore(ds);
//            ft.setEnabled(true);
//            setWorldBounds(ft);
//         
//            cat.add(ft);
//            
//            addLayer(cat, ft, "monitor_world");
//        }
        
        //set up a datastore for the request layer 
        if (cat.getDataStoreByName("analytics", "requests") == null) {
            DataStoreInfo ds = cat.getFactory().createDataStore();
            ds.setWorkspace(ws);
            ds.setName("requests");

            Map params = new HashMap();
            String url = dataSource.getUrl();
            setParams(params, url);
            params.put(JDBCDataStoreFactory.DBTYPE.key, "postgis");
            params.put(JDBCDataStoreFactory.USER.key, dataSource.getUsername());
            params.put(JDBCDataStoreFactory.PASSWD.key, dataSource.getPassword());
            
            ds.getConnectionParameters().putAll(params);
            ds.setEnabled(true);
            cat.add(ds);
            
            FeatureTypeInfo ft = cat.getFactory().createFeatureType();
            ft.setName("requests_agg");
            ft.setNativeName("requests_agg");
            ft.setNamespace(cat.getNamespaceByPrefix(ws.getName()));
            ft.setStore(ds);
            ft.setEnabled(true);
            setWorldBounds(ft);
            
            VirtualTable vt = new VirtualTable("requests_agg", 
                "SELECT ST_SetSRID(ST_MakePoint(remote_lon,remote_lat), 4326) as point," +
                        "remote_city,remote_country,count(*) as requests " + 
                 " FROM request " + 
              "GROUP BY point, remote_city, remote_country");
            vt.addGeometryMetadatata("point", Point.class, 4326);
            
            ft.getMetadata().put("JDBC_VIRTUAL_TABLE", vt);
            cat.add(ft);
            
            addLayer(cat, ft, "analytics_requests_agg");
            
            ft = cat.getFactory().createFeatureType();
            ft.setName("requests");
            ft.setNativeName("requests");
            ft.setNamespace(cat.getNamespaceByPrefix(ws.getName()));
            ft.setStore(ds);
            ft.setEnabled(true);
            setWorldBounds(ft);
            
            vt = new VirtualTable("requests", 
                "SELECT ST_SetSRID(ST_MakePoint(remote_lon,remote_lat), 4326) as point," +
                       "id, id as request_id, status, category, path, query_string, body_content_type, " +
                       "body_content_length, server_host, http_method, start_time, end_time, " +
                       "total_time, remote_address, remote_host, remote_user, remote_country, " +
                       "remote_city, service, operation, sub_operation, ows_version, content_type, " +
                       "response_length, error_message" + 
                 " FROM request");
            
            vt.addGeometryMetadatata("point", Point.class, 4326);
            vt.setPrimaryKeyColumns(Arrays.asList("id"));
            
            ft.getMetadata().put("JDBC_VIRTUAL_TABLE", vt);
            cat.add(ft);
            
            addLayer(cat, ft, "point");
        }
        
//        if (cat.getLayerGroupByName("requests") == null) {
//            LayerGroupInfo lg = cat.getFactory().createLayerGroup();
//            lg.setName("requests");
//            lg.getLayers().add(cat.getLayerByName("monitor:monitor_world"));
//            lg.getLayers().add(cat.getLayerByName("monitor:monitor_requests_agg"));
//            lg.setBounds(worldBounds());
//            
//            cat.add(lg);
//        }
    }
    
    void addStyle(Catalog cat, String name) throws Exception {
        GeoServerResourceLoader rl = cat.getResourceLoader();
        if (cat.getStyleByName(name) == null) {
            File sld = rl.find("styles", name + ".sld");
            if (sld == null) {
                rl.copyFromClassPath(name + ".sld",
                    rl.createFile("styles", name + ".sld"), getClass());
            }
            
            StyleInfo s = cat.getFactory().createStyle();
            s.setName(name);
            s.setFilename(name + ".sld");
            cat.add(s);
        }
    }

    void setParams(Map params, String url) {
        //jdbc:postgresql://localhost/geotools
        int i = url.indexOf("//") + 2;
        int j = url.indexOf('/', i);
        
        String host = url.substring(i, j);
        int port = -1;
        if (host.contains(":")) {
            port = Integer.parseInt(host.substring(host.indexOf(':')+1));
            host = host.substring(0, host.indexOf(':'));
        }
        
        String db = url.substring(j+1);
        params.put(JDBCDataStoreFactory.HOST.key, host);
        if (port != -1) {
            params.put(JDBCDataStoreFactory.PORT.key, port);
        }
        params.put(JDBCDataStoreFactory.DATABASE.key, db);
    }
    
    void setWorldBounds(FeatureTypeInfo ft) throws Exception {
        CoordinateReferenceSystem crs = CRS.decode("EPSG:4326");
        ft.setLatLonBoundingBox(new ReferencedEnvelope(-180, 180,-90, 90, crs));
        ft.setNativeBoundingBox(new ReferencedEnvelope(-180, 180, -90, 90, crs));
        ft.setNativeCRS(crs);
        ft.setSRS("EPSG:4326");
        ft.setProjectionPolicy(ProjectionPolicy.FORCE_DECLARED);
    }
    
    ReferencedEnvelope worldBounds() throws Exception {
        return new ReferencedEnvelope(-180, 180,-90, 90, CRS.decode("EPSG:4326"));
    }
    
    void addLayer(Catalog cat, FeatureTypeInfo ft, String style) {
        LayerInfo l = cat.getFactory().createLayer();
        l.setResource(ft);
        l.setType(LayerInfo.Type.VECTOR);
        l.setEnabled(true);
        l.setDefaultStyle(cat.getStyleByName(style));
        
        cat.add(l);
    }
}
