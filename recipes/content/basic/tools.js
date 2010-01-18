// the `panel` variable is declared here for easy debugging
var panel;

Ext.onReady(function() {
    
    // display tooltips for actions
    Ext.QuickTips.init();

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

    // create an action that zooms map to max extent (no map control needed)
    var zoom = new Ext.Action({
        text: "Zoom Full",
        handler: function() {
            panel.map.zoomToMaxExtent();
        },
        tooltip: "zoom to full extent"
    });
    
    // create an action tied to a navigation control
    var navigate = new GeoExt.Action({
        text: "Navigate",
        control: new OpenLayers.Control.Navigation(),
        map: panel.map,
        // button options
        toggleGroup: "group1",  // only one tool can be active in a group
        allowDepress: false,
        pressed: true,
        tooltip: "navigate"
    });
    
    // create an action tied to a measure control
    var measure = new GeoExt.Action({
        text: "Measure",
        control: new OpenLayers.Control.Measure(OpenLayers.Handler.Path, {
            geodesic: true,
            eventListeners: {
                measure: function(event) {
                    var win = new Ext.Window({
                        title: "Measure Resuls",
                        modal: true,
                        constrain: true,
                        bodyStyle: {padding: 10},
                        html: event.measure + " " + event.units
                    });
                    win.show();
                }
            }
        }),
        map: panel.map,
        // button options
        toggleGroup: "group1",  // only one tool can be active in a group
        allowDepress: false,
        tooltip: "measure distance"
    });
    
    // add a toolbar with the above actions as buttons
    var toolbar = new Ext.Toolbar({
        renderTo: "tbar-id",
        items: [zoom, "-", navigate, measure]
    });


});
