Ext.namespace("og");

og.IFrameComponent = Ext.extend(Ext.BoxComponent, {
    
    setUrl: function(url) {
        this.el.dom.contentWindow.location.href = url;
    },
    
    onRender: function(ct, position) {
        this.el = ct.createChild({
            tag: "iframe", 
            id: "iframe-" + this.id, 
            frameborder: 0,
            width: "100%",
            height: "100%", 
            src: this.url
        });
    }
    
});

og.Recipes = Ext.extend(Ext.util.Observable, {
    
    recipeBase: null,
    
    recipeStore: null,
    
    recipeList: null,
    
    startRecipe: null,
    
    query: null,
    
    constructor: function(config) {
        
        this.query = {components: {
            "PostGIS": true,
            "GeoServer": true,
            "GeoWebCache": true,
            "OpenLayers": true,
            "GeoExt": true
        }};
        this.initialConfig = config;
        Ext.apply(this, this.configFromUrl(), config);
        
        // require index in config
        var parts = this.index.split("/");
        parts.pop();
        this.recipeBase = parts.join("/");
        
        this.addEvents(
            "recipeloaded"
        );

        og.Recipes.superclass.constructor.call(this);
        
        var queue = [
            this.initRecipeStore,
            function(done) {
                Ext.onReady(function() {
                    this.initViewport();
                    done();
                }, this)
            }
        ];
        
        this.on({
            recipeloaded: this.onRecipeLoad,
            scope: this
        })
        
        this.dispatch(queue, function() {
            this.selectRecipe(this.startRecipe)            
        });

    },
    
    onRecipeLoad: function() {
        this.recipeFrame
    },
    
    configFromUrl: function() {
        var config = {};
        // pull any recipe id
        var id = window.location.hash.substring(1);
        if (id) {
            config.startRecipe = id;
        }
        return config;
    },
    
    initRecipeStore: function(done) {
        this.recipeStore = new Ext.data.JsonStore({
            url: this.index,
            root: "recipes",
            autoLoad: true,
            fields: ["id", "title", "description", "components"],
            listeners: {
                load: done
            }
        });
    },
    
    initRecipeList: function() {
        
        this.recipeList = new Ext.DataView({
            store: this.recipeStore,
            itemSelector: "div.recipe",
            overClass: "over",
            selectedClass: "selected",
            singleSelect: true,
            tpl: new Ext.XTemplate(
                '<tpl for=".">',
                    '<div class="recipe">',
                        '<h3>{title}</h3>',
                        '<p>{description}</p>',
                    '</div>',
                '</tpl>'
            ),
            listeners: {
                selectionchange: function(view, selections) {
                    var recs = view.getSelectedRecords();
                    // assume singleSelect: true
                    if (recs.length) {
                        this.loadRecipe(recs[0].get("id"));                        
                    }
                },
                scope: this
            }
        });
          
    },
    
    initViewport: function() {

        Ext.QuickTips.init();
        this.initRecipeList();
        this.initRecipeFrame({
            url: this.getRecipeUrl(this.startRecipe)
        });
        
        this.viewport = new Ext.Viewport({
            layout: "border",
            defaults: {border: false},
            items: [{
                region: "north",
                xtype: "box",
                cls: "header",
                autoEl: {
                    tag: "div",
                    cls: "header",
                    html: "<h1>OpenGeo Recipe Book</h1>"
                }
            }, {
                region: "west",
                cls: "search",
                layout: "fit",
                items: [{
                    xtype: "panel",
                    border: false,
                    autoScroll: true,
                    items: [{
                        xtype: "container",
                        cls: "searchbox",
                        items: [{
                            xtype: "textfield",
                            width: "100%",
                            emptyText: "search for recipes",
                            enableKeyEvents: true,
                            listeners: {
                                keyup: function(field) {
                                    var value = field.getValue();
                                    this.query.keywords = value;
                                    this.filterRecipes();
                                },
                                scope: this
                            }
                        }, {
                            xtype: "fieldset",
                            style: "margin-top: 0.5em;",
                            collapsible: true,
                            title: "Components",
                            collapsed: true,
                            layout: "column",
                            columns: 2,
                            defaults: {
                                xtype: "checkbox",
                                hideLabel: true,
                                columnWidth: '0.5',
                                listeners: {
                                    check: function(box, checked) {
                                        this.query.components[box.getName()] = checked;
                                        this.filterRecipes();
                                    },
                                    scope: this
                                }
                            },
                            items: [this.createComponentCheckboxes()]
                        }]
                    }, {
                        xtype: "container",
                        items: [this.recipeList]
                    }]
                }]
            }, {
                region: "center",
                cls: "entry",
                items: [this.recipeFrame]
            }]
        });

    },
    
    createComponentCheckboxes: function() {
        var components = this.query.components;
        var checkboxes = [];
        for (var name in components) {
            checkboxes.push({
                boxLabel: name,
                name: name,
                checked: components[name]
            });
        }
        return checkboxes;
    },
    
    filterRecipes: function() {
        var keywords = this.query.keywords;
        keywords = keywords && keywords.trim().split(/\s+/).remove("");
        var components = this.query.components;
        this.recipeStore.filterBy(function(r) {
            var hasComponent = false;
            for (var name in components) {
                if (components[name]) {
                    if (r.get("components").indexOf(name) >= 0) {
                        hasComponent = true;
                    }
                }
            }
            var len = keywords && keywords.length;
            var word, title, description, hasKeyword = !len;
            for (var i=0; i<len; ++i) {
                word = keywords[i].toLowerCase();
                if (word) {
                    title = r.get("title").toLowerCase();
                    description = r.get("description").toLowerCase();
                    if (title.indexOf(word) >= 0 || description.indexOf(word) >= 0) {
                        hasKeyword = true;
                    }                    
                }
            }
            return hasComponent && hasKeyword;
        }, this);
    },
    
    initRecipeFrame: function(config) {
        this.recipeFrame = new og.IFrameComponent(config);
    },
    
    getRecipeUrl: function(id) {
        return this.recipeBase + "/" + id + ".html";
    },
    
    selectRecipe: function(id) {
        var index = this.recipeStore.findExact("id", id);
        if (index >= 0) {
            this.recipeList.select(index);
        }
    },
    
    loadRecipe: function(id) {
        window.location.hash = "#" + id;
        this.recipeFrame.setUrl(this.getRecipeUrl(id));
        this.fireEvent("recipeloaded");
    },

    dispatch: function(functions, complete, scope) {
        complete = complete || Ext.emptyFn;
        scope = scope || this;
        var requests = functions.length;
        var responses = 0;
        var storage = {};
        function respond() {
            ++responses;
            if(responses === requests) {
                complete.call(scope, storage);
            }
        }
        function trigger(index) {
            window.setTimeout(function() {
                functions[index].apply(scope, [respond, storage]);
            });
        }
        for(var i=0; i<requests; ++i) {
            trigger(i);
        }
    }

});

