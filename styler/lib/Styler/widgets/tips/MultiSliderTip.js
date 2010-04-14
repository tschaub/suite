/**
 * Copyright (c) 2008 The Open Planning Project
 */

Ext.namespace("Styler");

Styler.MultiSliderTip = Ext.extend(Ext.Tip, {

    /**
     * Property: hover
     * {Boolean} Display the tip when hovering over a thumb.  If false, tip
     *     will only be displayed while dragging.  Default is true.
     */
    hover: true,
    
    /**
     * Property: dragging
     * {Boolean} A thumb is currently being dragged.
     */
    dragging: false,

    minWidth: 10,
    offsets: [0, -10],
    init: function(slider) {
        slider.on('dragstart', this.onSlide, this);
        slider.on('drag', this.onSlide, this);
        slider.on('dragend', this.hide, this);
        slider.on('destroy', this.destroy, this);
        if(this.hover) {
            slider.on('render', this.registerThumbListeners, this);
        }
        this.slider = slider;
    },
    
    registerThumbListeners: function() {
        for(var i=0, len=this.slider.thumbs.length; i<len; ++i) {
            this.slider.thumbs[i].el.on({
                "mouseover": this.createHoverListener(i),
                "mouseout": function() {
                    if(!this.dragging) {
                        this.hide.apply(this, arguments);
                    }
                },
                scope: this
            });
        }
    },
    
    createHoverListener: function(index) {
        return (function() {
            this.onSlide(this.slider, {}, this.slider.thumbs[index]);
            this.dragging = false;
        }).createDelegate(this);
    },

    onSlide: function(slider, e, thumb) {
        this.dragging = true;
        this.show();
        this.body.update(this.getText(thumb));
        this.doAutoWidth();
        this.el.alignTo(thumb.el, 'b-t?', this.offsets);
    },

    getText: function(thumb) {
        return thumb.value;
    }

});
