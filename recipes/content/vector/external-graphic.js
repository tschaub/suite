// the `map` variable is declared here for easy debugging
var map;

// this function is assigned to the window load event
function init() {

    map = new OpenLayers.Map("map-id");
    
    var layer = new OpenLayers.Layer.WMS(
        "Global Imagery",
        "http://maps.opengeo.org/geowebcache/service/wms",
        {layers: "openstreetmap"}
    );
    map.addLayer(layer);
    
    // create a style with the symbolizer for your point features
    var style = new OpenLayers.Style({
        externalGraphic: "../data/opengeo-logo.png",
        pointRadius: 10
    });
    
    // create a vector layer that will contain features
    var features = new OpenLayers.Layer.Vector("Features", {
        styleMap: new OpenLayers.StyleMap(style)
    });
    // create a feature with a point geometry and add to the layer
    var feature = new OpenLayers.Feature.Vector(
        new OpenLayers.Geometry.Point(-74, 40.8)
    );
    features.addFeatures([feature]);
    map.addLayer(features);

    // set the map location
    map.zoomToMaxExtent();
   
}