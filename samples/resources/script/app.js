Ext.namespace("og");

Ext.ux.IFrameComponent = Ext.extend(Ext.BoxComponent, {
    
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

    constructor: function(config) {

        Ext.apply(this, config);
        this.initialConfig = config;
        
        // require index in config
        var parts = this.index.split("/");
        parts.pop();
        this.recipeBase = parts.join("/");

        og.Recipes.superclass.constructor.call(this);
        
        this.initRecipeStore(this.index);
        
        Ext.onReady(this.initViewport, this);

    },
    
    initRecipeStore: function(url) {
        
        this.recipeStore = new Ext.data.JsonStore({
            url: url,
            root: "recipes",
            autoLoad: true,
            fields: ["id", "title", "description", "components", "topics"]
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
                    this.loadRecipe(recs[0]);
                },
                scope: this
            }
        });
        
        if (this.recipeStore.getCount()) { // poor substitute for loaded
            this.parseHash();
        } else {
            this.recipeStore.on("load", this.parseHash, this, {single: true});
        }
  
    },
    
    parseHash: function() {
        var id = window.location.hash.substring(1);
        var index = this.recipeStore.findExact("id", id);
        console.log(index);
        if (index >= 0) {
            this.recipeList.select(index);
        }
    },
    
    initViewport: function() {

        Ext.QuickTips.init();
        this.initRecipeList();
        this.initRecipeFrame();
        
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
                cls: "recipes",
                items: [this.recipeList]
            }, {
                region: "center",
                cls: "entry",
                items: [this.recipeFrame]
            }]
        });

    },
    
    initRecipeFrame: function() {
        this.recipeFrame = new Ext.ux.IFrameComponent();
    },
    
    loadRecipe: function(recipe) {
        var id = recipe.get("id");
        window.location.hash = "#" + id;
        var url = this.recipeBase + "/" + id + ".html";
        this.recipeFrame.setUrl(url);        
    }

});
