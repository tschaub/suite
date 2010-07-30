/**
 * Copyright (c) 2008-2010 The Open Planning Project
 * 
 * @requires Styler.js
 */

Ext.namespace("Styler.Util");

Styler.Util = {
    
    /**
     * Function: getSymbolTypeFromRule
     * Determines the symbol type of the first symbolizer of a rule that is
     * not a text symbolizer
     * 
     * Parameters:
     * rule - {OpenLayers.Rule}
     * 
     * Returns:
     * {String} "Point", "Line" or "Polygon" (or undefined if none of the
     *     three)
     */
    getSymbolTypeFromRule: function(rule) {
        var candidate, type;
        for (var i=0, ii=rule.symbolizers.length; i<ii; ++i) {
            candidate = rule.symbolizers[i];
            if (!(candidate instanceof OpenLayers.Symbolizer.Text)) {
                type = candidate.CLASS_NAME.split(".").pop();
                break;
            }
        }
        return type;
    }
};


