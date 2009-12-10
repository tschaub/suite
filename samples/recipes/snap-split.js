
OpenLayers.Feature.Vector.style['default']['strokeWidth'] = '2';

function init() {
    initMap();
    initUI();
}

var map, draw, modify, snap, split, vectors;
function initMap() {

    map = new OpenLayers.Map('map');
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

/**
 * Add behavior to page elements.  This basically lets us set snapping
 * target properties with the checkboxes and text inputs.  The checkboxes
 * toggle the target node, vertex, or edge (boolean) values.  The
 * text inputs set the nodeTolerance, vertexTolerance, or edgeTolerance
 * property values.
 */
function initUI() {
    // add behavior to snap elements
    var snapCheck = $("snap_toggle");
    snapCheck.checked = true;
    snapCheck.onclick = function() {
        if(snapCheck.checked) {
            snap.activate();
            $("snap_options").style.display = "block";
        } else {
            snap.deactivate();
            $("snap_options").style.display = "none";
        }
    };
    var target, type, tog, tol;
    var types = ["node", "vertex", "edge"];
    var target = snap.targets[0];
    for(var j=0; j<types.length; ++j) {
        type = types[j];
        tog = $("target_" + type);
        tog.checked = target[type];
        tog.onclick = (function(tog, type, target) {
            return function() {target[type] = tog.checked;}
        })(tog, type, target);
        tol = $("target_" + type + "Tolerance");
        tol.value = target[type + "Tolerance"];
        tol.onchange = (function(tol, type, target) {
            return function() {
                target[type + "Tolerance"] = Number(tol.value) || 0;
            }
        })(tol, type, target);
    }

    // add behavior to split elements
    var splitCheck = $("split_toggle");
    splitCheck.checked = true;
    splitCheck.onclick = function() {
        if(splitCheck.checked) {
            split.activate();
            $("split_options").style.display = "block";
        } else {
            split.deactivate();
            $("split_options").style.display = "none";
        }
    };
    var edgeCheck = $("edge_toggle");
    edgeCheck.checked = split.edge;
    edgeCheck.onclick = function() {
        split.edge = edgeCheck.checked;
    };
    
    $("clear").onclick = function() {
        modify.deactivate();
        vectors.destroyFeatures();
    };
    
}
