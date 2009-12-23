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
        if (window.Titanium) {
            return this.loadConfigFS(url);
        }
        else {
            return this.loadConfigHTTP(url);
        }
    }, 
    
    /** private: method[loadConfig]
     *  :arg url: ``String``
     *  :returns: ``Object`` A config object.
     *
     *  Load and parses a config file by requesting it via HTTP.
     */
    loadConfigHTTP: function(url) {
        return this.parseConfig(this.loadSync(url));
    }, 
    
    /** private: method[loadConfig]
     *  :arg filename: ``String``
     *  :returns: ``Object`` A config object.
     *
     *  Load and parse a config file from the filesystem.
     */
    loadConfigFS: function(filename) {
        var fs = Titanium.Filesystem;
        var config = fs.getFile(fs.getUserDirectory().toString(), ".opengeo",
                                filename);

        // if file fodes not exist, create one by loading the default via http
        // and copy it into the proper location
        if (config.exists() == false) {
            // create parent directory if it does not exist
            if (config.parent().exists() == false) {
                config.parent().createDirectory();
            }
            
            config.write(this.loadSync(filename));
        }
        
        return this.parseConfig(config.read().toString());
    }, 
    
    /** private: method[loadConfig]
     *  :arg url: ``String``
     *  :returns: ``Object`` A config object.
     *
     *  Parses the contents of a config file into a config object.
     */    
     parseConfig: function(text) {
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
        
        config['defaults'] = defaults;
        return config;
    }, 
    
    /** api: method[saveConfig]
     *  :arg config: ``Object``
     *
     *  Saves the current config to config.ini in the users home directory.
     */
    saveConfig: function(config) {
        this.tirun(function() {
            var fs = Titanium.Filesystem;
            var sep = fs.getSeparator();
            var file = fs.getFileStream(fs.getUserDirectory() +sep+ ".opengeo"
                                        +sep+ "config.ini");

            if (file.open(fs.MODE_WRITE) == true) {
                for (section in config) {
                    if (section != "defaults") {
                        file.writeLine("["+section+"]");
                    }
                    
                    for (key in config[section]) {
                        //if the key has a default key only write it 
                        // out if its value is different
                        if (section != "defaults" && key in config["defaults"]
                            && config[section][key] == config["defaults"][key]){
                            continue;
                        }
                        
                        file.writeLine(key + "=" + config[section][key]);
                    }
                    file.writeLine(" ");
                }
                file.close();
            }
            else {
                Ext.Msg.alert("Warning",
                              "Could not write to " + file.toString());
            }

        }, config);
    }, 
    
    /**
     * api: method[tirun]
     *  :arg f: ``Function`` The function to execute.
     *  :arg scope: ``Object`` The function execution scope.
     *  :arg fallback: ``Function`` An optional function to execute if titanium
     *    is not available.
     *
     * Executes a function if running in the titanium environment.
     */
    tirun: function(f, scope, fallback) {
        if (window.Titanium) {
            return f.call(scope);
        }
        else {
            if (fallback) {
                return fallback.call(scope);
            }
            else {
                Ext.Msg.alert("Warning",
                              "Titanium is required for this action.");
            }
        }
    }
    
};

/**
 * Separates out platform spcefic properties and operations.
 * 
 */
og.platform = {
    //TODO: have starting just be a single script to run
    "Windows NT": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: [exe]
            });
            p.launch();
        }
    },
    
    "Darwin": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: ["open", exe]
            });
            p.launch();
        },
    },
    
    "Linux": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: [exe]
            });
            p.launch();
        }
    }
};

og.Suite = Ext.extend(Ext.util.Observable, {
    
    /** api: property[statusInterval]
     *  ``Number``
     *  Time in miliseconds between service status checks.  Default is 5000.
     */
    statusInterval: 5000,
    
    /**
     * api: property[config]
     * ``Object``
     * The dashboard configuration.
     */
    config: {},
    
    /** api: property[status]
     *  ``Number``
     *  The HTTP status code for the service this depends on.  Unset by
     *  default.
     */
    status: -1, 
    
    /**
     * api: property[online]
     *  ``Boolean``
     *  Flag indicating if the suite is running. True if the suite is running,
     *  false if the suite is not running, and null if the state is unknown.
     */
    online: null,
    
    constructor: function(config) {
        Ext.apply(this.config, config);
        
        this.addEvents(
            /** api: event[changed]
             *  Fired when the service status changes.  Listeners will be called
             *  with two arguments, the new status and old status codes.
             */
            "changed", 
            
            /** api: event[starting]
             *
             *  Fired when the suite is starting up.
             */
            "starting", 
            
            /** api: event[started]
             *
             *  Fired when the suite has started.
             */
            "started", 
          
            /** api: event[starting]
             *
             *  Fired when the suite is shuttind down.
             */
            "stopping", 
            
            /** api: event[stopped]
             *
             *  Fired when the suite has been stopped.
             */
            "stopped"  
        );
        this.on({
            changed: function(newStatus, oldStatus) {
                if (newStatus >= 200 && newStatus < 300) {
                    //online
                    this.fireEvent("started");
                }
                else {
                    //offline
                    this.fireEvent("stopped");
                }
            },
            scope: this
        });
        this.on({
            started: function() {
                this.online = true;
            },
            scope: this
        });
        this.on({
            stopped: function() {
                this.online = false;
            }, 
            scope: this
        });
    }, 
    
    /**
     * api: method[run]
     *
     * Starts the opengeo suite monitor.
     */
    run: function() {
        window.setInterval(
            this.monitor.createDelegate(this),
            this.statusInterval
        );
        this.monitor();
    }, 
    
    /**
     * private: method[monitor]
     * 
     * Monitors the status of the suite.
     */
    monitor: function() {
        var port = this.config.port || "80";
        var url = "http://" + this.config.host + ":" + port + "/geoserver"
        var client = new XMLHttpRequest();
        client.open("HEAD", url);
        client.onreadystatechange = (function() {
            if(client.readyState === 4) {
                var status = parseInt(client.status, 10);
                if (status !== this.status) {
                    this.fireEvent("changed", status, this.status);
                }
                this.status = status;
            }
        }).createDelegate(this);
        client.send();
    },
    
    /**
     * api: method[start]
     *
     * Starts the suite.
     */
    start: function() {
        og.util.tirun(
            function() {
                sys = og.platform[Titanium.Platform.name]
                if (sys) {
                    sys.startSuite(this.config.exe);
                    this.fireEvent("starting");
                }
                else {
                    Ext.Msg.alert("Warning", "Platform " + 
                        Titanium.Platform.name + " not supported.");
                }
            }, 
            this
        );
    }, 
    
    /**
     * api: method[stop]
     * 
     * Stops the suite.
     */
    stop: function() {
        og.util.tirun(function() {
            var sep = Titanium.Filesystem.getSeparator();
            var jar = Titanium.App.home +sep+"Resources"+sep+ "jetty-start.jar";
            
            var p = Titanium.Process.createProcess({
                args:['java', '-DSTOP.PORT='+this.config.stop_port, 
                    '-DSTOP.KEY=opengeo', '-jar', jar, '--stop']
            });
            p.launch();
            
            this.fireEvent("stopping");
        }, this);
    }
});

og.Dashboard = Ext.extend(Ext.util.Observable, {
    
    /** api: property[debug]
     *  ``Boolean``
     *  Run in debug mode (useful when services are not running on same origin).
     *  Default is false.
     */
    debug: false,

    /**
     * api: property[config]
     * ``Object``
     * The dashboard configuration.
     */
    config: {},
    
    /**
     * private: property[configDirty]
     *  ``Boolean``
     * Flag to track if the configuration has been changed.
     */
    configDirty: false,
    
    constructor: function(config) {
        
        // allow config via query string
        var str = window.location.search.substring(1);
        if (str) {
            Ext.apply(config, Ext.urlDecode(str));
        }
        this.initialConfig = config;
        Ext.apply(this.config, config);
        
        this.suite = new og.Suite(config.suite);
        this.suite.on({
            starting: function() {
                 if (!this.startingWindow) {
                     this.startingWindow = new Ext.Window({
                         modal: true,
                         closable: false,
                         html: og.util.loadSync("app/markup/status/starting.html")
                     });
                 }
                 this.startingWindow.show();
            }, 
            scope: this
        });
        this.suite.on({
            started: function() {
                this.message("The OpenGeo Suite is online.");
                if (this.startingWindow && this.startingWindow.rendered) {
                    this.startingWindow.hide();
                }
                this.updateOnlineLinks(true);
            }, 
            scope: this
        });
        this.suite.on({
            stopping: function() {
                if (!this.stoppingWindow) {
                    this.stoppingWindow = new Ext.Window({
                         modal: true,
                         closable: false,
                         html: og.util.loadSync("app/markup/status/stopping.html")
                    });
                }
                this.stoppingWindow.show();
            }, 
            scope: this
        });
        this.suite.on({
            stopped: function() {
                this.message("The OpenGeo Suite is offline.");
                if (this.stoppingWindow && this.stoppingWindow.rendered) {
                    this.stoppingWindow.hide();
                }
                
                //if the current config is dirty, update the suite config
                if (this.configDirty == true) {
                    Ext.apply(this.suite.config, this.config.suite);
                    this.configDirty = false;
                }
                
                this.updateOnlineLinks(false);
            },
            scope: this
        });

        og.Dashboard.superclass.constructor.call(this);
        
        Ext.onReady(this.createViewport, this);
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
        
        var statusPanelListeners = {
            render: {
                fn: this.afterStatusPanelRender,
                scope: this,
                delay: 1
            }
        };
        
        this.viewport = new Ext.Viewport({
            layout: "border",
            items: [{
                xtype: "grouptabpanel",
                region: "center", 
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
                }, {
                    defaults: {border: false, autoScroll: true},
                    items: [{
                        defaults: {border: false, autoScroll: true},
                        title: "Preferences", 
                        tabTip: "Configure the OpenGeo Suite",
                        cls: "dash-panel",
                        id: "app-panels-pref",
                        listeners: {
                           render: {
                               fn: function() {
                                   this.afterPanelRender();
                                   this.createPrefForm();
                               }, 
                               scope: this,
                               delay: 1
                           } 
                        }, 
                        items: [{
                            xtype: "box", 
                            id: "app-panels-pref",
                            autoEl: {
                                tag: "div",
                                html: og.util.loadSync("app/markup/pref/main.html")
                            },
                        }]
                    }]
                }]
            }, {
                xtype: "box",
                region: "south",
                id: "app-panels-status",
                autoEl: {
                    tag: "div",
                    html: og.util.loadSync("app/markup/status/main.html")
                },
                listeners: statusPanelListeners
            }], 
            listeners: {
                render: {
                    fn: function() {
                        this.suite.run();                            
                    }, 
                    scope: this,
                    delay: 1
                }
            }
        });
        
        // parse hash to activate relevant tab
        this.openPanel(window.location.hash.substring(1));

    },
    
    createPrefForm: function() {
        this.prefPanel = new Ext.FormPanel({
            renderTo: "app-panels-pref-form",
            border: false,
            buttonAlign: "left",
            items: [{
                xtype: "textfield", 
                fieldLabel: "Suite Executable", 
                name: "exe", 
                width: 250,
                value: this.config.suite.exe
            }, { 
                xtype: "textfield",
                fieldLabel: "Port",
                name: "port",
                value: this.config.suite.port
            }, {
                xtype: "textfield",
                fieldLabel: "Shutdown Port",
                name: "stop_port",
                value: this.config.suite.stop_port
            }],
            buttons: [{
                text: "Save",
                handler: function(btn, evt) {
                    var form = this.prefPanel.getForm();
                    this.config.suite.exe = form.findField('exe').getValue();
                    this.config.suite.port = form.findField('port').getValue();
                    this.config.suite.stop_port = 
                        form.findField('stop_port').getValue();

                    og.util.saveConfig(this.config, 'config.ini');
                    this.message("Configuration saved.");
                    
                    //if the suite is running then we need to keep the old
                    // config around in order to shut it down, so set the dirty
                    // flag and we update the suite config after it shuts down
                    if (this.suite.online == true) {
                        this.configDirty = true;
                    }
                    else {
                        Ext.apply(this.suite.config, this.config.suite);
                    }
                },
                scope: this
            }, {
                text: "Revert", 
                handler: function(btn, evt) {
                }
            }]
        })
        return this.prefPanel;
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
                        var tmp = parts.shift();
                        parts.unshift("config");
                        parts.unshift(tmp);
                        
                        // lookup URL in config
                        var section = eval(parts.slice(0, 3).join("."));
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
        
        this.updateOnlineLinks(this.suite.online);
    },
    
    /**
     * private method[afterStatusPanelRender]
     * 
     * Adds behaviour to the status panel.
     */
    afterStatusPanelRender: function() {
        this.afterPanelRender();
        Ext.select("#app-panels-status-start").on({
           click: function(evt, el) {
               this.suite.start();
           },
           scope: this
        });
        
        Ext.select("#app-panels-status-stop").on({
           click: function(evt, el) {
               this.suite.stop();
           }, 
           scope: this
        });
    }, 
    
    /**
     * private method[updateOnlineLinks]
     *  :arg online: ``Boolean`` Flag inidciating if services are online.
     * 
     * Enables/disables all links that require online services to be active.
     */
    updateOnlineLinks: function(online) {
        var olinks = Ext.select(".app-online");
        olinks.each(function(el, c, idx) {
            if (online == true) {
                el.removeClass('app-disabled');
                if (el.dom.href_off) {
                    el.dom['href'] = el.dom.href_off;
                    el.dom.removeAttribute('href_off');
                }
            }
            else {
                el.addClass('app-disabled');
                if (el.dom.href) {
                    el.dom['href_off'] = el.dom.href; 
                    el.dom.removeAttribute('href');
                }
            }
        });
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
    
    /**
     * api method[message]
     *  :arg m: ``String`` The message.
     *
     * Displays a message in the status panel.
     */
    message: function(m) {
        var msg = Ext.get("app-panels-status-msg");
        if (msg) {
            msg.dom.innerHTML = m;
        }
    }, 

});
