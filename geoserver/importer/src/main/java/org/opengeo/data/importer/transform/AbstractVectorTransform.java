package org.opengeo.data.importer.transform;

public abstract class AbstractVectorTransform implements VectorTransform {

    private static final long serialVersionUID = 1L;
    
    public boolean stopOnError(Exception e) {
        return true;
    }
    
    /**
     * Make subclassing less onerous. If an implementation has temporary or transient state,
     * this method allows a hook to create that.
     */
    public void init() {
        // do nothing
    }

}
