package org.geoserver.uploader;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.Serializable;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
import org.geoserver.catalog.Catalog;
import org.geoserver.catalog.CoverageStoreInfo;
import org.geoserver.catalog.LayerInfo;
import org.geoserver.catalog.ResourceInfo;
import org.geoserver.catalog.StoreInfo;
import org.geoserver.catalog.WorkspaceInfo;
import org.geoserver.config.GeoServerDataDirectory;
import org.geoserver.data.test.MockData;
import org.geoserver.platform.GeoServerResourceLoader;
import org.geoserver.rest.RestletException;
import org.geoserver.test.GeoServerTestSupport;
import org.geotools.data.shapefile.ShapefileDataStoreFactory;
import org.geotools.referencing.CRS;
import org.geotools.util.logging.Logging;
import org.restlet.data.Status;

public class ResourceUploaderTest extends GeoServerTestSupport {

    Catalog catalog;

    GeoServerDataDirectory dataDir;

    GeoServerResourceLoader resourceLoader;

    UploaderConfigPersister configPersister;

    ResourceUploader uploader;

    final String archsitesTestResource = "shapes/archsites_epsg_prj.zip";

    final String bugsitesTestResource = "shapes/bugsites_esri_prj.tar.gz";

    final String archsitesFileName = "archsites.zip";

    final String bugsitesFileName = "bugsites.tar.gz";

    FileItem archSitesFileItem;

    FileItem bugSitesFileItem;

    Map<String, Object> params;

    @Override
    protected boolean useLegacyDataDirectory() {
        return false;
    }

    @Override
    protected void populateDataDirectory(MockData dataDirectory) throws Exception {
        /*
         * deactivate the arcsde raster logger so it doesn't complain about the esri jars not being
         * on the classpath
         */
        Logging.getLogger("org.geotools.arcsde.ArcSDERasterFormatFactory").setLevel(Level.OFF);
        super.populateDataDirectory(dataDirectory);
        dataDirectory.addWcs11Coverages();
    }

    @Override
    public void setUpInternal() {
        catalog = getCatalog();
        dataDir = getDataDirectory();
        resourceLoader = getResourceLoader();
        configPersister = new UploaderConfigPersister(catalog, resourceLoader);
        uploader = new ResourceUploader(catalog, dataDir, configPersister);
        try {
            archSitesFileItem = fileItemMock(archsitesFileName, archsitesTestResource);
            bugSitesFileItem = fileItemMock(bugsitesFileName, bugsitesTestResource);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        params = new HashMap<String, Object>();

    }

    public void testNoFileProvided() throws Exception {
        try {
            uploader.uploadLayers(params);
            fail("Expected IAE");
        } catch (IllegalArgumentException e) {
            assertTrue(e.getMessage().contains("file"));
        }
    }

    public void testWrongWorkspaceParam() throws Exception {
        params.put("file", archSitesFileItem);
        params.put("workspace", "nonExistentWorkspace");
        try {
            uploader.uploadLayers(params);
            fail("Expected IAE");
        } catch (IllegalArgumentException e) {
            assertTrue(e.getMessage().contains("workspace"));
        }
    }

    public void testInexistentStoreParam() throws Exception {
        params.put("file", archSitesFileItem);
        params.put("workspace", catalog.getDefaultWorkspace().getName());
        params.put("store", "nonExistentStore");
        try {
            uploader.uploadLayers(params);
            fail("Expected IAE");
        } catch (IllegalArgumentException e) {
            assertTrue(e.getMessage().contains("store"));
        }
    }

    public void testFailIfRequestedStoreIsCoverageStore() throws Exception {

        List<CoverageStoreInfo> coverageStores = catalog.getCoverageStores();
        assertTrue(coverageStores.size() > 0);
        CoverageStoreInfo coverageStoreInfo = coverageStores.get(0);
        String workspace = coverageStoreInfo.getWorkspace().getName();
        String coverageStoreName = coverageStoreInfo.getName();

        params.put("file", archSitesFileItem);
        params.put("workspace", workspace);
        params.put("store", coverageStoreName);
        try {
            uploader.uploadLayers(params);
            fail("Expected IAE");
        } catch (RestletException e) {
            assertTrue(e.getRepresentation().getText().contains("store"));
            assertEquals(Status.CLIENT_ERROR_CONFLICT, e.getStatus());
        }
    }

    /**
     * A type comming with a .prj file that doesn't match an EPSG code should be run through
     * {@link CRS#lookupEpsgCode CRS#lookupEpsgCode(crsFromPrjFile, extensive == true)}
     */
    public void testLookUpSRS() throws Exception {
        System.out.println(CRS.decode("EPSG:26713").toWKT());
    }

    public void testUploadShpGeoServerDefaultWorkspace() throws Exception {
        params.put("file", archSitesFileItem);

        List<LayerInfo> layers = uploader.uploadLayers(params);
        assertNotNull(layers);
        assertEquals(1, layers.size());
        LayerInfo layerInfo = layers.get(0);
        assertNotNull(layerInfo);
        assertEquals("archsites", layerInfo.getName());
        assertNotNull(catalog.getLayerByName(layerInfo.getName()));

        final File uploaded = dataDir.findDataFile("incoming", "archsites", "archsites.shp");
        assertNotNull(uploaded);

        ResourceInfo resource = layerInfo.getResource();
        assertNotNull(resource);

        StoreInfo store = resource.getStore();
        String expectedType = new ShapefileDataStoreFactory().getDisplayName();
        assertEquals(expectedType, store.getType());
        Map<String, Serializable> connParams = store.getConnectionParameters();
        URL fileURL = (URL) connParams.get(ShapefileDataStoreFactory.URLP.key);
        assertNotNull(fileURL);
        File importedFile = new File(fileURL.toURI());
        assertEquals(uploaded.getAbsoluteFile(), importedFile.getAbsoluteFile());
        WorkspaceInfo workspace = store.getWorkspace();
        assertEquals(catalog.getDefaultWorkspace(), workspace);
    }

    public void testUploadShpUploaderDefaultWorkspace() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadShpUserSpecifiedWorkspace() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadShpUploadersDefaultDataStore() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadShpUserSpecifiedDataStore() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testCantUploadToExistingShpDataStore() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadShpMultipleTimesAssignsNewNames() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadCoverageDefaultWorkspace() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadCoverageUserSpecifiedWorkspace() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    public void testUploadCoverageNonExistentWorkspace() {
        LOGGER.log(Level.SEVERE, getName() + " is not implemented yet!");
    }

    /**
     * @param uploadFileTestResource
     *            name of the resource to mock as a FileItem that resides under
     *            {@code getClass().getPackage().getName() + "/test-data/}
     */
    private FileItem fileItemMock(final String uploadedFileName, final String uploadFileTestResource)
            throws IOException {
        InputStream in = getClass().getResourceAsStream("test-data/" + uploadFileTestResource);

        return fileMockUp(uploadedFileName, in);
    }

    private FileItem fileMockUp(String uploadFileName, InputStream uploadedData) throws IOException {
        String contentType = "application/zip";
        boolean isFormField = true;
        int sizeThreshold = 1024;
        File repository = new File("target");
        assertTrue(repository.exists());
        assertTrue(repository.isDirectory());
        assertTrue(repository.canWrite());
        // this is how you mock up a FileItem
        FileItem fileItem = new DiskFileItem("file", contentType, isFormField, uploadFileName,
                sizeThreshold, repository);
        OutputStream out = fileItem.getOutputStream();
        ByteArrayOutputStream buff = new ByteArrayOutputStream();
        IOUtils.copy(uploadedData, buff);
        out.write(buff.toByteArray());
        return fileItem;
    }

}
