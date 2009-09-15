(function() {
    
    /**
     * This loader brings in all Styler specific and GeoExt related code.
     * Not included here are OpenLayers and Ext code (or Ext ux).
     */

    var jsfiles = new Array(
        "lib/Styler.js",
        "lib/Styler/Util.js",
        "lib/Styler/dispatch.js",
        "lib/Styler/SchemaManager.js",
        "lib/Styler/SLDManager.js",
        "lib/Styler/ColorManager.js",
        "lib/Styler/widgets/form/ColorField.js",
        "lib/Styler/widgets/FilterPanel.js",
        "lib/Styler/widgets/FilterBuilder.js",
        "lib/Styler/data/AttributesReader.js",
        "lib/Styler/data/AttributesStore.js",
        "lib/Styler/widgets/form/ComparisonComboBox.js",
        "lib/Styler/widgets/FeatureRenderer.js",
        "lib/Styler/widgets/RulePanel.js",
        "lib/Styler/widgets/ScaleLimitPanel.js",
        "lib/Styler/widgets/MultiSlider.js",
        "lib/Styler/widgets/tips/MultiSliderTip.js",
        "lib/Styler/widgets/tips/SliderTip.js",
        "lib/Styler/widgets/FillSymbolizer.js",
        "lib/Styler/widgets/StrokeSymbolizer.js",
        "lib/Styler/widgets/PointSymbolizer.js",
        "lib/Styler/widgets/LineSymbolizer.js",
        "lib/Styler/widgets/PolygonSymbolizer.js",
        "lib/Styler/widgets/form/FontComboBox.js",
        "lib/Styler/widgets/TextSymbolizer.js",
        "lib/Styler/widgets/LegendPanel.js",
        "lib/Styler/widgets/ScaleSlider.js",
        "lib/Styler/widgets/tips/ScaleSliderTip.js",
        "externals/tree/WHO/TristateCheckboxNodeUI.js",
        "externals/tree/WHO/TristateCheckboxNode.js",
        "externals/tree/WHO/LayerNodeUI.js",
        "externals/tree/WHO/LayerNode.js",
        "externals/tree/WHO/LayerContainer.js",
        "externals/tree/WHO/OverlayLayerContainer.js",
        "externals/core/lib/GeoExt/widgets/map/MapPanel.js"
    );

    var appendable = !(/MSIE/.test(navigator.userAgent) ||
                       /Safari/.test(navigator.userAgent));
    var pieces = new Array(jsfiles.length);

    var element = document.getElementsByTagName("head").length ?
                    document.getElementsByTagName("head")[0] :
                    document.body;
    var script;

    for(var i=0; i<jsfiles.length; i++) {
        if(!appendable) {
            pieces[i] = "<script src='" + jsfiles[i] + "'></script>"; 
        } else {
            script = document.createElement("script");
            script.src = jsfiles[i];
            element.appendChild(script);
        }
    }
    if(!appendable) {
        document.write(pieces.join(""));
    }
})();
