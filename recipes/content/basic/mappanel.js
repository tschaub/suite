// the `panel` variable is declared here for easy debugging
var panel;

Ext.onReady(function() {

    panel = new GeoExt.MapPanel({
        title: "MapPanel",
        renderTo: "map-id",
        height: 300,
        width: "100%",
        layers: [
            new OpenLayers.Layer.WMS(
                "Global Imagery",
                "http://maps.opengeo.org/geowebcache/service/wms",
                {layers: "bluemarble"}
            )
        ],
        center: [-120, 48],
        zoom: 5
    });

});