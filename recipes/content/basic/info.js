// the `panel` and `popup` variables are declared here for easy debugging
var panel, popup;

Ext.onReady(function() {
    
    // queryable WMS layer
    var zoning = new OpenLayers.Layer.WMS(
        "Medford Zoning",
        "/geoserver/wms",
        {layers: "medford:zoning", format: "image/gif", transparent: "true"}
    );

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
            zoning
        ],
        center: [-122.87, 42.34],
        zoom: 13
    });
    
    // create a control to get feature info from queryable layers
    var control = new OpenLayers.Control.WMSGetFeatureInfo({
        url: "/geoserver/wms"
    });
    panel.map.addControl(control);
    control.activate();
    
    // register a listener for the getfeatureinfo event on the control
    control.events.on({
        getfeatureinfo: function(event) {
            // close existing popup
            if (popup) {
                popup.close();
            }
            try {
            popup = new GeoExt.Popup({
                title: "Popup",
                map: panel.map,
                lonlat: panel.map.getLonLatFromPixel(event.xy),
                width: 250,
                autoScroll: true,
                collapsible: true,
                bodyStyle: {padding: 5},
                html: event.text
            });
            } catch (err) {
                console.log("pfukd", err);
            }
            popup.show();
        }
    });
    

});