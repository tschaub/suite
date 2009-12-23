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
