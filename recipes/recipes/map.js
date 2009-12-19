// the `map` variable is declared here for easy debugging
var map;

// this function is assigned to the window load event
function init() {

    // create a new map to be drawn in the page element with id "map-id"
    map = new OpenLayers.Map("map-id");
    
    // create a WMS layer and add it to the map
    var layer = new OpenLayers.Layer.WMS(
        "Global Imagery",
        "http://maps.opengeo.org/geowebcache/service/wms",
        {layers: "bluemarble"}
    );
    map.addLayer(layer);

    // set the map location
    map.zoomToMaxExtent();

}
