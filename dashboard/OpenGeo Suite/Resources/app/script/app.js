var app = {

    loadSync: function(url) {
        var client = new XMLHttpRequest();
        client.open("GET", url, false);
        client.send(null);
        return client.responseText;
    },
    
    loadConfig: function() {
        var text = this.loadSync("config.ini");
        var lines = text.split(/[\n\r]/);
        var config = {};
        var defaults = {};
        var line, pair, key, value, match, section;
        for (var i=0, len=lines.length; i<len; ++i) {
            line = lines[i].trim();
            match = line.match(/^\s*\[(.*?)\]\s*$/);
            if (match) {
                section = match[1];
            } else if (line) {
                pair = line.split("=");
                if (pair.length > 1) {
                    key = pair.shift().trim();
                    value = pair.join("=").trim();
                    if (section) {
                        if (!config[section]) {
                            config[section] = {};
                        }
                        config[section][key] = value;
                    } else {
                        // defaults are pairs before all sections
                        defaults[key] = value;
                    }
                }
            }
        }
        // apply all defaults to each section
        for (section in config) {
            for (var key in defaults) {
                if (!(key in config[section])) {
                    config[section][key] = defaults[key];
                }
            }
        }
        return config;
    },
    
    afterPanelRender: function() {
        var xlinks = Ext.select(".app-xlink");
        xlinks.on({
            click: function(evt, el) {
                var id = el.href.split("#").pop();
                var parts = id.split("-");
                var section = Ext.namespace(parts.slice(0, 3).join("."));
                var key = parts.pop();
                var path = section[key];
                var title = section[key + "_title"];
                if (path.match(/^(file|https?):/)) {
                    this.openURL(path, title);
                } else {
                    var port = section.port;
                    var url = "http://" + section.host + (port ? ":" + port : "") + section[key];
                    this.openURL(url, title);
                }
            },
            scope: this
        });
        xlinks.removeClass("app-xlink");

        var ilinks = Ext.select(".app-ilink");
        ilinks.on({
            click: function(evt, el) {
                var id = el.href.split("#").pop();
                this.openPanel(id);
            },
            scope: this
        });
        ilinks.removeClass("app-ilink");
    },
    
    openURL: function(url, title) {
        url = encodeURI(url);
        if (window.Titanium) {
            if (url.match(/^https?:/)) {
                Titanium.Desktop.openURL(url);                
            } else {
                var win = Titanium.UI.getCurrentWindow().createWindow({
                    url: url,
                    title: title
                });
                win.open();
            }
        } else {
            window.open(url);
        }
    },
    
    openPanel: function(id) {
        var panel = Ext.getCmp(id);
        if (panel && panel.ownerCt) {
            panel.ownerCt.setActiveTab(panel);
        }
    },
    
    getConfigSections: function() {
        var config = this.config;
        var sections = [];
        for (var id in config) {
            var items = [];
            for (var key in config[id]) {
                if (key !== "title") {
                    items.push({name: key, value: config[id][key]});
                }
            }
            sections.push({
                title: config[id].title,
                items: items.sort(function(a, b) {return a.name > b.name;})
            });
        }
        return sections;
    }
    
};

app.config = app.loadConfig();

Ext.onReady(function() {
    Ext.QuickTips.init();
    
    var dashPanelListeners = {
        render: {
            fn: app.afterPanelRender,
            scope: app,
            delay: 1
        }
    };
    
    var viewport = new Ext.Viewport({
        layout: "fit",
        items: [{
            xtype: "grouptabpanel",
            tabWidth: 130,
            activeGroup: 0,
            items: [{
                defaults: {border: false, autoScroll: true},
                items: [{
                    title: "Dashboard",
                    tabTip: "OpenGeo Suite Dashboard",
                    cls: "dash-panel",
                    html: app.loadSync("app/markup/dash/main.html"),
                    id: "app-panels-dash-main",
                    listeners: dashPanelListeners
                }, {
                    title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    cls: "dash-panel",
                    html: app.loadSync("app/markup/dash/geoserver.html"),
                    id: "app-panels-dash-geoserver",
                    listeners: dashPanelListeners
                }, {
                    title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    cls: "dash-panel",
                    html: app.loadSync("app/markup/dash/geoexplorer.html"),
                    id: "app-panels-dash-geoexplorer",
                    listeners: dashPanelListeners
                }, {
                    title: "Styler",
                    tabTip: "Manage Styler",
                    cls: "dash-panel",
                    html: app.loadSync("app/markup/dash/styler.html"),
                    id: "app-panels-dash-styler",
                    listeners: dashPanelListeners
                }]
            }, {
                items: [{
                    title: "Configuration",
                    iconCls: "x-icon-configuration",
                    tabTip: "Configuration Information",
                    html: new Ext.XTemplate(
                        app.loadSync("app/markup/config.html")
                    ).apply(app.getConfigSections()),
                    border: false,
                    id: "app-panels-config-main",
                    autoScroll: true,
                    cls: "dash-panel"                    
                }]
            }]
        }]
    });
    
    // parse hash to activate relevant tab
    app.openPanel(window.location.hash.substring(1));
    
});

