Ext.namespace("og");

og.Dashboard = Ext.extend(Ext.util.Observable, {
    
    /** api: property[debug]
     *  ``Boolean``
     *  Run in debug mode (useful when services are not running on same origin).
     *  Default is false.
     */
    debug: false,

    /** api: property[config]
     *  ``Object``
     *  The dashboard configuration.
     */
    config: null,
    
    /** private: property[configDirty]
     *  ``Boolean``
     *  Flag to track if the configuration has been changed.
     */
    configDirty: false,
    
    constructor: function(config) {
        
        // allow config via query string
        var str = window.location.search.substring(1);
        if (str) {
            Ext.apply(config, Ext.urlDecode(str));
        }
        this.initialConfig = config;
        this.config = Ext.apply({}, config);
        
        this.suite = new og.Suite(config.suite);
        this.suite.on({
            starting: function() {
                 if (!this.startingWindow) {
                     this.startingWindow = new Ext.Window({
                         modal: true,
                         closable: false,
                         html: "Starting the OpenGeo Suite"
                     });
                 }
                 this.startingWindow.show();
            }, 
            started: function() {
                this.message("The OpenGeo Suite is online.");
                if (this.startingWindow && this.startingWindow.rendered) {
                    this.startingWindow.hide();
                }
                this.updateOnlineLinks(true);
            }, 
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
        
        this.initControlPanel();
        
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
                region: "south",
                xtype: "container",
                cls: "app-panels-control",
                items: [this.controlPanel]
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
    
    initControlPanel: function() {

        this.messageBox = new Ext.BoxComponent({
            autoEl: {
                tag: "div",
                html: ""
            }
        });

        var startButton = new Ext.Button({
            text: "Start",
            iconCls: "start-button",
            cls: "control-button",
            hidden: !!this.suite.online,
            handler: function() {
                this.suite.start();
            },
            scope: this
        });
        this.suite.on({
            starting: function() {
                startButton.disable();
            },
            started: function() {
                startButton.hide();
            },
            stopped: function() {
                startButton.show();
                startButton.enable();
            }
        });

        var stopButton = new Ext.Button({
            text: "Stop",
            iconCls: "stop-button",
            cls: "control-button",
            hidden: !this.suite.online,
            handler: function() {
                this.suite.stop();
            },
            scope: this
        });
        this.suite.on({
            stopping: function() {
                stopButton.disable();
            },
            stopped: function() {
                stopButton.hide();
            },
            started: function() {
                stopButton.show();
                stopButton.enable();
            }
        });

        this.controlPanel = new Ext.Container({
            layout: "hbox",
            items: [
                this.messageBox, 
                {xtype: "spacer", flex: 1},
                startButton, 
                stopButton
            ]
        });

    },
    
    /** private method[updateOnlineLinks]
     *  :arg online: ``Boolean`` Flag inidciating if services are online.
     * 
     *  Enables/disables all links that require online services to be active.
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
    
    /** api method[message]
     *  :arg m: ``String`` The message.
     *
     *  Displays a message in the status panel.
     */
    message: function(m) {
        this.messageBox.el.dom.innerHTML = m;
    }, 

});
