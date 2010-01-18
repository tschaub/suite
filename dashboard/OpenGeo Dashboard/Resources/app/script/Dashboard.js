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
    
    /** private: property[platform]
     * ``Object``
     * 
     * Instance of og.platform that encapsulates os specific operations.
     */
    platform: null,
    
    /** api: property[DEFAULTS]
     *  ``Object``
     *  Default preferences.
     *
     *  Members:
     *   * helpOnStart - ``Boolean`` Show help dialog on start.  Default is true.
     */
    DEFAULTS: {
        helpOnStart: true
    },
    
    /** private: property[dbName]
     *  ``String``
     *  Database name for storage of user preferences.
     */
    dbName: "org.opengeo.suite",
    
    constructor: function(config) {
        
        // apply default preferences
        this.setPreferences(Ext.applyIf(this.getPreferences(), this.DEFAULTS));
        
        // allow config via query string
        var str = window.location.search.substring(1);
        if (str) {
            Ext.apply(config, Ext.urlDecode(str));
        }
        this.initialConfig = config;
        this.config = Ext.apply({}, config);
        
        this.suite = new og.Suite(config.suite);
        og.util.tirun(function() {
            this.platform = og.platform[Titanium.Platform.name];
        }, this, function(){}    );
        
        var startingDialog = this.createWorkingDialog("Starting the OpenGeo Suite");
        var stoppingDialog = this.createWorkingDialog("Stopping the OpenGeo Suite");

        this.suite.on({
            starting: function() {
                startingDialog.show();
            }, 
            started: function() {
                this.ok("The OpenGeo Suite is online.");
                startingDialog.hide();
                this.updateOnlineLinks(true);
            }, 
            stopping: function() {
                stoppingDialog.show();
            }, 
            stopped: function() {
                this.warn("The OpenGeo Suite is offline.");
                stoppingDialog.hide();
                
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
    
    getPreferences: function(key) {
        var preferences = og.util.tirun(function() {
            var db = Titanium.Database.open(this.dbName);
            db.execute("CREATE TABLE IF NOT EXISTS preferences (blob TEXT)");
            var results = db.execute("SELECT * FROM preferences");
            var preferences = Ext.decode(results.field(0)) || {};
            results.close();
            db.close();
            return preferences;
        }, this, function() {
            return this.DEFAULTS;
        });
        
        return key ? preferences[key] : preferences;      
    },
    
    setPreferences: function(preferences) {
        preferences = Ext.apply(this.getPreferences(), preferences);
        this.clearPreferences();
        og.util.tirun(function() {
            var db = Titanium.Database.open(this.dbName);
            db.execute("INSERT INTO preferences (blob) VALUES (?)", Ext.encode(preferences));
            db.close();
        }, this, function(){});
        
        return preferences;
    },
    
    clearPreferences: function() {
        og.util.tirun(function() {
            var db = Titanium.Database.open(this.dbName);
            db.execute("DROP TABLE IF EXISTS preferences");
            db.close();
        }, this, function(){});
        
        this.getPreferences();
    },
    
    createWorkingDialog: function(msg) {
        var dialog = new Ext.Window({
            title: "Working...",
            closeAction: "hide",
            bodyCssClass: "working-dialog",
            modal: true,
            constrain: true,
            html: msg
        });
        return dialog;
    }, 
    
    createViewport: function() {

        Ext.QuickTips.init();
        
        var dashPanelListeners = {
            render: {
                fn: function() {this.processLinks()},
                scope: this,
                delay: 1
            }
        };
        
        this.initControlPanel();
        this.initLogPanel();
        
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
                        defaults: {border: false, autoScroll: true},
                        title: "Preferences", 
                        tabTip: "Configure the OpenGeo Suite",
                        cls: "dash-panel",
                        id: "app-panels-pref-main",
                        listeners: {
                           render: {
                               fn: function() {
                                   this.processLinks();
                                   this.createPrefForm();
                               }, 
                               scope: this,
                               delay: 1
                           } 
                        }, 
                        items: [{
                            xtype: "box", 
                            autoEl: {
                                tag: "div",
                                html: og.util.loadSync("app/markup/pref/main.html")
                            },
                        }]
                    }]
                }, {
                    defaults: {border: false, autoScroll: true}, 
                    items: [{
                        title: "Help",
                        cls: "dash-panel",
                        id: "app-panels-help",
                        html: og.util.loadSync("app/markup/help/main.html")
                    },  {
                        title: "FAQ",
                        tabTip: "Frequently Asked Questions",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/help/faq.html"),
                        id: "app-panels-help-faq",
                        listeners: dashPanelListeners
                    }, {
                        xtype: "container",
                        layout: "fit",
                        title: "Logs",
                        cls: "dash-panel",
                        id: "app-panels-help-logs",
                        items: [this.logPanel]
                    }, {
                        title: "About",
                        tabTip: "Learn more about OpenGeo",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/help/opengeo.html"),
                        id: "app-panels-help-about",
                        listeners: dashPanelListeners
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
        
        if (this.getPreferences("helpOnStart")) {
            this.showStartHelp();
        }

    },
    
    showStartHelp: function() {
        var win = new Ext.Window({
            modal: true,
            title: "Welcome",
            html: og.util.loadSync("app/markup/help/start.html"),
            width: "50%",
            constrain: true,
            bbar: [" ", {
                xtype: "checkbox",
                boxLabel: "Show this dialog at startup",
                checked: this.getPreferences("helpOnStart"),
                handler: function(box, checked) {
                    this.setPreferences({helpOnStart: checked});
                },
                scope: this
            }, "->", {
                text: "Close",
                iconCls: "cancel-button",
                handler: function() {
                    win.close();
                }
            }]
        });
        win.show();
        console.log(win.el.dom);
        this.processLinks(win.el.dom);
        
        Ext.select("#app-start-pref-link").on({
            click: function() {
                win.close();
            }, 
            delay: 1
        });
    },
    
    createPrefForm: function() {
        // create a password field validator
        Ext.apply(Ext.form.VTypes, {
           password: function(value, field)
           {
              if (field.initialPasswordField)
              {
                 var pwd = Ext.getCmp(field.initialPasswordField);
                 this.passwordText = 'Passwords do not match.';
                 return (value == pwd.getValue());
              }
         
              return true;
           },
         
           passwordText: ''
        });
        
        this.prefPanel = new Ext.FormPanel({
            renderTo: "app-panels-pref-form",
            //fileUpload: true,
            border: false,
            buttonAlign: "right",
            monitorValid: true,
            items: [{
                xtype: "fieldset",
                style: "margin-top: 0.5em;",
                collapsible: true,
                title: "Service Ports",
                defaultType: 'textfield',
                defaults: { 
                    width: 50
                },
                items: [{ 
                    fieldLabel: "Primary Port",
                    name: "port",
                    value: this.config.suite.port
                },  {
                    fieldLabel: "Shutdown Port",
                    name: "stop_port",
                    value: this.config.suite.stop_port
                }]
            }, {
                xtype: "fieldset",
                style: "margin-top: 0.5em;",
                collapsible: true,
                title: "GeoServer",
                defaults: { 
                    width: 250,
                    allowBlank: false,
                },
                items: [{ 
                    xtype: 'textfield',
                    fieldLabel: "Data Directory",
                    name: "data_dir",
                    value: this.config.geoserver.data_dir
                }, {
                    xtype: 'textfield',
                    fieldLabel: "Username",
                    toolTip: "GeoServer adminstrator username",
                    name: "username",
                    value: this.config.geoserver.username
                }, {
                    xtype: "textfield",
                    id: "geoserver-admin-password",
                    inputType: "password",
                    fieldLabel: "Password",
                    toolTip: "GeoServer adminstrator password",
                    name: "password",
                    value: this.config.geoserver.password,
                    listeners: {
                        change: function(f, e) {
                            //reset the password confiformation form
                            var confirm = this.prefPanel.getForm().findField('password_confirm');
                            confirm.setValue("");
                        }, 
                        scope: this
                    }
                }, {
                    xtype: "textfield",
                    inputType: "password",
                    fieldLabel: "Confirm",
                    vtype: "password",
                    name: "password_confirm", 
                    value: this.config.geoserver.password,
                    initialPasswordField: "geoserver-admin-password"
                }]
            },  {
                xtype: "fieldset",
                style: "margin-top: 0.5em;",
                collapsible: true,
                title: "Advanced",
                collapsed: true,
                defaults: { 
                    width: 250
                },
                items: [{
                    //xtype: 'fileuploadfield',
                    xtype: 'textfield',
                    id: 'exe',
                    //emptyText: this.config.suite.exe,
                    value: this.config.suite.exe,
                    fieldLabel: "Suite Executable",
                    name: "exe",
                    /*buttonCfg: {
                        text:'', 
                        tooltip: 'Browse for your Suite executable file'
                    }*/
                }]
            }],
            buttons: [{
                text: "Save",
                formBind: true,
                handler: function(btn, evt) {
                    var form = this.prefPanel.getForm();
                    
                    //save suite config
                    var suite = this.config.suite;
                    suite.exe = form.findField('exe').getValue();
                    suite.port = form.findField('port').getValue();
                    suite.stop_port =  form.findField('stop_port').getValue();

                    //save geoserver config
                    var gs = this.config.geoserver;
                    var username = form.findField("username").getValue();
                    var password = form.findField("password").getValue();
                    if (username != gs.username || password != gs.password) {
                        //username password change
                        this.updateGeoServerUserPass(username, password);
                        gs.username = username;
                        gs.password = password;
                    }
                    
                    gs.data_dir = form.findField("data_dir").getValue();
        
                    og.util.saveConfig(this.config, 'config.ini');
                    this.info("Configuration saved. The suite must be restarted for changes to take effect.");
                    
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
                text: "Reset", 
                handler: function(btn, evt) {
                }
            }]
        })
        return this.prefPanel;
    }, 
    
    /** private: method[processLinks]
     *  :arg root: ``Element`` or ``String`` Optional element or element id
     *      that is the root of any elements that need behavior modification.
     *
     *  Add behavior to links after a panel renders.
     */
    processLinks: function(root) {
        var xlinks = Ext.select(".app-xlink", false, root);
        xlinks.on({
            click: function(evt, el) {
                var port = this.config.suite.port;
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

        var ilinks = Ext.select(".app-ilink", false, root);
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
                html: "",
                cls: "app-panels-control-msg"
            }
        });

        var startButton = new Ext.Button({
            text: "Start",
            iconCls: "start-button",
            cls: "control-button",
            disabled: !!this.suite.online,
            handler: function() {
                this.suite.start();
            },
            scope: this
        });
        this.suite.on({
            started: function() {
                startButton.disable();
            },
            stopped: function() {
                startButton.enable();
            }
        });

        var stopButton = new Ext.Button({
            text: "Stop",
            iconCls: "stop-button",
            cls: "control-button",
            disabled: !this.suite.online,
            handler: function() {
                this.suite.stop();
            },
            scope: this
        });
        this.suite.on({
            stopped: function() {
                stopButton.disable();
            },
            started: function() {
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
    
    initLogPanel: function() {
        this.logTextArea = new Ext.form.TextArea({
             region: "center",
             margins: "10 10 0 10"
        });
        
        var refreshButton = new Ext.Button({
            text: "",
            iconCls: "refresh-button",
            cls: "control-button",
            handler: function() {
                 this.refreshLog();
            }, 
            scope: this
        });
        
        //hack for windows, we need to disable the refresh log while the suite is
        // online
        if (this.platform && this.platform.name == "Windows") {
            this.suite.on({
                started: function() {
                    refreshButton.setDisabled(true);
                    refreshButton.setTooltip("Log refresh unavailable while suite is online.");
                },
                
                stopped: function() {
                    refreshButton.setDisabled(false);
                    refreshButton.setTooltip("Refresh view of the log");
                }
            });
        }
        
        var clearButton = new Ext.Button({
            text: "",
            tooltip: "Clear view of the log",
            iconCls: "delete-button",
            cls: "control-button",
            handler: function() {
                this.clearLog();
            }, 
            scope: this
        });
        
        var viewButton = new Ext.Button({
            text: "",
            tooltip: "View the log with an external program",
            iconCls: "view-button",
            cls: "control-button",
            handler: function() {
                this.openLog();
            }, 
            scope: this
        });
        
        this.logPanel = new Ext.Container({
            layout: "border",
            items: [{
                xtype: "container",
                region: "north",
                layout: "fit",
                cls: "dash-panel-body",
                items: [{
                    xtype: "box",
                    cls: "dash-panel-content",
                    autoEl: {
                        tag: "div",
                        html: "<h4>Logs</h4>",
                    }
                }]
            }, 
            this.logTextArea, {
                xtype: "container",
                region: "south",
                layout: "hbox",
                margins: "2 10 10 10",
                items: [
                    {xtype: "spacer", flex: 1},
                    refreshButton,
                    clearButton,
                    viewButton
                ]
            }]
        });
    }, 
    
    /**
     * api: method[refreshLog]
     * 
     * Refreshes the log view by reading from the suite log file and 
     * displaying the contents in the log view text area.
     */
    refreshLog: function() {
        //this is a hack, i don't see any good way to pass parameters into a worker
        // so that it can run without blocking the main user interface thread
        // so we write out a file that contains the location of the log file, then 
        // the worker looks for this file and reads the location of the log file
        og.util.tirun(function() {
            var fs = Titanium.Filesystem;
            var f = fs.getFile(fs.getResourcesDirectory().toString(), "log");
            if (f.exists() === false) {
                f.write(this.suite.getLogFile());
            }
        }, this);
        
        if (!this.refreshingLogDialog) {
            this.refreshingLogDialog = this.createWorkingDialog("Refreshing logs");
        }
        this.refreshingLogDialog.show();
        
        //start a worker to read the log
        og.util.tirun(function() {
            var worker = Titanium.Worker.createWorker("app/script/log.js");
            var self = this;
            worker.onmessage = function(e) {
                self.logTextArea.el.dom.innerHTML = e.message;
                self.refreshingLogDialog.hide();
                worker.terminate();
            }
            worker.start();
        }, this);
    }, 
    
    /**
     * api: method[openLog]
     * 
     * Opens the log file in the default system editor.
     */
    openLog: function() {
        og.util.tirun(
            function() {
                var f = Titanium.Filesystem.getFile(this.suite.getLogFile());
                if (f.exists() === true) {
                    var path = f.nativePath().replace(" ", "%20");
                    var url;
                    if (this.platform && this.platform.toURL) {
                        url = this.platform.toURL(path);
                    }
                    else {
                        url = "file://" + path;
                    }
                    Titanium.Desktop.openURL(url);
                }
            }, 
            this
        );
    }, 
    
    /**
     * api: method[clearLog]
     *
     * Clears the log view by clearing the contents of teh log view text area.
     */
    clearLog: function() {
        this.logTextArea.el.dom.innerHTML = "";
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

    /**
     * private: method[updateGeoServerUserPass]
     * :arg: username: ``String`` The new username
     * :arg: password: ``Password`` The new password
     * 
     * :return: ``Boolean`` True if the username and password were updated.
     * 
     * Updates the GeoServer adminstrator username and password.
     */    
    updateGeoServerUserPass: function(username, password) {
        og.util.tirun(function() {
            //load the GeoServer users.properties file
            var gs = this.config.geoserver;
            var f = Titanium.Filesystem.getFile(gs.data_dir, "security", "users.properties");
            if (f.exists() === true) {
                var props = Titanium.App.loadProperties(f.nativePath());
                
                //has the username changed?
                if (username != gs.username) {
                    //kill the old entry
                    if (props.hasProperty(gs.username)) {
                        props.setString(gs.username, "dummy, ROLE_DUMMY");    
                    }
                    
                    //add the new one
                    props.setString(username, password + ", ROLE_ADMINISTRATOR");
                }
                else {
                    //just update the entry
                    if (props.hasProperty(gs.username)) {
                        var entry = props.getString(gs.username).split(",");
                        entry[0] = password;
                        props.setString(gs.username, entry.join(", "));                        
                    }
                    else {
                        //for some reason did not exist, just add a new one
                        props.setString(username, password+", ROLE_ADMINISTRATOR");
                    }
                }
                
                props.saveTo(f.nativePath());
                return true;
            }
            
            return false;
        }, this);
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
    
    /** api method[info]
     *  :arg msg: ``String`` The message.
     *
     *  Displays a message in the status panel to relay information.
     */
    info: function(msg) {
        this.message(msg, "info");
    }, 
    
    /** api method[warn]
     *  :arg msg: ``String`` The message.
     *
     *  Displays a message in the status panel to indicate a warning state.
     */
    warn: function(msg) {
        this.message(msg, "warn");
    }, 
    
    /** api method[ok]
     *  :arg msg: ``String`` The message.
     *
     *  Displays a message in the status panel to indicate an ok state.
     */
    ok: function(msg) {
        this.message(msg, "ok");
    }, 
    
    /** private method[message]
     *  :arg msg: ``String`` The message.
     *
     *  Displays a message in the status panel.
     */
    message: function(msg, cls) {
        var classes = this.messageBox.el.dom.getAttribute("class").split(" ");
        for (var i = 0; i < classes.length; i++) {
            if (classes[i].search("app-msg-") != -1){
                this.messageBox.el.removeClass(classes[i]);
            }
        }
        this.messageBox.el.addClass("app-msg-"+cls);
        this.messageBox.el.dom.innerHTML = msg;
    }, 

});
