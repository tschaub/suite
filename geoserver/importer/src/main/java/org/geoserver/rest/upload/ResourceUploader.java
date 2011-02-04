package org.geoserver.rest.upload;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.CoverageStoreInfo;
import org.geoserver.catalog.DataStoreInfo;
import org.geoserver.catalog.LayerInfo;
import org.geoserver.catalog.StoreInfo;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.config.GeoServerDataDirectory;
import org.geoserver.ows.util.ResponseUtils;
import org.geoserver.rest.RestletException;
import org.geoserver.rest.util.RESTUtils;
import org.geotools.util.logging.Logging;
import org.json.JSONException;
import org.json.JSONObject;
import org.restlet.Restlet;
import org.restlet.data.MediaType;
import org.restlet.data.Method;
import org.restlet.data.Request;
import org.restlet.data.Response;
import org.restlet.data.Status;
import org.restlet.ext.fileupload.RestletFileUpload;

public class ResourceUploader extends Restlet {

    private static final Logger LOGGER = Logging.getLogger(ResourceUploader.class);

    private Catalog catalog;

    private GeoServerDataDirectory dataDir;

    public ResourceUploader(Catalog catalog, GeoServerDataDirectory dataDir) {
        this.catalog = catalog;
        this.dataDir = dataDir;
    }

    @Override
    public void handle(Request request, Response response) {
        super.init(request, response);

        if (Method.POST.equals(request.getMethod())) {
            handlePost(request, response);
            return;
        }

        response.setStatus(Status.CLIENT_ERROR_METHOD_NOT_ALLOWED);
    }

    private void handlePost(Request request, Response response) {
        final MediaType requestMediaType = request.getEntity().getMediaType();
        final boolean ignoreParameters = true;
        if (!MediaType.MULTIPART_FORM_DATA.equals(requestMediaType, ignoreParameters)) {
            response.setStatus(Status.CLIENT_ERROR_UNSUPPORTED_MEDIA_TYPE);
            return;
        }

        JSONObject result = new JSONObject();

        try {
            JSONObject tmpresult = new JSONObject();
            tmpresult.put("success", Boolean.TRUE);

            List<LayerInfo> importedLayers = importLayer(request, response);

            for (LayerInfo importedLayer : importedLayers) {
                JSONObject layerResult = new JSONObject();

                final String qname = importedLayer.getResource().getPrefixedName();
                final String encodedQname = ResponseUtils.urlEncode(qname);
                layerResult.put("name", qname);

                String uri = RESTUtils.getBaseURL(request);
                uri = ResponseUtils.appendPath(uri, "layers", encodedQname + ".json");
                layerResult.put("href", uri);

                tmpresult.append("layers", layerResult);
            }

            result = tmpresult;

            response.setStatus(Status.SUCCESS_OK);
        } catch (RestletException e) {
            response.setStatus(e.getStatus());
            try {
                result.put("success", Boolean.FALSE);
                String text = e.getRepresentation().getText();
                result.put("message", "" + text);
            } catch (Exception jse) {
                throw new RestletException("Internal error", Status.SERVER_ERROR_INTERNAL, jse);
            }
        } catch (Exception e) {
            response.setStatus(Status.SERVER_ERROR_INTERNAL);
            try {
                result.put("success", Boolean.FALSE);
                result.put("message", "" + e.getMessage());
            } catch (JSONException jse) {
                throw new RestletException("Internal error", Status.SERVER_ERROR_INTERNAL, jse);
            }
        }

        String responseContents = result.toString();
        response.setEntity(responseContents, MediaType.TEXT_HTML);
    }

    private List<LayerInfo> importLayer(Request request, Response response) throws Exception {

        RestletFileUpload rfu = new RestletFileUpload();
        DiskFileItemFactory fileItemFactory = new DiskFileItemFactory();
        rfu.setFileItemFactory(fileItemFactory);
        List<FileItem> items;
        try {
            items = rfu.parseRequest(request);
        } catch (FileUploadException e) {
            throw new RestletException(request.getEntity(), Status.SERVER_ERROR_INTERNAL, e);
        }

        Map<String, Object> params = getRequestParams(items);
        FileItem fileItem = (FileItem) params.get("file");

        final String fileItemName = fileItem.getName();
        final File targetDirectory = createTargetDirectory(fileItemName);

        List<LayerInfo> importedLayers = new ArrayList<LayerInfo>();

        try {
            LayerInfo importedLayer;
            List<File> spatialFiles = doFileUpload(fileItem, targetDirectory);
            final WorkspaceInfo targetWorkspace = getTargetWorkspace(params);
            final DataStoreInfo targetDataStore = getTargetDataStore(targetWorkspace, params);

            for (File spatialFile : spatialFiles) {
                LayerImporter importer = findImporter(targetWorkspace, targetDataStore, spatialFile);
                importer.setTitle((String) params.get("title"));
                importer.setAbstract((String) params.get("abstract"));

                importedLayer = importer.importFromFile(spatialFile);
                importedLayers.add(importedLayer);
            }

            boolean canDeleteUploadedFiles = targetDataStore != null;
            if (canDeleteUploadedFiles) {
                delete(targetDirectory);
            }
        } catch (Exception e) {
            LOGGER.log(Level.WARNING, "Error uploading and configuring layer for " + params, e);
            FileUtils.deleteDirectory(targetDirectory);
            throw e;
        } finally {
            try {
                fileItem.delete();
            } catch (RuntimeException e) {
                LOGGER.log(Level.INFO, "", e);
            }
        }
        return importedLayers;
    }

    private List<File> doFileUpload(FileItem fileItem, final File targetDirectory) throws Exception {
        final File uploaded = new File(targetDirectory, fileItem.getName());
        fileItem.write(uploaded);

        List<File> spatialFiles;
        VFSWorker vfs = new VFSWorker();
        if (vfs.canHandle(uploaded)) {
            vfs.extractTo(uploaded, targetDirectory);
            spatialFiles = findSpatialFile(targetDirectory);
            uploaded.delete();
            if (spatialFiles.size() == 0) {
                throw new IllegalArgumentException(
                        "No spatial data file provided in uploaded archive");
            }
        } else {
            spatialFiles = Collections.singletonList(uploaded);
        }
        return spatialFiles;
    }

    private File createTargetDirectory(final String fileItemName) throws IOException {
        final File incomingDirectory = dataDir.findOrCreateDataDir("data", "incoming");

        final File targetDirectory = ensureUniqueDirectory(incomingDirectory,
                FilenameUtils.getBaseName(fileItemName));
        targetDirectory.mkdirs();
        return targetDirectory;
    }

    private LayerImporter findImporter(final WorkspaceInfo targetWorkspace,
            final DataStoreInfo targetDataStore, File spatialFile) {
        LayerImporter importer;
        if (FeatureTypeImporter.canHandle(spatialFile)) {
            importer = new FeatureTypeImporter(catalog, targetWorkspace, targetDataStore);
        } else if (CoverageImporter.canHandle(spatialFile)) {
            importer = new CoverageImporter(catalog, targetWorkspace);
        } else {
            throw new IllegalArgumentException(spatialFile.getName()
                    + " is not recognized as a supported spatial file");
        }
        return importer;
    }

    private void delete(File directory) throws IOException {
        FileUtils.deleteDirectory(directory);
    }

    private WorkspaceInfo getTargetWorkspace(Map<String, Object> params) {
        String workspaceId = (String) params.get("workspace");
        WorkspaceInfo workspaceInfo;
        if (null == workspaceId || workspaceId.trim().length() == 0) {
            workspaceInfo = catalog.getDefaultWorkspace();
            if (workspaceInfo == null) {
                throw new IllegalArgumentException("There's no default workspace. "
                        + "Create a Workspace before uploading data");
            }
        } else {
            workspaceInfo = catalog.getWorkspaceByName(workspaceId);
            if (null == workspaceInfo) {
                throw new IllegalArgumentException("Provided workspace does not exist: "
                        + workspaceId);
            }
        }
        return workspaceInfo;
    }

    private DataStoreInfo getTargetDataStore(WorkspaceInfo targetWorkspace,
            Map<String, Object> params) {

        String storeId = (String) params.get("store");
        StoreInfo storeInfo = null;
        if (null != storeId && storeId.trim().length() > 0) {
            storeInfo = catalog.getStoreByName(targetWorkspace, storeId, StoreInfo.class);
            if (storeInfo == null) {
                throw new RestletException("Specified store '" + storeId
                        + "' not found in workspace " + targetWorkspace.getName(),
                        Status.CLIENT_ERROR_BAD_REQUEST);
            }
            if (storeInfo instanceof CoverageStoreInfo) {
                throw new RestletException(
                        "Specified store '"
                                + storeId
                                + "' at workspace '"
                                + targetWorkspace.getName()
                                + "' is a Coverage store. It is not possible to post to existing CoverageStores.",
                        Status.CLIENT_ERROR_CONFLICT);
            }
        }
        return (DataStoreInfo) storeInfo;
    }

    private File ensureUniqueDirectory(final File baseDirectory, final String temptativeName) {
        String uniqueName = temptativeName;
        int tries = 0;
        while (new File(baseDirectory, uniqueName).exists()) {
            tries++;
            uniqueName = temptativeName + "_" + tries;
        }
        return new File(baseDirectory, uniqueName);
    }

    private List<File> findSpatialFile(File targetDirectory) {

        File[] files = targetDirectory.listFiles(new FileFilter() {
            public boolean accept(File pathname) {
                if (pathname.isDirectory()) {
                    return true;
                }
                boolean canHandle = FeatureTypeImporter.canHandle(pathname)
                        || CoverageImporter.canHandle(pathname);
                return canHandle;
            }
        });

        List<File> spatialFiles = new ArrayList<File>(files.length);
        List<File> subdirs = new ArrayList<File>(2);
        for (File f : files) {
            if (f.isDirectory()) {
                subdirs.add(f);
            } else {
                spatialFiles.add(f);
            }
        }
        for (File subdir : subdirs) {
            spatialFiles.addAll(findSpatialFile(subdir));
        }

        return spatialFiles;
    }

    private Map<String, Object> getRequestParams(List<FileItem> items) {
        Map<String, Object> params = new HashMap<String, Object>();
        for (FileItem item : items) {
            if (item.isFormField()) {
                params.put(item.getFieldName(), item.getString());
            } else {
                if (item.getFieldName().equals("file")) {
                    params.put("file", item);
                }
            }
        }
        return params;
    }
}
