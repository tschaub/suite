/**
 * Copyright (c) 2008 The Open Planning Project
 */

/**
 * @include Styler/widgets/form/ColorField.js
 * @include Styler/ColorManager.js
 */

Ext.namespace("Styler");

Styler.StrokeSymbolizer = Ext.extend(Ext.FormPanel, {
    
    /**
     * Property: symbolizer
     * {Object} A symbolizer object that will be used to fill in form values.
     *     This object will be modified when values change.  Clone first if
     *     you do not want your symbolizer modified.
     */
    symbolizer: null,
    
    /**
     * Property: defaultSymbolizer
     * {Object} Default symbolizer properties to be used where none provided.
     */
    defaultSymbolizer: null,
    
    /**
     * Property: dashStyles
     * {Array(Array)} A list of [value, name] pairs for stroke dash styles.
     *     The first item in each list is the value and the second is the
     *     display name.  Default is [["solid", "solid"], ["2 4", "dash"],
     *     ["1 4", "dot"]].
     */
    dashStyles: [["solid", "solid"], ["4 4", "dash"], ["2 4", "dot"]],
    
    border: false,
    
    initComponent: function() {
        
        if(!this.symbolizer) {
            this.symbolizer = {};
        }        
        Ext.applyIf(this.symbolizer, this.defaultSymbolizer);

        this.items = [{
            xtype: "fieldset",
            title: "Stroke",
            autoHeight: true,
            defaults: {
                width: 100 // TODO: move to css
            },
            items: [{
                xtype: "combo",
                name: "style",
                fieldLabel: "Style",
                store: new Ext.data.SimpleStore({
                    data: this.dashStyles,
                    fields: ["value", "display"]
                }),
                displayField: "display",
                valueField: "value",
                value: this.getDashArray(this.symbolizer["strokeDashstyle"]) || "solid",
                mode: "local",
                allowBlank: true,
                triggerAction: "all",
                editable: false,
                listeners: {
                    select: function(combo, record) {
                        this.symbolizer["strokeDashstyle"] = record.get("value");
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                }
            }, {
                xtype: "gx_colorfield",
                name: "color",
                fieldLabel: "Color",
                value: this.symbolizer["strokeColor"],
                plugins: new Styler.ColorManager(),
                listeners: {
                    valid: function(field) {
                        this.symbolizer["strokeColor"] = field.getValue();
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                }
            }, {
                xtype: "textfield",
                name: "width",
                fieldLabel: "Width",
                value: this.symbolizer["strokeWidth"],
                listeners: {
                    change: function(field, value) {
                        this.symbolizer["strokeWidth"] = value;
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                }
            }, {
                xtype: "slider",
                name: "opacity",
                fieldLabel: "Opacity",
                values: [(this.symbolizer["strokeOpacity"] == null) ? 100 : this.symbolizer["strokeOpacity"] * 100],
                isFormField: true,
                listeners: {
                    changecomplete: function(slider, value) {
                        this.symbolizer["strokeOpacity"] = value / 100;
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                },
                plugins: [
                    new gxp.SliderTip({
                        getText: function(slider) {
                            return slider.getValue() + "%";
                        }
                    })
                ]
            }]
        }];

        this.addEvents(
            /**
             * Event: change
             * Fires before any field blurs if the field value has changed.
             *
             * Listener arguments:
             * symbolizer - {Object} A symbolizer with stroke related properties
             *     updated.
             */
            "change"
        ); 
 
        Styler.StrokeSymbolizer.superclass.initComponent.call(this);
        
    },

    getDashArray: function(style) {
        var array;
        if (style) {
            var parts = style.split(/\s+/);
            var ratio = parts[0] / parts[1];
            var array;
            if (!isNaN(ratio)) {
                array = ratio >= 1 ? "4 4" : "2 4"
            }
        }
        return array;
    }
    
    
    
});

Ext.reg('gx_strokesymbolizer', Styler.StrokeSymbolizer); 
