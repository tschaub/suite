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
        var line, pair, match, section;
        for (var i=0, len=lines.length; i<len; ++i) {
            line = lines[i].trim();
            match = line.match(/^\s*\[(.*?)\]\s*$/);
            if (match) {
                section = match[1];
            } else if (line) {
                pair = line.split("=");
                if (pair.length === 2) {
                    if (section) {
                        if (!config[section]) {
                            config[section] = {};
                        }
                        config[section][pair[0].trim()] = pair[1].trim();
                    } else {
                        // defaults are pairs before all sections
                        defaults[pair[0].trim()] = pair[1].trim();
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
        var links = Ext.select(".app-xlink");
        links.on({
            click: function(evt, el) {
                var id = el.href.split("#").pop();
                var parts = id.split("-");
                var section = Ext.namespace(parts.slice(0, 3).join("."));
                var key = parts.pop();
                var port = section.port;
                var url = "http://" + section.host + (port ? ":" + port : "") + section[key];
                this.openURL(url);
            },
            scope: this
        });
        links.removeClass("app-xlink");
    },
    
    openURL: function(url) {
        if (window.Titanium) {
            Titanium.Desktop.openURL(url);
        } else {
            window.open(url);
        }
    }
    
};

app.config = app.loadConfig();

Ext.onReady(function() {
    Ext.QuickTips.init();
    
    var viewport = new Ext.Viewport({
        layout: "fit",
        items: [{
            xtype: "grouptabpanel",
            tabWidth: 130,
            activeGroup: 0,
            items: [{
                mainItem: 0,
                defaults: {border: false},
                items: [{
                    title: "Dashboard",
                    tabTip: "OpenGeo Suite Dashboard",
                    cls: "dash-panel",
                    html: app.loadSync("dash/main.html"),
                    listeners: {
                        render: {
                            fn: app.afterPanelRender,
                            scope: app,
                            delay: 1
                        }
                    }
                }, {
                    title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    cls: "dash-panel",
                    html: app.loadSync("dash/geoserver.html"),
                    listeners: {
                        render: {
                            fn: app.afterPanelRender,
                            scope: app,
                            delay: 1
                        }
                    }
                }, {
                    title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    cls: "dash-panel",
                    html: app.loadSync("dash/geoexplorer.html"),
                    listeners: {
                        render: {
                            fn: app.afterPanelRender,
                            scope: app,
                            delay: 1
                        }
                    }
                }, {
                    title: "Styler",
                    tabTip: "Manage Styler",
                    cls: "dash-panel",
                    html: app.loadSync("dash/styler.html"),
                    listeners: {
                        render: {
                            fn: app.afterPanelRender,
                            scope: app,
                            delay: 1
                        }
                    }
                }]
            }, {
                items: [{
                    title: "Configuration",
                    iconCls: "x-icon-configuration",
                    tabTip: "Configuration Information",
                    html: "Any sort of configuration information can go here.  Where stuff is installed, versions, etc.",
                    border: false,
                    cls: "dash-panel"
                }]
            }]
        }]
    });
});

