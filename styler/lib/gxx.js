Ext.override(GeoExt.FeatureRenderer, {
    /** private: method[drawFeature]
     *  Render the feature with the symbolizers (excluding text).
     */
    drawFeature: function() {
        this.renderer.clear();
        this.setRendererDimensions();
        var symbolizer;
        for (var i=0, len=this.symbolizers.length; i<len; ++i) {
            symbolizer = this.symbolizers[i];
            if (!(symbolizer instanceof OpenLayers.Symbolizer.Text)) {
                this.renderer.drawFeature(
                    this.feature.clone(),
                    symbolizer.clone()
                );                
            }
        }
    }
});

Ext.override(GeoExt.VectorLegend, {
    /** private: method[createRuleRenderer]
     *  :arg rule: ``OpenLayers.Rule``
     *  :returns: ``GeoExt.FeatureRenderer``
     *
     *  Create a renderer for the rule.
     */
    createRuleRenderer: function(rule) {
        var symbolizers = rule.symbolizers;
        if (!symbolizers) {
            var symbolizer = rule.symbolizer;
            if (symbolizer[this.symbolType]) {
                symbolizer = symbolizer[this.symbolType];
            }
            symbolizers = [symbolizer];
        }
        return {
            xtype: "gx_renderer",
            symbolType: this.symbolType,
            symbolizers: symbolizers,
            style: this.clickableSymbol ? {cursor: "pointer"} : undefined,
            listeners: {
                click: function() {
                    if (this.clickableSymbol) {
                        this.fireEvent("symbolclick", this, rule);
                        this.fireEvent("ruleclick", this, rule);
                    }
                },
                scope: this
            }
        };
    }
});

