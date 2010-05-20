/**
 * worker whose job is to read the opengeo server log.
 */

function readBuffer(file) {
    var buf = [];
    for (var line = file.readLine(); line !== null; line=file.readLine()) {
        buf.push(line);
        // only keep the last 1000 lines
        if (buf.length > 1000) {
            buf.shift();
        }
    }
    if (buf.length === 0) {
        buf = ["Could not read log file."];
    }
    return buf.join("\n");
}

function readOffset(file) {
     var offset = file.size() - 100*1024;
     var buf = [];
     var count = 0;
              
     file = Titanium.Filesystem.getFileStream(file.nativePath());
     if (file.open(Titanium.Filesystem.MODE_READ) == true) {
          var line = file.readLine();

          //skip over lines until we get to the last 100K
          while(line != null && count < offset) {
              count += line.length+1;
              line = file.readLine();
          }

          while(line != null) {
              buf.push(line);
              line = file.readLine();
          }
          file.close();    
     }
     else {
         postMessage("Could not read log file");
     }
}

function readFile(path) {
    var file = Titanium.Filesystem.getFile(path);
    var message;
    if (file.exists() === true) {
        //readOffset(file);
        message = readBuffer(file);
    }

    if (message == null) {
        message = "Unable to read log from '" + path + "'.";
    }

    postMessage(message);    
}

// handler for messages to worker
onmessage = function(evt) {
    if (evt.message.path) {
        readFile(evt.message.path);
    } else {
        postMessage("bad message to log read worker");
    }
};
