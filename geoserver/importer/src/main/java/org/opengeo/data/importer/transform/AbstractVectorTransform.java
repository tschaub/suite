package org.opengeo.data.importer.transform;

public abstract class AbstractVectorTransform implements VectorTransform {

    public boolean stopOnError(Exception e) {
        return true;
    }

}
