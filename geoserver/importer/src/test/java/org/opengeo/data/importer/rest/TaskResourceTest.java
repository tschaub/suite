package org.opengeo.data.importer.rest;

import java.io.ByteArrayOutputStream;
import java.io.File;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.opengeo.data.importer.Directory;
import org.opengeo.data.importer.ImportContext;
import org.opengeo.data.importer.ImportTask;
import org.opengeo.data.importer.ImporterTestSupport;

import com.mockrunner.mock.web.MockHttpServletRequest;
import com.mockrunner.mock.web.MockHttpServletResponse;
import java.io.IOException;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import org.geoserver.catalog.impl.DataStoreInfoImpl;
import org.geotools.data.Transaction;
import org.geotools.jdbc.JDBCDataStore;
import org.opengeo.data.importer.transform.CreateIndexTransform;

public class TaskResourceTest extends ImporterTestSupport {
    JDBCDataStore jdbcStore;

    @Override
    protected void setUpInternal() throws Exception {
        super.setUpInternal();
    
        File dir = unpack("shape/archsites_epsg_prj.zip");
        unpack("geotiff/EmissiveCampania.tif.bz2", dir);
        importer.createContext(new Directory(dir));
        
        // @todo clean this up to use a better technique
        DataStoreInfoImpl postgis = new DataStoreInfoImpl(getCatalog());
        postgis.setName("postgis");
        postgis.setType("PostGIS");
        postgis.setEnabled(true);
        postgis.setWorkspace(getCatalog().getDefaultWorkspace());
        Map<String,Serializable> params = new HashMap<String, Serializable>();
        params.put("port",5432);
        params.put("passwd","postgres");
        params.put("dbtype","postgis");
        params.put("host","localhost");
        params.put("database","mapstory");
        params.put("namespace", "http://geonode.org");
        params.put("schema", "public");
        params.put("user", "postgres");
        postgis.setConnectionParameters(params);
        getCatalog().add(postgis);
        try {
            jdbcStore = (JDBCDataStore) postgis.getDataStore(null);
            jdbcStore.getConnection(Transaction.AUTO_COMMIT).createStatement().execute("drop table if exists archsites");
        } catch (IOException ioe) {
            LOGGER.log(Level.WARNING,"Could not initialize postgis db",ioe);
        }
    }

    public void testUploadToPostGIS() throws Exception {
        if (jdbcStore == null) return;
        
        testPostMultiPartFormData();
        
        JSONObjectBuilder builder = new JSONObjectBuilder();
        builder.object().key("task").object()
          .key("target").object()
            .key("dataStore").object()
              .key("name").value("postgis")
              .key("workspace").object()
                .key("name").value(getCatalog().getDefaultWorkspace().getName())
              .endObject()
            .endObject()
          .endObject()
        .endObject().endObject();
                
        String payload = builder.buildObject().toString();
        
        MockHttpServletResponse resp = putAsServletResponse("/rest/imports/0/tasks/0", payload, "application/json");
        assertEquals(204,resp.getStatusCode());
        
        // @todo formalize and extract this test
        ImportContext context = importer.getContext(0);
        context.getTasks().get(0).getItems().get(0).getTransform().add(new CreateIndexTransform("CAT_ID"));
        importer.changed(context);
        
        resp = postAsServletResponse("/rest/imports/0","","application/text");        
        assertEquals(204,resp.getStatusCode());
        
        // ensure item ran successfully
        JSONObject json = (JSONObject) getAsJSON("/rest/imports/0/tasks/0/items/0");
        json = json.getJSONObject("item");
        assertEquals("COMPLETE",json.get("state"));
        
        json = (JSONObject) getAsJSON("/rest/workspaces/" + getCatalog().getDefaultWorkspace().getName() + "/datastores/postgis/featuretypes.json");
        // make sure the new feature type exists
        JSONObject featureTypes = (JSONObject) json.get("featureTypes");
        JSONArray featureType = (JSONArray) featureTypes.get("featureType");
        JSONObject type = (JSONObject) featureType.get(0);
        assertEquals("archsites",type.getString("name"));
        
        // @todo do it again and ensure feature type is created
        // correctly w/ auto-generated name 
    }

    public void testGetAllTasks() throws Exception {
        JSONObject json = (JSONObject) getAsJSON("/rest/imports/0/tasks");

        JSONArray tasks = json.getJSONArray("tasks");
        assertEquals(2, tasks.size());

        JSONObject task = tasks.getJSONObject(0);
        assertEquals(0, task.getInt("id"));
        assertTrue(task.getString("href").endsWith("/imports/0/tasks/0"));
        
        task = tasks.getJSONObject(1);
        assertEquals(1, task.getInt("id"));
        assertTrue(task.getString("href").endsWith("/imports/0/tasks/1"));
    }

    public void testGetTask() throws Exception {
        JSONObject json = (JSONObject) getAsJSON("/rest/imports/0/tasks/0");
        JSONObject task = json.getJSONObject("task");
        assertEquals(0, task.getInt("id"));
        assertTrue(task.getString("href").endsWith("/imports/0/tasks/0"));
    }

    public void testPostMultiPartFormData() throws Exception {
        MockHttpServletResponse resp = postAsServletResponse("/rest/imports", "");
        assertEquals(201, resp.getStatusCode());
        assertNotNull(resp.getHeader("Location"));

        String[] split = resp.getHeader("Location").split("/");
        Integer id = Integer.parseInt(split[split.length-1]);
        ImportContext context = importer.getContext(id);
        assertNull(context.getData());
        assertTrue(context.getTasks().isEmpty());

        File dir = unpack("shape/archsites_epsg_prj.zip");
        
        Part[] parts = new Part[]{new FilePart("archsites.shp", new File(dir, "archsites.shp")), 
            new FilePart("archsites.dbf", new File(dir, "archsites.dbf")), 
            new FilePart("archsites.shx", new File(dir, "archsites.shx")), 
            new FilePart("archsites.prj", new File(dir, "archsites.prj"))};

        MultipartRequestEntity multipart = 
            new MultipartRequestEntity(parts, new PostMethod().getParams());

        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        multipart.writeRequest(bout);

        MockHttpServletRequest req = createRequest("/rest/imports/" + id + "/tasks");
        req.setContentType(multipart.getContentType());
        req.addHeader("Content-Type", multipart.getContentType());
        req.setMethod("POST");
        req.setBodyContent(bout.toByteArray());
        resp = dispatch(req);

        context = importer.getContext(context.getId());
        assertNull(context.getData());
        assertEquals(1, context.getTasks().size());

        ImportTask task = context.getTasks().get(0);
        assertTrue(task.getData() instanceof Directory);
        assertEquals(ImportTask.State.READY, task.getState());
    }
}
