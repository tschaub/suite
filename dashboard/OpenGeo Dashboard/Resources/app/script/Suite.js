Ext.namespace("og");

og.Suite = Ext.extend(Ext.util.Observable, {
    
    /** api: property[statusInterval]
     *  ``Number``
     *  Time in miliseconds between service status checks.  Default is 5000.
     */
    statusInterval: 5000,
    
    /** api: property[config]
     *  ``Object``
     *  The suite configuration.
     */
    config: null,
    
    /** api: property[status]
     *  ``Number``
     *  The HTTP status code for the service this depends on.  Unset by
     *  default.
     */
    status: -1, 
    
    /** api: property[online]
     *  ``Boolean``
     *  Flag indicating if the suite is running. True if the suite is running,
     *  false if the suite is not running, and null if the state is unknown.
     */
    online: null,
    
    constructor: function(config) {
        this.initialConfig = config;
        this.config = Ext.apply({}, config);
        
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
            started: function() {
                this.online = true;
            },
            stopping: function() {
                this.online = false;
            },
            stopped: function() {
                this.online = false;
            }, 
            scope: this
        });
    }, 
    
    /**
     * api: method[getLogFile]
     * :return: ``String`` The absolute path to the log file.
     *
     * Returns the location of the suite log file.
     */
    getLogFile: function() {
        return og.util.tirun(
            function() {
                var fs = Titanium.Filesystem;
                var home = fs.getUserDirectory();
                var f = fs.getFile(
                    home.nativePath(), ".opengeo", "logs", "opengeosuite.log");
                return f.nativePath();
            }, 
            this, 
            function() {
                return this.config["suite_dir"] + "/logs/opengeosuite.log";
            }
        );
    }, 
    
    /** api: method[run]
     *
     *  Starts the opengeo suite monitor.
     */
    run: function() {
        window.setInterval(
            this.monitor.createDelegate(this),
            this.statusInterval
        );
        this.monitor();
    }, 
    
    /** private: method[monitor]
     * 
     *  Monitors the status of the suite.
     */
    monitor: function() {
        var port = this.config["suite_port"] || "80";
        var url = "http://" + this.config["suite_host"] + ":" + port + "/geoserver"
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
    
    /** api: method[start]
     *
     *  Starts the suite.
     */
    start: function() {
        og.util.tirun(
            function() {
                var p = Titanium.Process.createProcess({
                    args: [this.config["suite_exe"], "start"]
                });
                p.launch();
                
                this.fireEvent("starting");
            }, 
            this
        );
    }, 
    
    /** api: method[stop]
     * 
     *  Stops the suite.
     */
    stop: function() {
        og.util.tirun(function() {
            var p = Titanium.Process.createProcess({
                args: [this.config["suite_exe"], "stop"]
            });
            p.launch();

            this.fireEvent("stopping");
        }, this);
    }

});
