Ext.namespace("og");

og.util = {

    /** api: method[loadSync]
     *  :arg url: ``String``
     *
     *  Syncrhonously load a resource.  This is a workaround for Ext XHR
     *  failures with Titanium.
     */
    loadSync: function(url) {
        var client = new XMLHttpRequest();
        client.open("GET", url, false);
        client.send(null);
        return client.responseText;
    },
    
    /** api: method[loadConfig]
     *  :arg url: ``String``
     *  :returns: ``Object`` A config object.
     *
     *  Load and parse a config file given the URL.
     */
    loadConfig: function(url) {
        var text = og.util.loadSync(url);
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
    }

};

og.Dashboard = Ext.extend(Ext.util.Observable, {
    
    /** api: property[statusInterval]
     *  ``Number``
     *  Time in miliseconds between service status checks.  Default is 5000.
     */
    statusInterval: 5000,
    
    /** api: property[debug]
     *  ``Boolean``
     *  Run in debug mode (useful when services are not running on same origin).
     *  Default is false.
     */
    debug: false,
    
    /** api: property[status]
     *  ``Number``
     *  The HTTP status code for the service this depends on.  Assume 200 by
     *  default.
     */
    status: 200,
    
    constructor: function(config) {
        
        // allow config via query string
        var str = window.location.search.substring(1);
        if (str) {
            Ext.apply(config, Ext.urlDecode(str));
        }
        Ext.apply(this, config);
        this.initialConfig = config;
        
        this.addEvents(            
            /** api: event[statuschanged]
             *  Fired when the service status changes.  Listeners will be called
             *  with two arguments, the new status and old status codes.
             */
            "statuschanged"
        );
        
        this.startStatusMonitor();

        og.Dashboard.superclass.constructor.call(this);
        
        Ext.onReady(this.createViewport, this);
        
        this.on({
            statuschanged: function(newStatus, oldStatus) {
                if (newStatus >= 200 && newStatus < 300) {
                    this.hideStatusWarning();
                } else {
                    this.showStatusWarning();
                }
            },
            scope: this
        });
        
    },
    
    startStatusMonitor: function() {
        window.setInterval(
            this.monitorStatus.createDelegate(this),
            this.statusInterval
        );
        this.monitorStatus();
    },
    
    createViewport: function() {

        Ext.QuickTips.init();
        
        var dashPanelListeners = {
            render: {
                fn: this.afterPanelRender,
                scope: this,
                delay: 1
            }
        };
        
        this.viewport = new Ext.Viewport({
            layout: "fit",
            items: [{
                xtype: "grouptabpanel",
                tabWidth: 130,
                activeGroup: 0,
                items: [{
                    defaults: {border: false, autoScroll: true},
                    items: [{
                        title: "Home",
                        tabTip: "OpenGeo Suite Dashboard",
                        cls: "dash-panel",
                        bodyStyle: '',
                        html: og.util.loadSync("app/markup/dash/main.html"),
                        id: "app-panels-dash-main",
                        listeners: dashPanelListeners
                    },  {
                        title: "Quickstart",
                        tabTip: "Get Started",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/quickstart.html"),
                        id: "app-panels-dash-quickstart",
                        listeners: dashPanelListeners
                    },  {
                        title: "GeoExplorer",
                        tabTip: "Manage GeoExplorer",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/geoexplorer.html"),
                        id: "app-panels-dash-geoexplorer",
                        listeners: dashPanelListeners
                    }, {
                        title: "Styler",
                        tabTip: "Manage Styler",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/styler.html"),
                        id: "app-panels-dash-styler",
                        listeners: dashPanelListeners
                    },  {
                        title: "GeoServer",
                        tabTip: "Manage GeoServer",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/geoserver.html"),
                        id: "app-panels-dash-geoserver",
                        listeners: dashPanelListeners
                    }, {
                        title: "GeoWebCache",
                        tabTip: "Manage GeoWebCache",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/geowebcache.html"),
                        id: "app-panels-dash-geowebcache",
                        listeners: dashPanelListeners
                    }]
                }, {
                    defaults: {border: false, autoScroll: true},
                    items: [{
                        title: "OpenGeo",
                        tabTip: "Learn more about OpenGeo",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/opengeo/main.html"),
                        id: "app-panels-opengeo-main",
                        listeners: dashPanelListeners
                    }, {
                        title: "Contact",
                        tabTip: "Contact OpenGeo",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/opengeo/contact.html"),
                        id: "app-panels-opengeo-contact",
                        listeners: dashPanelListeners
                    }]
                }]
            }]
        });
        
        // parse hash to activate relevant tab
        this.openPanel(window.location.hash.substring(1));

    },
    
    /** private: method[afterPanelRender]
     *
     *  Add behavior to links after a panel renders.
     */
    afterPanelRender: function() {
        var xlinks = Ext.select(".app-xlink");
        xlinks.on({
            click: function(evt, el) {
                var path;
                if (el.href.indexOf("#") >= 0) {
                    var id = el.href.split("#").pop();
                    var parts = id.split("-");
                    var path, url, title;
                    if (parts.length > 1) {
                        // lookup URL in config
                        var section = eval(parts.slice(0, 2).join("."));
                        var key = parts.pop();
                        path = section[key];
                        if (path) {
                            title = section[key + "_title"];
                            if (!path.match(/^(https?|file):\/\//)) {
                                var port = section.port;
                                url = "http://" + section.host + (port ? ":" + port : "") + section[key];
                            }
                        }
                    }                    
                }
                if (!path) {
                    // href may be to arbitrary url
                    url = el.href;
                    el.href = "#";
                }
                this.openURL(url, title);
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
            Titanium.Desktop.openURL(url);                
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
    
    monitorStatus: function() {
        if (this.debug === false) {
            var port = this.geoserver.port || "80";
            var url = "http://" + this.geoserver.host + ":" + port + this.geoserver.path;
            var client = new XMLHttpRequest();
            client.open("HEAD", url);
            client.onreadystatechange = (function() {
                if(client.readyState === 4) {
                    var status = parseInt(client.status, 10);
                    if (status !== this.status) {
                        this.fireEvent("statuschanged", status, this.status);
                    }
                    this.status = status;
                }
            }).createDelegate(this);
            client.send();
        }
    },
    
    showStatusWarning: function() {
        if (!this.statusWarning) {
            this.statusWarning = new Ext.Window({
                title: "Warning",
                iconCls: "dash-warning-header",
                modal: true,
                closable: false,
                html: og.util.loadSync("app/markup/status-warning.html")
            });
        }
        this.statusWarning.show();        
    },
    
    hideStatusWarning: function() {
        if (this.statusWarning) {
            this.statusWarning.hide();
        }
    }

});
