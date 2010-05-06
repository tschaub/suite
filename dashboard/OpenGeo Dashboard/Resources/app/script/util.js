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
        var config;
        if (window.Titanium) {
            config = this.loadConfigFS(url);
        } else {
            config = this.loadConfigHTTP(url);
        }
        var version = config["suite_version"];
        if (!version) {
            // 1.0.0 or invalid config
            window.alert("You are using an outdated config.ini file.  Upgrade not yet supported.");
        }
        return config;
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
        var line, pair, key, value, match;
        for (var i=0, len=lines.length; i<len; ++i) {
            line = lines[i].trim();
            if (line) {
                pair = line.split("=");
                if (pair.length > 1) {
                    key = pair.shift().trim();
                    value = pair.join("=").trim();
                    config[key] = value;
                }
            }
        }
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
            var file = fs.getFileStream(
                fs.getUserDirectory() +sep+ ".opengeo" +sep+ "config.ini"
            );

            if (file.open(fs.MODE_WRITE) == true) {
                for (key in config) {
                    file.writeLine(key + "=" + config[key]);
                }
                file.close();
            } else {
                Ext.Msg.alert("Warning",
                              "Could not write to " + file.toString());
            }

        }, config);
    }, 
    
    /** api: method[tirun]
     *  :arg f: ``Function`` The function to execute.
     *  :arg scope: ``Object`` The function execution scope.
     *  :arg fallback: ``Function`` An optional function to execute if titanium
     *      is not available.
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
