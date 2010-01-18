// the `panel` and `grid` variables are declared here for easy debugging
var panel, grid;

Ext.onReady(function() {

    panel = new GeoExt.MapPanel({
        title: "MapPanel",
        renderTo: "map-id",
        layers: [
            new OpenLayers.Layer.WMS(
                "Global Imagery",
                "http://maps.opengeo.org/geowebcache/service/wms",
                {layers: "bluemarble"}
            ),
            new OpenLayers.Layer.WMS(
                "State Boundaries",
                "http://maps.opengeo.org/geowebcache/service/wms",
                {layers: "topp:states", format: "image/png"}
            )
        ],
        center: [-120, 48],
        zoom: 5
    });
    
    grid = new Ext.grid.GridPanel({
        renderTo: "grid-id",
        height: 100,
        store: panel.layers,
        columns: [{
            header: 'Layer',
            id: 'title',
            dataIndex: 'title',
            width: 150
        }]
    });
    
});