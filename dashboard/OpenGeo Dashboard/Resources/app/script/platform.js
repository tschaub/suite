Ext.namespace("og");

/**
 * Separates out platform spcefic properties and operations.
 */
og.platform = {
    //TODO: have starting just be a single script to run
    "Windows NT": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: [exe, "start"]
            });
            p.launch();
        }, 
        
        toURL: function(filePath) {
            return "file:///" + filePath;
        }
    },
    
    "Darwin": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: ["open", exe]
            });
            p.launch();
        }
    },
    
    "Linux": {
        startSuite: function(exe) {
            var p = Titanium.Process.createProcess({
                args: [exe, "start"]
            });
            p.launch();
        }
    }
};
