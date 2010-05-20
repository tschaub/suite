Ext.namespace("og");

/** api: constant[VERSION]
 *  ``String``
 *  This is the Suite version number.  The dashboard will use this to compare
 *  with any existing "suite_version" key in the user's config.ini.  If the 
 *  values are different when the dashboard starts up, then it does the 
 *  necessary upgrade work.
 */
og.VERSION = "1.9.0";

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
        
        this.suite = new og.Suite(config); // TODO: extract just suite config?
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
                this.warn("Offline");
                stoppingDialog.hide();
                
                //if the current config is dirty, update the suite config
                if (this.configDirty == true) {
                    Ext.apply(this.suite.config, this.config); // TODO: extract just suite config?
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
                fn: function() {
                    this.processLinks();
                    this.renderConfigValues();
                },
                scope: this,
                delay: 1
            }
        };
        
        this.initControlPanel();
        this.initLogPanel();
        
        this.viewport = new Ext.Viewport({
            layout: "border",
            items: [{
                xtype: "container",
                cls: "app-panels-control",
                items: [this.controlPanel]                
            }, {
                xtype: "grouptabpanel",
                region: "center", 
                cls: "app-panels-wrap",
                tabWidth: 130,
                activeGroup: 0,
                items: [{
                    defaults: {
                        border: false, 
                        autoScroll: true,
                        listeners: dashPanelListeners
                    },
                    items: [{
                        title: "Dashboard",
                        tabTip: "OpenGeo Suite Dashboard",
                        cls: "dash-panel",
                        bodyStyle: '',
                        html: og.util.loadSync("app/markup/dash/main.html"),
                        id: "app-panels-dash-main"
                    },  {
                        title: "Components",
                        tabTip: "Learn about the components of the OpenGeo Suite",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/dash/components.html"),
                        id: "app-panels-dash-components"
                    }, {
                        xtype: "container",
                        layout: "fit",
                        title: "Logs",
                        tabTip: "View the console log output",
                        cls: "dash-panel",
                        id: "app-panels-help-logs",
                        items: [this.logPanel]
                    }, {
                        border: false,
                        autoScroll: true,
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
                    defaults: {
                        border: false, 
                        autoScroll: true,
                        listeners: dashPanelListeners
                    },
                    items: [{
                        title: "Help",
                        tabTip: "Help",
                        cls: "dash-panel",
                        id: "app-panels-help-main",
                        html: og.util.loadSync("app/markup/help/main.html")
                    },  {
                        title: "Getting Started",
                        tabTip: "Learn about the components of the OpenGeo Suite",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/help/quickstart.html"),
                        id: "app-panels-dash-quickstart"
                    },  {
                        title: "FAQ",
                        tabTip: "Frequently Asked Questions",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/help/faq.html"),
                        id: "app-panels-help-faq"
                    }, {
                        title: "About",
                        tabTip: "Learn more about OpenGeo",
                        cls: "dash-panel",
                        html: og.util.loadSync("app/markup/help/opengeo.html"),
                        id: "app-panels-help-about"
                    }]
                }]
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
        this.processLinks(win.el.dom);
        this.renderConfigValues(win.el.dom);
        
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
                    name: "suite_port",
                    value: this.config["suite_port"]
                },  {
                    fieldLabel: "Shutdown Port",
                    name: "suite_stop_port",
                    value: this.config["suite_stop_port"]
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
                    name: "geoserver_data_dir",
                    value: this.config["geoserver_data_dir"]
                }, {
                    xtype: 'textfield',
                    fieldLabel: "Username",
                    toolTip: "GeoServer adminstrator username",
                    name: "geoserver_username",
                    value: this.config["geoserver_username"]
                }, {
                    xtype: "textfield",
                    id: "geoserver-admin-password",
                    inputType: "password",
                    fieldLabel: "Password",
                    toolTip: "GeoServer adminstrator password",
                    name: "geoserver_password",
                    value: this.config["geoserver_password"],
                    listeners: {
                        change: function(f, e) {
                            //reset the password confiformation form
                            var confirm = this.prefPanel.getForm().findField("geoserver_password_confirm");
                            confirm.setValue("");
                        }, 
                        scope: this
                    }
                }, {
                    xtype: "textfield",
                    inputType: "password",
                    fieldLabel: "Confirm",
                    vtype: "password",
                    name: "geoserver_password_confirm", 
                    value: this.config["geoserver_password"],
                    initialPasswordField: "geoserver-admin-password"
                }]
            }, {
                xtype: "fieldset",
                style: "margin-top: 0.5em;",
                collapsible: true,
                title: "PostGIS",
                defaults: { 
                    width: 50
                },
                defaultType: "textfield",
                items: [{ 
                    fieldLabel: "Port",
                    name: "pgsql_port",
                    value: this.config["pgsql_port"]
                }]
            }],
            buttons: [{
                text: "Save",
                formBind: true,
                handler: function(btn, evt) {
                    var form = this.prefPanel.getForm();
                    var config = this.config;
                    
                    // update suite config
                    config["suite_port"] = form.findField("suite_port").getValue();
                    config["suite_stop_port"] =  form.findField("suite_stop_port").getValue();

                    // update geoserver config
                    var username = form.findField("geoserver_username").getValue();
                    var password = form.findField("geoserver_password").getValue();
                    if (username != config["geoserver_username"] || password != config["geoserver_password"]) {
                        //username password change
                        this.updateGeoServerUserPass(username, password);
                        config["geoserver_username"] = username;
                        config["geoserver_password"] = password;
                    }
                    
                    config["geoserver_data_dir"] = form.findField("geoserver_data_dir").getValue();
                    
                    // update postgres port
                    config["pgsql_port"] = form.findField("pgsql_port").getValue();
        
                    og.util.saveConfig(this.config, 'config.ini');
                    Ext.Msg.alert("Configuration saved", "The suite must be restarted for changes to take effect.");
                    
                    //if the suite is running then we need to keep the old
                    // config around in order to shut it down, so set the dirty
                    // flag and we update the suite config after it shuts down
                    if (this.suite.online == true) {
                        this.configDirty = true;
                    } else {
                        Ext.apply(this.suite.config, this.config);
                    }
                },
                scope: this
            }, {
                text: "Reset", 
                handler: function(btn, evt) {
                    this.prefPanel.getForm().reset();
                },
                scope: this
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
                var port = this.config["suite_port"];
                var host = this.config["suite_host"];
                var id, parts, key, path, url, title;
                if (el.href.indexOf("#") >= 0) {
                    id = el.href.split("#").pop();
                    parts = id.split("-");
                    if (parts.length > 1) {
                        // lookup URL in config
                        key = parts.pop();
                        path = this.config[key];
                        if (path) {
                            title = this.config[key + "_title"];
                            if (!path.match(/^(https?|file):\/\//)) {
                                url = "http://" + host + (port ? ":" + port : "") + path;
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
        
        var plinks = Ext.select(".app-plink", false, root);
        plinks.on({
            click: function(evt, el) {
                var key = el.href.split("#").pop();
                this.launchProcess(key);
            },
            scope: this
        });
        plinks.removeClass("app-plink");        
        
        this.updateOnlineLinks(this.suite.online);
    },
    
    /** private: method[launchProcess]
     *  :arg key: ``String`` Configuration key for process.
     */
    launchProcess: function(key) {
        var app = this.config[key] || "";
        var file = Titanium.Filesystem.getFile(app);
        if (file.exists()) {
            Titanium.Desktop.openApplication(app);
        } else {
            Ext.Msg.alert(
                "Warning",
                "Could not launch application: " + app
            );
        }
    },
    
    /** private: method[renderConfigValues]
     *  :arg root: ``Element`` or ``String`` Optional element or element id
     *      that is the root of any elements that need behavior modification.
     *
     *  Replace content of elements with configuration values.
     */
    renderConfigValues: function(root) {
        var els = Ext.select(".app-config-value", false, root);
        els.each(function(el) {
            var id = el.dom.id;
            if (id) {
                var parts = id.split("-");
                if (parts.length > 1) {
                    var key = parts.pop();
                    var value = this.config[key];
                    if (value) {
                        el.dom.innerHTML = value;
                    }
                }
            }
        }, this);
        els.removeClass("app-config-value");
    },
    
    initControlPanel: function() {

        this.messageBox = new Ext.BoxComponent({
            autoEl: {
                tag: "div",
                html: "",
                cls: "app-panels-control-msg"
            }
        });
        
        var controlButton = new Ext.Button({
            text: !!this.suite.online ? "Shutdown" : "Start",
            enableToggle: true,
            cls: "control-button",
            pressed: !!this.suite.online,
            handler: function(btn) {
                if (btn.pressed) {
                    controlButton.setText("Shutdown");
                    this.suite.start();                        
                } else {
                    controlButton.setText("Start");
                    this.suite.stop();                        
                }
            },
            scope: this
        })

        this.suite.on({
            started: function() {
                controlButton.toggle(true);
                controlButton.setText("Shutdown");
            },
            stopped: function() {
                controlButton.toggle(false);
                controlButton.setText("Start");
            }
        });

        this.controlPanel = new Ext.Container({
            layout: "hbox",
            layoutConfig: {
                align: "middle"
            },
            items: [
                {
                    xtype: "box",
                    autoEl: {
                        tag: "div",
                        html: "<strong>OpenGeo Suite <small>" + this.config["suite_version"] + "</small></strong>"
                    }
                },
                controlButton
            ]
        });

    },
    
    initLogPanel: function() {
        this.logTextArea = new Ext.form.TextArea({
             region: "center",
             margins: "10 10 0 10"
        });
        
        var refreshButton = new Ext.Button({
            text: "read",
            iconCls: "refresh-button",
            handler: function() {
                 this.refreshLog();
            }, 
            scope: this
        });
        
        var clearButton = new Ext.Button({
            text: "clear",
            tooltip: "Clear logs view",
            iconCls: "delete-button",
            handler: function() {
                this.clearLog();
            }, 
            scope: this
        });
        
        var viewButton = new Ext.Button({
            text: "open",
            tooltip: "Open logs with default system viewer",
            iconCls: "view-button",
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
                        html: "<h1>Logs</h1>"
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

        if (!this.refreshingLogDialog) {
            this.refreshingLogDialog = this.createWorkingDialog("Refreshing logs");
        }
        this.refreshingLogDialog.show();
        
        //start a worker to read the log
        og.util.tirun(function() {
            var worker = Titanium.Worker.createWorker("app/script/log.js");
            var self = this;
            worker.onmessage = function(e) {
                var area = self.logTextArea;
                area.setValue(e.message);
                area.el.dom.scrollTop = area.el.dom.scrollHeight
                self.refreshingLogDialog.hide();
                worker.terminate();
            }
            worker.start();
            worker.postMessage({path: this.suite.getLogFile()});
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
        this.logTextArea.setValue("");
    }, 
    
    /** private method[updateOnlineLinks]
     *  :arg online: ``Boolean`` Flag inidciating if services are online.
     * 
     *  Enables/disables all links that require online services to be active.
     */
    updateOnlineLinks: function(online) {
        var olinks = Ext.select(".app-online");
        olinks.each(function(el, c, idx) {
            var dom = el.dom;
            if (online == true) {
                el.removeClass('app-disabled');
                Ext.QuickTips.unregister(dom);
                if (dom.href_off) {
                    dom.href = dom.href_off;
                    dom.removeAttribute('href_off');
                }
            } else {
                el.addClass('app-disabled');
                Ext.QuickTips.register({
                    target: dom,
                    text: "Start the Suite to activate this link."
                });
                if (dom.href) {
                    dom.href_off = dom.href; 
                    dom.removeAttribute('href');
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
            var config = this.config;
            var f = Titanium.Filesystem.getFile(config["geoserver_data_dir"], "security", "users.properties");
            if (f.exists() === true) {
                var props = Titanium.App.loadProperties(f.nativePath());
                
                //has the username changed?
                if (username != config["geoserver_username"]) {
                    //kill the old entry
                    if (props.hasProperty(config["geoserver_username"])) {
                        props.setString(config["geoserver_username"], "dummy, ROLE_DUMMY");    
                    }
                    
                    //add the new one
                    props.setString(username, password + ", ROLE_ADMINISTRATOR");
                }
                else {
                    //just update the entry
                    if (props.hasProperty(config["geoserver_username"])) {
                        var entry = props.getString(config["geoserver_username"]).split(",");
                        entry[0] = password;
                        props.setString(config["geoserver_username"], entry.join(", "));                        
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
        // TODO: decide whether we need a regular place for messages
        
        // var classes = this.messageBox.el.dom.getAttribute("class").split(" ");
        // for (var i = 0; i < classes.length; i++) {
        //     if (classes[i].search("app-msg-") != -1){
        //         this.messageBox.el.removeClass(classes[i]);
        //     }
        // }
        // this.messageBox.el.addClass("app-msg-"+cls);
        // this.messageBox.el.dom.innerHTML = msg;
    }, 

});
