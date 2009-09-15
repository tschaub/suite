/* ======================================================================
    WHO/TristateCheckboxNodeUI.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.TristateCheckboxNodeUI
 * 
 * Inherits from:
 * - <Ext.tree.TreeNodeUI>
 */
WHO.tree.TristateCheckboxNodeUI = Ext.extend(Ext.tree.TreeNodeUI, {
    
    /**
     * Constructor: WHO.tree.TristateCheckbosNodeUI
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        WHO.tree.TristateCheckboxNodeUI.superclass.constructor.apply(this, arguments);
    },
    
    /**
     * Method: toggleCheck
     * 
     * Parameters:
     * value - {Boolean} checked status
     * thirdState - {Boolean}
     * options - {Object} Hash of options for this method
     * 
     * Currently supported options:
     * silent - {Boolean} set to true if no checkchange event should be
     *     fired
     */
    toggleCheck: function(value, thirdState, options) {
        var cb = this.checkbox;
        if(thirdState == true) {
            if(cb) {
                Ext.get(cb).setOpacity(0.5);
            }
            this.node.attributes.thirdState = true;
        } else {
            if(cb) {
                Ext.get(cb).clearOpacity();
            }
            delete this.node.attributes.thirdState;
        }
        if(options && options.silent == true){
            this.node.suspendEvents();
        }
        WHO.tree.TristateCheckboxNodeUI.superclass.toggleCheck.call(this,
            value);
        this.node.resumeEvents();
    }
});
/* ======================================================================
    WHO/LayerContainer.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.LayerContainer
 * 
 * A subclass of {Ext.tree.TreeNode} that will collect all layers of an
 * OpenLayers map. Only layers that have displayInLayerSwitcher set to true
 * will be included. The childrens' iconCls will be set to "baselayer-icon"
 * for base layers, and to "layer-icon" for overlay layers.
 * 
 * To use this node type in JSON config, set nodeType to "olLayerContainer".
 * 
 * Inherits from:
 * - <Ext.tree.TreeNode>
 */
WHO.tree.LayerContainer = Ext.extend(Ext.tree.TreeNode, {
    
    /**
     * ConfigProperty: map
     * {OpenLayers.Map} or {String} - map or id of an {Ext.Component} that
     *     has a map property with an {OpenLayers.Map} set. This node will
     *     be connected to that map. If omitted, the node will query the
     *     ComponentManager for the first component that has a map property
     *     with an {OpenLayers.Map} set.
     */
    map: null,

    /**
     * Constructor: WHO.tree.LayerContainer
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        this.map = config.map;
        WHO.tree.LayerContainer.superclass.constructor.apply(this, arguments);
    },

    /**
     * Method: render
     * 
     * Parameters:
     * bulkRender - {Boolean}
     */
    render: function(bulkRender) {
        if (!this.rendered) {
            var map = this.map instanceof OpenLayers.Map ? this.map :
                (typeof this.map == "string" ? Ext.getCmp(this.map).map :
                Ext.ComponentMgr.all.find(function(o) {
                    return o.map instanceof OpenLayers.Map;
                }).map);
            if (map.layers) {
                var layer, node;
                for (var i = 0, len = map.layers.length; i < len; ++i) {
                    layer = map.layers[i];
                    this.addLayerNode(layer);
                }
            }
            map.events.register("addlayer", this, function(e) {
                this.addLayerNode(e.layer);
            });
            map.events.register("removelayer", this, function(e) {
                this.removeLayerNode(e.layer);
            });
        }
        WHO.tree.LayerContainer.superclass.render.call(this, bulkRender);
    },
    
    /**
     * Method: addLayerNode
     * Adds a child node representing a layer of the map
     * 
     * Parameters:
     * layer - {OpenLayers.Layer} the layer to add a node for
     */
    addLayerNode: function(layer) {
        if (layer.displayInLayerSwitcher == true) {
            node = new WHO.tree.LayerNode({
                iconCls: layer.isBayeLayer ? 'baselayer-icon' : 'layer-icon',
                layer: layer
            });
            this.appendChild(node);
        }
    },
    
    /**
     * Method: removeLayerNode
     * Removes a child node representing a layer of the map
     * 
     * Parameters:
     * layer - {OpenLayers.Layer} the layer to remove the node for
     */
    removeLayerNode: function(layer) {
        if (layer.displayInLayerSwitcher == true) {
            var node = this.findChildBy(function(node) {
                return node.layer == layer;
            });
            if(node) {
                node.remove();
            }
    	}
    }
});

/**
 * NodeType: olLayerContainer
 */
Ext.tree.TreePanel.nodeTypes.olLayerContainer = WHO.tree.LayerContainer;
/* ======================================================================
    WHO/OverlayLayerContainer.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 *
 * @requires WHO/LayerContainer.js
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.OverlayLayerContainer
 * 
 * A layer container that will collect all overlay layers of an OpenLayers map.
 * Only layers that have displayInLayerSwitcher set to true will be included.
 * 
 * To use this node type in JSON config, set nodeType to
 * "olOverlayLayerContainer".
 * 
 * Inherits from:
 * - <WHO.tree.LayerContainer>
 */
WHO.tree.OverlayLayerContainer = Ext.extend(WHO.tree.LayerContainer, {

    /**
     * Constructor: WHO.tree.OverlayLayerContainer
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        config.text = config.text || "Overlays";
        WHO.tree.OverlayLayerContainer.superclass.constructor.apply(this,
            arguments);
    },

    /**
     * Method: addLayerNode
     * Adds a child node representing a overlay layer of the map
     * 
     * Parameters:
     * layer - {OpenLayers.Layer} the layer to add a node for
     */
    addLayerNode: function(layer) {
        if (layer.isBaseLayer == false) {
            WHO.tree.OverlayLayerContainer.superclass.addLayerNode.call(this,
                layer);
        }
    },
    
    /**
     * Method: removeLayerNode
     * Removes a child node representing an overlay layer of the map
     * 
     * Parameters:
     * layer - {OpenLayers.Layer} the layer to remove the node for
     */
    removeLayerNode: function(layer) {
        if (layer.isBaseLayer == false) {
            WHO.tree.OverlayLayerContainer.superclass.removeLayerNode.call(
                this,layer);
    	}
    }
});

/**
 * NodeType: olOverlayLayerContainer
 */
Ext.tree.TreePanel.nodeTypes.olOverlayLayerContainer = WHO.tree.OverlayLayerContainer;
/* ======================================================================
    WHO/TristateCheckboxNode.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.TristateCheckboxNode
 * 
 * Provides a tree node that will have a third state (stored in
 * attributes.thirdState) to have a proper semi-checked state for
 * nodes with only *some* children checked. attributes.thirdState will be
 * undefined if the node is checked or unchecked, and true if the node is
 * semi-checked.
 * 
 * This node has also a childcheckchange event that will be triggered with a
 * child node and it's checked state to notify listeners when a the checked
 * state of a child's node has changed.
 * 
 * Applications using this class should not rely on the checkchange event to
 * determine the checked state of non-leaf nodes. Instead, applications should
 * also listen to the childcheckchange event and read out attributes.checked
 * and attributes.thirdState to get the node's checked state.
 * 
 * To use this node type in a JSON config, set nodeType to "tristateCheckbox".
 * 
 * Inherits from:
 * - <Ext.tree.AsyncTreeNode>
 */
WHO.tree.TristateCheckboxNode = Ext.extend(Ext.tree.AsyncTreeNode, {
    
    /**
     * Property: checkedChildNodes
     * {Object} Hash of 0.1 for thirdState nodes and 1 for fully checked
     *     nodes, keyed by node ids. In combination with
     *     {<checkedCount>}, this provides an
     *     efficient way of keeping track of the childnodes' checked status.
     */
    checkedChildNodes: null,
    
    /**
     * Property: checkedCount
     * {Number} A cache for the sum of checkedChildNodes' values.
     */
    checkedCount: null,
    
    /**
     * Constructor: WHO.tree.TristateCheckboxNode
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        this.checkedChildNodes = {};
        this.checkedCount = 0;
        
        this.defaultUI = this.defaultUI || WHO.tree.TristateCheckboxNodeUI;
        this.addEvents.apply(this, WHO.tree.TristateCheckboxNode.EVENT_TYPES);
        
        WHO.tree.TristateCheckboxNode.superclass.constructor.apply(this, arguments);

        this.on("childcheckchange", this.updateCheckedChildNodes, this);
    },
    
    /**
     * Method: render
     * 
     * Parameters:
     * bulkRender - {Boolean}
     */
    render: function(bulkRender) {
        var rendered = this.rendered;
        var checked = this.attributes.checked;
        this.attributes.checked =
            typeof this.attributes.checked == "undefined" ? false :
            this.attributes.checked;
        WHO.tree.TristateCheckboxNode.superclass.render.call(this, bulkRender);
        var ui = this.getUI();
        if(!rendered) {
            if(typeof checked == "undefined" && this.parentNode.ui.checkbox) {
                ui.toggleCheck(this.parentNode.ui.checkbox.checked);
            }
            this.parentNode.on("checkchange", function(node, checked) {
                ui.toggleCheck(checked);
            }, this);
        }
    },
    
    /**
     * Method: updateCheckedChildNodes
     * Updates the status cache of checked child nodes.
     * 
     * Parameters:
     * node - {Ext.tree.Node} child node that has changed
     * checked - {Boolean} new checked status of the changed child node
     */
    updateCheckedChildNodes: function(node, checked) {
        if(checked) {
            this.addChecked(node, node.attributes.thirdState);
        } else {
            this.removeChecked(node);
        }

        var childrenChecked, childrenThirdState;
        if(this.checkedCount.toFixed() == this.childNodes.length) {
            childrenChecked = true;
            childrenThirdState = false;
        } else if(this.checkedCount.toFixed(1) == 0) {
            childrenChecked = false;
            childrenThirdState = false;
        } else {
            childrenChecked = true;
            childrenThirdState = true;
        }
        // do a special silent toggleCheck to avoid checkchange events being
        // triggered
        this.getUI().toggleCheck(childrenChecked, childrenThirdState,
            {silent: true});
        if(this.parentNode) {
            this.parentNode.fireEvent("childcheckchange", this,
                childrenChecked);
        }
    },
    
    /**
     * Method: appendChild
     * 
     * Parameters:
     * node - {Ext.tree.Node}
     */
    appendChild: function(node) {
        WHO.tree.TristateCheckboxNode.superclass.appendChild.call(this, node);
        if(this.attributes.checked || node.attributes.checked) {
            this.addChecked(node);
        }
        // We do not want this event handler to trigger checkchange events on
        // parent nodes, because this would cause bouncing between this
        // handler and the handler for (un-)checking children on a parent's
        // checkchange event. So we introduce a special childcheckchange
        // event with a handler that will also trigger this event on the
        // parent.
        node.on("checkchange", function(node, checked) {
            if (this.childrenRendered) {
                this.fireEvent("childcheckchange", node, checked);
            }
        }, this);
    },
    
    /**
     * Method: addChecked
     * Adds a child node to the checkedChildNodes hash. Adds 1 for fully
     * checked nodes, 0.1 for third state checked nodes.
     * 
     * Parameters:
     * node - {Ext.tree.Node}
     * thirdState - {Boolean}
     */
    addChecked: function(node, thirdState) {
        // subtract current value (if any). This is needed to change from a
        // tristate to a fully checked state and vice versa.
        this.checkedCount -= (this.checkedChildNodes[node.id] || 0);
        
        var add = thirdState ? 0.1 : 1;
        this.checkedChildNodes[node.id] = add;
        this.checkedCount += add;
    },
    
    /**
     * Method: removeChecked
     * Removes a child node from the checkedChildNodes hash.
     * 
     * Parameters:
     * node - {Ext.tree.Node}
     */
    removeChecked: function(node) {
        var remove = this.checkedChildNodes[node.id]
        if(remove) {
            delete this.checkedChildNodes[node.id];
            this.checkedCount -= remove;
        }
    }
});

/**
 * Constant: EVENT_TYPES
 * {Array(String)} - supported event types
 * 
 * Event types supported for this class, in additon to the ones inherited
 * from {<WHO.tree.TristateCheckboxNode>}:
 * - *childcheckchange* fired to notify a parent node that the status of
 *     its checked child nodes has changed
 */
WHO.tree.TristateCheckboxNode.EVENT_TYPES = ["childcheckchange"];

/**
 * NodeType: tristateCheckbox
 */
Ext.tree.TreePanel.nodeTypes.tristateCheckbox = WHO.tree.TristateCheckboxNode;
/* ======================================================================
    WHO/LayerNode.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 * 
 * @requires WHO/TristateCheckboxNode.js
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.LayerNode
 * 
 * A subclass of {Ext.tree.AsyncTreeNode} that is connected to an
 * {OpenLayers.Layer} by setting the node's layer property. Checking or
 * unchecking the checkbox of this node will directly affect the layer and
 * vice versa. The default iconCls for this node's icon is "layer-icon",
 * unless it has children.
 * 
 * This node can contain children, e.g. filter nodes.
 * 
 * Setting the node's layer property to a layer name instead of an object
 * will also work. As soon as a layer is found, it will be stored as layer
 * property in the attributes hash.
 * 
 * The node's text property defaults to the layer name.
 * 
 * If the layer has a queryable property set to true, the node will render a
 * radio button to select the query layer. Clicking on the radio button will
 * fire the querychange event, with the layer as argument. A queryGroup
 * attribute, set to the map's id, will be added to the attributes hash.
 * 
 * To use this node type in a JSON config, set nodeType to "olLayer".
 * 
 * Inherits from:
 * - <WHO.tree.TristateCheckboxNode>
 */
WHO.tree.LayerNode = Ext.extend(WHO.tree.TristateCheckboxNode, {
    
    /**
     * ConfigProperty: layer
     * {OpenLayers.Layer} or {String}. The layer that this layer node will
     * be bound to, or the name of the layer (has to match the layer's name
     * property). Subclasses or applications can always rely on finding an
     * {OpenLayers.Layer} object in attributes.layer.
     */
    layer: null,
    
    /**
     * ConfigProperty: map
     * {OpenLayers.Map} or {String}. Map or id of an {Ext.Component} that
     * has a map property with an {OpenLayers.Map} set. This node will
     * be connected to that map. If omitted, the node will query the
     * ComponentManager for the first component that has a map property
     * with an {OpenLayers.Map} set.
     */
    map: null,
    
    /**
     * Property: haveLayer
     * {Boolean} will be set to true as soon as this node is connected to a
     * layer.
     */
    haveLayer: null,
    
    /**
     * Property: updating
     * {Boolean} The visibility status of the layer is being updated by itself
     *     (i.e. not by clicking on this node, but by layer visibilitychanged)
     */
    updating: false,

    /**
     * Constructor: WHO.tree.LayerNode
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        this.layer = config.layer;
        this.map = config.map;
        this.haveLayer = false;

        config.leaf = config.leaf || !config.children;
        config.iconCls = typeof config.iconCls == "undefined" &&
            !config.children ? "layer-icon" : config.iconCls;
        // checked status will be set by layer event, so setting it to false
        // to always get the checkbox rendered
        config.checked = false;
        
        this.defaultUI = this.defaultUI || WHO.tree.LayerNodeUI;
        this.addEvents.apply(this, WHO.tree.LayerNode.EVENT_TYPES);
        
        WHO.tree.LayerNode.superclass.constructor.apply(this, arguments);
    },

    /**
     * Method: render
     * 
     * Properties:
     * bulkRender {Boolean} - optional
     * layer {<OpenLayers.Layer>} - optional
     */
    render: function(bulkRender) {
        if (!this.rendered || !this.haveLayer) {
            var map = this.map instanceof OpenLayers.Map ? this.map :
                (typeof this.map == "string" ? Ext.getCmp(this.map).map :
                Ext.ComponentMgr.all.find(function(o) {
                    return o.map instanceof OpenLayers.Map;
                }).map);
            var layer = this.attributes.layer || this.layer;
            this.haveLayer = layer && typeof layer == "object";
            if(typeof layer == "string") {
                var matchingLayers = map.getLayersByName(layer);
                if(matchingLayers.length > 0) {
                    layer = matchingLayers[0];
                    this.haveLayer = true;
                }
            }
            var ui = this.getUI();
            if(this.haveLayer) {
                this.attributes.layer = layer;
                if(layer.queryable == true) {
                    this.attributes.radioGroup = layer.map.id;
                }
                if(!this.text) {
                    this.text = layer.name;
                }
                ui.show();
                ui.toggleCheck(layer.getVisibility());
                layer.events.register("visibilitychanged", this, function(){
                    this.updating = true;
                    if(this.attributes.checked != layer.getVisibility()) {
                        ui.toggleCheck(layer.getVisibility());
                    }
                    this.updating = false;
                });
                this.on("checkchange", function(node, checked){
                    if(!this.updating) {
                        if(checked && layer.isBaseLayer) {
                            map.setBaseLayer(layer);
                        }
                        layer.setVisibility(checked);
                    }
                }, this);
                
                // set initial checked status
                this.attributes.checked = layer.getVisibility();
            } else {
                ui.hide();
            }
            map.events.register("addlayer", this, function(e) {
                if(layer == e.layer) {
                    this.getUI().show();
                } else if (layer == e.layer.name) {
                    // layer is a string, which means the node has not
                    // yet been rendered because the layer was not found.
                    // But now we have the layer and can render.
                    this.render(bulkRender);
                    return;
                }
            });
            map.events.register("removelayer", this, function(e) {
                if(layer == e.layer) {
                    this.getUI().hide();
                }
            });
        }
        WHO.tree.LayerNode.superclass.render.call(this, bulkRender);
    }
});

/**
 * Constant: WHO.tree.LayerNode.EVENT_TYPES
 * {Array(String)} - supported event types
 * 
 * Event types supported for this class, in additon to the ones inherited
 * from {<WHO.tree.TristateCheckboxNode>}:
 * - *querylayerchange* notifies listener when the query layer has
 *     changed. Will be called with the new query layer as argument.
 */
WHO.tree.LayerNode.EVENT_TYPES = ["querylayerchange"];

/**
 * NodeType: olLayer
 */
Ext.tree.TreePanel.nodeTypes.olLayer = WHO.tree.LayerNode;
/* ======================================================================
    WHO/LayerNodeUI.js
   ====================================================================== */

/**
 * Copyright (c) 2008 The Open Planning Project
 *
 * @requires WHO/TristateCheckboxNodeUI.js
 */
Ext.namespace("WHO.tree");

/**
 * Class: WHO.tree.LayerNodeUI
 * 
 * Inherits from:
 * - <WHO.tree.TristateCheckboxNodeUI>
 */
WHO.tree.LayerNodeUI = Ext.extend(WHO.tree.TristateCheckboxNodeUI, {
    
    /**
     * Property: radio
     * {Ext.Element}
     */
    radio: null,
    
    /**
     * Constructor: WHO.tree.LayerNodeUI
     * 
     * Parameters:
     * config - {Object}
     */
    constructor: function(config) {
        WHO.tree.LayerNodeUI.superclass.constructor.apply(this, arguments);
    },
    
    /**
     * Method: render
     * 
     * Parameters:
     * bulkRender - {Boolean}
     */
    render: function(bulkRender) {
        WHO.tree.LayerNodeUI.superclass.render.call(this, bulkRender);
        var a = this.node.attributes;
        if (a.radioGroup && !this.radio) {
            this.radio = Ext.DomHelper.insertAfter(this.checkbox,
                ['<input type="radio" class="x-tree-node-cb" name="',
                a.radioGroup, '_querylayer"></input>'].join(""));
        }
    },
    
    /**
     * Method: onClick
     * 
     * Parameters:
     * e - {Object}
     */
    onClick: function(e) {
        if (e.getTarget('input[type=radio]', 1)) {
            this.fireEvent("querylayerchange", this.node.attributes.layer);
        } else {
            WHO.tree.LayerNodeUI.superclass.onClick.call(this, e);
        }
    },
    
    /**
     * Method: destroy
     */
    destroy: function() {
        WHO.tree.LayerNodeUI.superclass.destroy.call(this);
        delete this.radio;
    }
});
