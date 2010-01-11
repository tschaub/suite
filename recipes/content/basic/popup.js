// the `panel` variable is declared here for easy debugging
var panel, popup;

Ext.onReady(function() {

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

    panel = new GeoExt.MapPanel({
        title: "MapPanel",
        renderTo: "map-id",
        height: 300,
        width: "100%",
        layers: [
            new OpenLayers.Layer.WMS(
                "Global Imagery",
                "http://maps.opengeo.org/geowebcache/service/wms",
                {layers: "openstreetmap"}
            ),
            features
        ],
        center: [-74, 40.8],
        zoom: 5
    });
    
    // create a control for selecting features
    var select = new OpenLayers.Control.SelectFeature(features);
    panel.map.addControl(select);
    select.activate();
    
    // register a listener for the feature selection and unselection
    features.events.on({
        featureselected: function(event) {
            // create an open a popup when a feature is selected
            popup = new GeoExt.Popup({
                title: "Popup",
                feature: event.feature,
                width: 200,
                collapsible: true,
                listeners: {
                    close: function() {
                        select.unselectAll();
                    }
                },
                bodyStyle: {padding: 5},
                html: "Popups can be expanded and collapsed like other windows. " +
                      "If attached to a feature, the popup will be dragged with " +
                      "the map when panning.  The popup can be unpinned from a " +
                      "feature using the pin tool above."
            });
            popup.show();
        },
        featureunselected: function(event) {
            // close (and destroy) the popup when the feature is unselected
            popup.close();
        }
    });
    

});