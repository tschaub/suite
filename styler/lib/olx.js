// extensions or customizations to OpenLayers

// read/write GeoServer custom VendorOption elements
OpenLayers.Format.SLD.v1.prototype.readers.sld["VendorOption"] = function(node, obj) {
    if (!obj.vendorOptions) {
        obj.vendorOptions = [];
    }
    obj.vendorOptions.push({
        name: node.getAttribute("name"),
        value: this.getChildValue(node)
    });    
};
OpenLayers.Format.SLD.v1.prototype.writers.sld["VendorOption"] = function(option) {
    return this.createElementNSPlus("sld:VendorOption", {
        attributes: {name: option.name},
        value: option.value
    });
};
(function() {
    // modify symbolizer writers to include any VendorOption elements
    var writers = OpenLayers.Format.SLD.v1.prototype.writers.sld;
    var modify = ["PointSymbolizer", "LineSymbolizer", "PolygonSymbolizer", "TextSymbolizer"];
    var original, name;
    for (var i=0, ii=modify.length; i<ii; ++i) {
        name = modify[i];
        original = writers[name];
        writers[name] = (function(original) {
            return function(symbolizer) {
                var node = original.apply(this, arguments);
                var options = symbolizer.vendorOptions;
                if (options) {
                    for (var i=0, ii=options.length; i<ii; ++i) {
                        this.writeNode("VendorOption", options[i], node);
                    }
                }
                return node;
            }
        })(original);
    }
})();