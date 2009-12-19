OpenLayers.Feature.Vector.style['default']['strokeWidth'] = '2';

var map, draw, modify, snap, split, vectors;
function init() {

    map = new OpenLayers.Map({
        div: "map",
        controls: [
            new OpenLayers.Control.Navigation({
                zoomWheelEnabled: false
            }),
            new OpenLayers.Control.PanZoom()
        ]
    });
    var styles = new OpenLayers.StyleMap({
        "default": new OpenLayers.Style(null, {
            rules: [
                new OpenLayers.Rule({
                    symbolizer: {
                        "Point": {
                            pointRadius: 5,
                            graphicName: "square",
                            fillColor: "white",
                            fillOpacity: 0.25,
                            strokeWidth: 1,
                            strokeOpacity: 1,
                            strokeColor: "#333333"
                        },
                        "Line": {
                            strokeWidth: 3,
                            strokeOpacity: 1,
                            strokeColor: "#666666"
                        }
                    }
                })
            ]
        }),
        "select": new OpenLayers.Style({
            strokeColor: "#00ccff",
            strokeWidth: 4
        }),
        "temporary": new OpenLayers.Style(null, {
            rules: [
                new OpenLayers.Rule({
                    symbolizer: {
                        "Point": {
                            pointRadius: 5,
                            graphicName: "square",
                            fillColor: "white",
                            fillOpacity: 0.25,
                            strokeWidth: 1,
                            strokeOpacity: 1,
                            strokeColor: "#333333"
                        },
                        "Line": {
                            strokeWidth: 3,
                            strokeOpacity: 1,
                            strokeColor: "#00ccff"
                        }
                    }
                })
            ]
        })
    });

    // create three vector layers
    vectors = new OpenLayers.Layer.Vector("Lines", {
        isBaseLayer: true,
        strategies: [new OpenLayers.Strategy.Fixed()],                
        protocol: new OpenLayers.Protocol.HTTP({
            url: "data/roads.json",
            format: new OpenLayers.Format.GeoJSON()
        }),
        styleMap: styles,
        maxExtent: new OpenLayers.Bounds(
            1549471.9221, 6403610.94, 1550001.32545, 6404015.8
        )
    });
    map.addLayer(vectors);
    
    // configure the snapping agent
    snap = new OpenLayers.Control.Snapping({layer: vectors});
    map.addControl(snap);
    snap.activate();
    
    // configure split agent
    split = new OpenLayers.Control.Split({
        layer: vectors,
        source: vectors,
        tolerance: 0.0001,
        eventListeners: {
            aftersplit: function(event) {
                flashFeatures(event.features);
            }
        }
    });
    map.addControl(split);
    split.activate();

    // add some editing tools to a panel
    var panel = new OpenLayers.Control.Panel({
        displayClass: "olControlEditingToolbar"
    });
    draw = new OpenLayers.Control.DrawFeature(
        vectors, OpenLayers.Handler.Path,
        {displayClass: "olControlDrawFeaturePoint", title: "Draw Features"}
    );
    modify = new OpenLayers.Control.ModifyFeature(
        vectors, {displayClass: "olControlModifyFeature", title: "Modify Features"}
    );
    panel.addControls([
        new OpenLayers.Control.Navigation({title: "Navigate"}),
        draw, modify
    ]);
    map.addControl(panel);
    
    map.addControl(new OpenLayers.Control.MousePosition());
    
    map.zoomToMaxExtent();
}

function flashFeatures(features, index) {
    if(!index) {
        index = 0;
    }
    var current = features[index];
    if(current && current.layer === vectors) {
        vectors.drawFeature(features[index], "select");
    }
    var prev = features[index-1];
    if(prev && prev.layer === vectors) {
        vectors.drawFeature(prev, "default");
    }
    ++index;
    if(index <= features.length) {
        window.setTimeout(function() {flashFeatures(features, index)}, 75);
    }
}

