/**
 * Copyright (c) 2008 The Open Planning Project
 */

/**
 * @include Styler/widgets/tips/SliderTip.js
 * @include Styler/widgets/form/ColorField.js
 * @include Styler/ColorManager.js
 */

Ext.namespace("Styler");

Styler.FillSymbolizer = Ext.extend(Ext.FormPanel, {
    
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
    
    border: false,
    
    initComponent: function() {
        
        if(!this.symbolizer) {
            this.symbolizer = {};
        }        
        Ext.applyIf(this.symbolizer, this.defaultSymbolizer);
        
        this.items = [{
            xtype: "fieldset",
            title: "Fill",
            autoHeight: true,
            defaults: {
                width: 100 // TODO: move to css
            },
            items: [{
                xtype: "gx_colorfield",
                fieldLabel: "Color",
                name: "color",
                value: this.symbolizer["fillColor"],
                plugins: new Styler.ColorManager(),
                listeners: {
                    valid: function(field) {
                        this.symbolizer["fillColor"] = field.getValue();
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                }
            }, {
                xtype: "slider",
                fieldLabel: "Opacity",
                name: "opacity",
                value: (this.symbolizer["fillOpacity"] == null) ? 100 : this.symbolizer["fillOpacity"] * 100,
                isFormField: true,
                listeners: {
                    changecomplete: function(slider, value) {
                        this.symbolizer["fillOpacity"] = value / 100;
                        this.fireEvent("change", this.symbolizer);
                    },
                    scope: this
                },
                plugins: [
                    new Styler.SliderTip({
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
             * symbolizer - {Object} A symbolizer with fill related properties
             *     updated.
             */
            "change"
        ); 

        Styler.FillSymbolizer.superclass.initComponent.call(this);
        
    }
    
    
});

Ext.reg('gx_fillsymbolizer', Styler.FillSymbolizer); 