Ext.namespace("og");

Ext.ux.IFrameComponent = Ext.extend(Ext.BoxComponent, {
    
    setUrl: function(url) {
        this.el.dom.contentWindow.location.href = url;
    },
    
    onRender: function(ct, position) {
        this.el = ct.createChild({
            tag: "iframe", 
            id: "iframe-" + this.id, 
            frameBorder: 0, 
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
            fields: ["id", "title", "description", "components", "topics"]
        });
        this.recipeStore.load();
        
    },
    
    initRecipeList: function() {
        
        this.recipeList = new Ext.DataView({
            store: this.recipeStore,
            itemSelector: "div.recipe-entry",
            singleSelect: true,
            tpl: new Ext.XTemplate(
                '<tpl for=".">',
                    '<div class="recipe-entry" id="recipe-{id}">',
                        '<h3>{title}</h3>',
                        '<p>{description}</p>',
                    '</div>',
                '</tpl>'
            ),
            listeners: {
                selectionchange: function(view, selections) {
                    console.log(arguments);
                    var recs = view.getSelectedRecords();
                    // assume singleSelect: true
                    this.loadRecipe(recs[0]);
                },
                scope: this
            }
        });
        
    },
    
    initViewport: function() {

        Ext.QuickTips.init();
        this.initRecipeList();
        this.initRecipeFrame();
        
        this.viewport = new Ext.Viewport({
            layout: "border",
            items: [{
                region: "north",
                xtype: "box",
                height: 40,
                autoEl: {
                    tag: "div",
                    html: "<p>OpenGeo Recipe Book</p>"
                }
            }, {
                region: "west",
                width: 150,
                items: [this.recipeList]
            }, {
                region: "center",
                items: [this.recipeFrame]
            }]
        });

    },
    
    initRecipeFrame: function() {
        this.recipeFrame = new Ext.ux.IFrameComponent();
    },
    
    loadRecipe: function(recipe) {
        
        var url = this.recipeBase + "/" + recipe.get("id") + ".html";
        this.recipeFrame.setUrl(url);
        
    }

});
