package org.opengeo.shapegen;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Random;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.geotools.data.FeatureWriter;
import org.geotools.data.Transaction;
import org.geotools.data.shapefile.ShapefileDataStore;
import org.geotools.feature.simple.SimpleFeatureTypeBuilder;
import org.geotools.referencing.CRS;
import org.opengis.feature.simple.SimpleFeature;
import org.opengis.feature.simple.SimpleFeatureType;

import com.vividsolutions.jts.geom.Coordinate;
import com.vividsolutions.jts.geom.GeometryFactory;
import com.vividsolutions.jts.geom.Point;

public class ShapefileGenerator {

    public static void main(String[] args) throws Exception {
        File dest = new File("shapefiles");
        if (!dest.exists()) {
            dest.mkdir();
        }
        else {
            if (dest.listFiles().length > 0) {
                System.err.print(String.format("Directory %s already exists and is not empty", 
                    dest.getName()));
                System.exit(1);
            }
        }

        Random ran = new Random();
        GeometryFactory gfac = new GeometryFactory();
        
        SimpleFeatureTypeBuilder tb = new SimpleFeatureTypeBuilder();
        tb.setName("shp");
        tb.setCRS(CRS.decode("epsg:4326"));
        tb.add("geometry", Point.class);
        tb.add("index", Integer.class);
        
        SimpleFeatureType proto = tb.buildFeatureType();
        
        int ngroups = 5;
        int n = 100; int m = 1000;
        
        for (int k = 0; k < ngroups; k++) {
           File dir = new File(dest, k+"");
           dir.mkdir();
           
           for (int i = 0; i < n; i++) {
                String name = "shp_"+k+"_"+i;
               
                File file = new File(dir, name+".shp");
                
                System.out.println("Creating shapefile " + file.getAbsolutePath());
                
                ShapefileDataStore ds = new ShapefileDataStore(file.toURL());
                tb.init(proto);
                tb.setName(name);
                ds.createSchema(tb.buildFeatureType());
                
                FeatureWriter fw = ds.getFeatureWriterAppend(name, Transaction.AUTO_COMMIT);
                for (int j = 0; j < m; j++) {
                    fw.hasNext();
                    SimpleFeature f = (SimpleFeature)fw.next();
                    f.setDefaultGeometry(gfac.createPoint(new Coordinate(nextFloat(ran, -180, 180), 
                        nextFloat(ran, -90, 90))));
                    f.setAttribute("index", j);
                    fw.write();
                }
                fw.close();
                
                zip(dir, name);
            }
        }
    }
    
    static float nextFloat(Random ran, float lower, float higher) {
        float f = ran.nextFloat() * (higher - lower);
        return f - ((higher - lower) / 2f);
    }
    
    static void zip(File dir, String base) throws Exception {
        ZipOutputStream zout = new ZipOutputStream(new BufferedOutputStream(
            new FileOutputStream(new File(dir, base+".zip"))));
        
        String[] exts = new String[]{"shp", "shx", "dbf", "prj"};
        for (String ext : exts) {
            File f = new File(dir, base+"."+ext);
            FileInputStream fin = new FileInputStream(f);
           
            zout.putNextEntry(new ZipEntry(f.getName()));
            IOUtils.copy(fin, zout);
            zout.closeEntry();
            
            fin.close();
        }
        
        zout.flush();
        zout.close();
    }
}
