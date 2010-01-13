/**
 * worker whose job is to read the opengeo server log.
 */

readbuffer = function(file) {
    //only read the last 1000 elements
    var buf = [];
    
    file = Titanium.Filesystem.getFileStream(file.nativePath());
    if (file.open(Titanium.Filesystem.MODE_READ) == true) {
        var line = file.readLine();
        while(line != null && buf.length < 1000) {
            buf.push(line);
            line = file.readLine();
        }
    
        //if we still have lines to read means the queue is full
        while(line != null) {
            buf.pop();
            buf.push(line);
            line = file.readLine();
        }
        file.close();
        return buf.join("\n");
    }
    else {
        return "Could not read log file";
    }
}

readoffset = function(file) {
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

var fs = Titanium.Filesystem;
var file = fs.getFile(fs.getResourcesDirectory().toString(), "log");
var message = null;
if (file.exists() === true) {
    var logfile = file.read();
    
    if (logfile != null) {
        file = fs.getFile(logfile.toString());    
        if (file.exists() === true) {
            //readoffset(file);
            message = readbuffer(file);
        }
    }
}

if (message == null) {
    message = "Unable to read log";
}

postMessage(message);

