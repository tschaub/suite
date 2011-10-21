package org.opengeo.data.importer.rest;

import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import net.sf.json.JSONArray;

import net.sf.json.JSONObject;
import net.sf.json.JSONSerializer;
import net.sf.json.util.JSONBuilder;

import org.apache.commons.io.IOUtils;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.FeatureTypeInfo;
import org.geoserver.catalog.LayerInfo;
import org.geoserver.catalog.ResourceInfo;
import org.geoserver.catalog.StoreInfo;
import org.geoserver.config.util.XStreamPersister;
import org.geoserver.config.util.XStreamPersisterFactory;
import org.geoserver.rest.PageInfo;
import org.opengeo.data.importer.Database;
import org.opengeo.data.importer.Directory;
import org.opengeo.data.importer.FileData;
import org.opengeo.data.importer.ImportContext;
import org.opengeo.data.importer.ImportData;
import org.opengeo.data.importer.ImportItem;
import org.opengeo.data.importer.ImportTask;
import org.opengeo.data.importer.Importer;
import org.opengeo.data.importer.SpatialFile;
import org.opengeo.data.importer.Table;
import org.opengeo.data.importer.transform.*;

/**
 * Utility class for reading/writing import/tasks/etc... to/from JSON.
 * 
 * @author Justin Deoliveira, OpenGeo
 */
public class ImportJSONIO {

    Importer importer;
    XStreamPersister xp;

    public ImportJSONIO(Importer importer) {
        this.importer = importer;
        xp = new XStreamPersisterFactory().createJSONPersister();
        xp.setReferenceByName(true);
        xp.setExcludeIds();
        xp.setCatalog(importer.getCatalog());
        xp.setHideFeatureTypeAttributes();
        // @todo this is copy-and-paste from org.geoserver.catalog.rest.FeatureTypeResource
        xp.setCallback(new XStreamPersister.Callback() {

            @Override
            protected void postEncodeFeatureType(FeatureTypeInfo ft,
                    HierarchicalStreamWriter writer, MarshallingContext context) {
                try {
                    writer.startNode("attributes");
                    context.convertAnother(ft.attributes());
                    writer.endNode();
                } catch (IOException e) {
                    throw new RuntimeException("Could not get native attributes", e);
                }
            }
        });
    }
    
    // allow tests to not require full importer
    public static ImportJSONIO createUnitTestImportJSONIO() {
        return new ImportJSONIO();
    }
    private ImportJSONIO() {
    }

    public void context(ImportContext context, PageInfo page, OutputStream out) throws IOException {
        FlushableJSONBuilder json = new FlushableJSONBuilder(new OutputStreamWriter(out));

        json.object().key("import");
        json.object();
        json.key("id").value(context.getId());
        json.key("state").value(context.getState());
        
        tasks(context.getTasks(), true, page, json);

        json.endObject();
        json.endObject();
        json.flush();
    }


    public void contexts(List<ImportContext> contexts, PageInfo page, OutputStream out) 
        throws IOException {
        
        contexts(contexts.iterator(), page, out);
    }

    public void contexts(Iterator<ImportContext> contexts, PageInfo page, OutputStream out)
            throws IOException {

        FlushableJSONBuilder json = new FlushableJSONBuilder(new OutputStreamWriter(out));
        json.object().key("imports").array();
        while (contexts.hasNext()) {
            ImportContext context = contexts.next();
            json.object()
              .key("id").value(context.getId())
              .key("href").value(page.pageURI("/" + context.getId()))
            .endObject();
        }
        json.endArray().endObject();
        json.flush();
    }

    public void tasks(List<ImportTask> tasks, PageInfo page, OutputStream out) throws IOException {
        tasks(tasks, page, builder(out));
    }

    public void tasks(List<ImportTask> tasks, PageInfo page, FlushableJSONBuilder json) throws IOException {
        tasks(tasks, false, page, json);
    }

    public void tasks(List<ImportTask> tasks, boolean inline, PageInfo page, FlushableJSONBuilder json) 
        throws IOException {
        if (!inline) {
            json.object();
        }
        json.key("tasks").array();
        for (ImportTask task : tasks) {
            task(task, true, page, json);
        }
        json.endArray();
        if (!inline) {
            json.endObject();
        }
        json.flush();
    }

    public void task(ImportTask task, PageInfo page, OutputStream out) throws IOException {
        task(task, page, builder(out));
    }

    public void task(ImportTask task, PageInfo page, FlushableJSONBuilder json) throws IOException {
        task(task, false, page, json);
    }
    
    public void task(ImportTask task, boolean inline, PageInfo page, FlushableJSONBuilder json) throws IOException {
        
        long id = task.getId();
       
        if (!inline) {
            json.object().key("task");
        }
        json.object();
        json.key("id").value(id);
        json.key("href").value(page.rootURI("/imports/" + task.getContext().getId() + "/tasks/" + id));
        json.key("state").value(task.getState());

        //source
        ImportData data = task.getData();
        json.key("source");
        data(data, page, json);

        //target
        StoreInfo store = task.getStore();
        if (store != null) {
            json.key("target").value(toJSON(store));
        }

        //items
        items(task.getItems(), true, page, json);

        json.endObject();
        if (!inline) {
            json.endObject();
        }

        json.flush();
    }

    public void item(ImportItem item, PageInfo page, OutputStream out) throws IOException {
        item(item, page, builder(out));
    }

    public void item(ImportItem item, PageInfo page, FlushableJSONBuilder json) throws IOException {
        item(item, false, page, json);
    }
    
    public void item(ImportItem item, boolean inline, PageInfo page, FlushableJSONBuilder json) throws IOException {
        long id = item.getId();
        ImportTask task = item.getTask();
        
        LayerInfo layer = item.getLayer();
        if (!inline) {
            json.object().key("item");
        }

        // @todo don't know why catalog isn't set here, thought this was set during load from BDBImportStore
        layer.getResource().setCatalog(importer.getCatalog());
        
        json.object()
          .key("id").value(id)
          .key("href").value(page.rootURI(String.format("/imports/%d/tasks/%d/items/%d", 
              task.getContext().getId(), task.getId(), id)))
          .key("state").value(item.getState())
          .key("resource").value(toJSON(layer.getResource()))
          .key("layer").value(toJSON(layer));
        if (item.getError() != null) {
            json.key("errorMessage").value(concatErrorMessages(item.getError()));
        }
        json.key("transformChain");
        transformChain(item.getTransform(), json);
        json.endObject();

        if (!inline) {
            json.endObject();
        }
        json.flush();
    }
    
    String concatErrorMessages(Throwable ex) {
        StringBuilder buf = new StringBuilder();
        while (ex != null) {
            if (buf.length() > 0) {
                buf.append('\n');
            }
            if (ex.getMessage() != null) {
                buf.append(ex.getMessage());
            }
            ex = ex.getCause();
        }
        return buf.toString();
    }

    public void items(List<ImportItem> items, PageInfo page, OutputStream out) throws IOException {
        items(items, page, builder(out));
    }

    public void items(List<ImportItem> items, PageInfo page, FlushableJSONBuilder json) throws IOException {
        items(items, false, page, json);
    }

    public void items(List<ImportItem> items, boolean inline, PageInfo page, FlushableJSONBuilder json) 
        throws IOException {
        if (!inline) {
            json.object();
        }
        json.key("items").array();

        Iterator<ImportItem> it = items.iterator();
        while (it.hasNext()) {
            ImportItem item = it.next();
            item(item, true, page, json);
        }
        json.endArray();
        if (!inline) {
            json.endObject();
        }
        json.flush();
    }
    
    public ImportTask task(InputStream in) throws IOException {
        JSONObject json = parse(in);
        ImportTask task = null;
        if (json.has("task")) {
            task = new ImportTask();
            
            json = json.getJSONObject("task");
            
            if (json.has("id")) {
                task.setId(json.getInt("id"));
            }
            if (json.has("target")) {
                JSONObject x = json.getJSONObject("target");
                task.setStore(fromJSON(json.getJSONObject("target"), DataStoreInfo.class));
            }
            if (json.has("items")) {
                JSONArray items = json.getJSONArray("items");
                for (int i = 0; i < items.size(); i++) {
                    task.addItem(item(items.getJSONObject(i)));
                }
            }
        }
        return task;
    }

    public ImportItem item(InputStream in) throws IOException {
        return item(parse(in));
    }
    public ImportItem item(JSONObject json) throws IOException {
        if (json.has("item")) {
            json = json.getJSONObject("item");
        }

        LayerInfo layer = null; 
        if (json.has("layer")) {
            layer = fromJSON(json.getJSONObject("layer"), LayerInfo.class);
        } else {
            layer = importer.getCatalog().getFactory().createLayer();
        }
        
        ImportItem importItem = new ImportItem(layer);

        //parse the resource if specified
        if (json.has("resource")) {
            ResourceInfo resource = fromJSON(json.getJSONObject("resource"), ResourceInfo.class);
            layer.setResource(resource);
        }
        
        if (json.has("transformChain")) {
            importItem.setTransform(transformChain(json.getJSONObject("transformChain")));
        }

        //parse the layer if specified
        return importItem;
    }
    
    public TransformChain transformChain(JSONObject json) throws IOException {
        String type = json.getString("type");
        TransformChain chain = null;
        if ("VectorTransformChain".equalsIgnoreCase(type)) {
            chain = new VectorTransformChain();
        } else if ("RasterTransformChain".equalsIgnoreCase(type)) {
            chain = new RasterTransformChain();
        } else {
            throw new IOException("Unable to parse transformChain of type " + type);
        }
        JSONArray transforms = json.getJSONArray("transforms");
        for (int i = 0; i < transforms.size(); i++) {
            chain.add(importTransform(transforms.getJSONObject(i)));
        }
        return chain;
    }
    
    public ImportTransform importTransform(JSONObject json) throws IOException {
        ImportTransform transform;
        String type = json.getString("type");
        if ("DateFormatTransform".equalsIgnoreCase(type)) {
            DateFormatTransform trans = new DateFormatTransform(json.getString("field"), json.optString("format", null));
            transform = trans;
        } if ("IntegerFieldToDateTransform".equalsIgnoreCase(type)) {
            IntegerFieldToDateTransform trans = new IntegerFieldToDateTransform(json.getString("field"));
            transform = trans;
        } else {
            throw new RuntimeException("parsing of " + type + " not implemented");
        }
        return transform;
    }
    
    public void data(ImportData data, PageInfo page, OutputStream out) throws IOException {
        data(data, page, builder(out));
    }

    public void data(ImportData data, PageInfo page, JSONBuilder json) throws IOException {
        if (data instanceof FileData) {
            if (data instanceof Directory) {
                directory((Directory) data, page, json);
            } else {
                file((FileData) data, page, json);
            }
        } else if (data instanceof Database) {
            database((Database) data, page, json);
        }
    }

    public void file(FileData data, PageInfo page, OutputStream out) throws IOException {
        file(data, page, builder(out));
    }

    public void file(FileData data, PageInfo page, JSONBuilder json) throws IOException {
        json.object();
        
        json.key("type").value("file");
        json.key("format").value(data.getFormat() != null ? data.getFormat().getName() : null);
        json.key("location").value(data.getFile().getParentFile().getPath());

        fileContents(data, json);

        json.endObject();
    }

    void fileContents(FileData data, JSONBuilder json) throws IOException {
        json.key("file").value(data.getFile().getName());

        if (data instanceof SpatialFile) {
            SpatialFile sf = (SpatialFile) data;
            json.key("prj").value(sf.getPrjFile() != null ? sf.getPrjFile().getName() : null);
            json.key("other").array();
            for (File supp : ((SpatialFile) data).getSuppFiles()) {
                json.value(supp.getName());
            }
            json.endArray();
        }
    }

    public void directory(Directory data, PageInfo page, OutputStream out) throws IOException {
        directory(data, page, builder(out));
    }

    public void directory(Directory data, PageInfo page, JSONBuilder json) throws IOException {
        json.object();
        json.key("type").value("directory");
        json.key("format").value(data.getFormat() != null ? data.getFormat().getName() : null);
        json.key("location").value(data.getFile().getPath());
        json.key("files").array();
        
        for (FileData file : data.getFiles()) {
            json.object();
            fileContents(file, json);
            json.endObject();
        }
        json.endArray();

        json.endObject();
    }

    public void database(Database data, PageInfo page, OutputStream out) throws IOException {
        database(data, page, builder(out));
    }

    public void database(Database data, PageInfo page, JSONBuilder json) throws IOException {
        json.object();
        json.key("type").value("database");
        json.key("format").value(data.getFormat() != null ? data.getFormat().getName() : null);

        json.key("parameters").object();
        for (Map.Entry e : data.getParameters().entrySet()) {
            json.key((String) e.getKey()).value(e.getValue());
        }

        json.endObject();
        
        json.key("tables").array();
        for (Table t : data.getTables()) {
            json.value(t.getName());
        }
        json.endArray();

        json.endObject();
    }

    FlushableJSONBuilder builder(OutputStream out) {
        return new FlushableJSONBuilder(new OutputStreamWriter(out));
    }

    JSONObject toJSON(Object o) throws IOException {
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        xp.save(o, out);
        return (JSONObject) JSONSerializer.toJSON(new String(out.toByteArray()));
    }

    <T> T fromJSON(JSONObject json, Class<T> clazz) throws IOException {
        return (T) xp.load(new ByteArrayInputStream(json.toString().getBytes()), clazz);
    }

    JSONObject parse(InputStream in) throws IOException {
        ByteArrayOutputStream bout = new ByteArrayOutputStream();
        IOUtils.copy(in, bout);
        return JSONObject.fromObject(new String(bout.toByteArray()));
    }
    
    Object read(InputStream in) throws IOException {
        Object result = null;
        JSONObject json = parse(in);
        // @hack - this should return a ImportTask
        if (json.containsKey("target")) {
            result = fromJSON(json.getJSONObject("target"), DataStoreInfo.class);
        }
        return result;
    }

    void transformChain(TransformChain transform, JSONBuilder json) throws IOException {
        json.object();
        json.key("type").value(transform.getClass().getSimpleName());
        json.key("transforms");
        json.array();
        for (int i = 0; i < transform.getTransforms().size(); i++) {
            importTransform( (ImportTransform) transform.getTransforms().get(i), json);
        }
        json.endArray();
        json.endObject();
    }

    public void importTransform(ImportTransform transform, JSONBuilder json) throws IOException {
        json.object();
        json.key("type").value(transform.getClass().getSimpleName());
        if (transform instanceof DateFormatTransform) {
            DateFormatTransform df = (DateFormatTransform) transform;
            json.key("field").value(df.getField());
            if (df.getDateFormat() != null) {
                json.key("format").value(df.getDateFormat().toPattern()); 
            }
        } if (transform instanceof IntegerFieldToDateTransform) {
            IntegerFieldToDateTransform df = (IntegerFieldToDateTransform) transform;
            json.key("field").value(df.getField());
        } else {
            throw new IOException("Serializaiton of " + transform.getClass() + " not implemented");
        }
        json.endObject();
    }

    public static class FlushableJSONBuilder extends JSONBuilder {

        public FlushableJSONBuilder(Writer w) {
            super(w);
        }

        public void flush() throws IOException {
            writer.flush();
        }
    }
}
