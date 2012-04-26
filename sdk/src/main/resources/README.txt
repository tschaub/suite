# OpenGeo Suite Client SDK

The Client SDK provides tools for building web mapping applications backed by 
the OpenGeo Suite.

## Create a new app

From within the SDK directory, use Ant to create a new app:

    ant create -Dapp.path ~/myapp

This creates a directory with the client side resources for your app in the 
~/myapp directory.

## Debug your application

From within the SDK directory, use Ant to launch a server that loads the 
application in debug mode.

    ant debug -Dapp.path ~/myapp

Load up http://localhost:8080/ to see your application.  In production, the 
JavaScript resources for your application will be concatenated and minified.  In
debug mode, all JavaScript is loaded uncompressed to make for easy debugging in
the browser.

When deploying the application in the Suite, you will have access to GeoServer 
at the relative URL of `/geoserver`.  To set up this same relationship while
testing your application, you can proxy your remote Suite GeoServer to make it
look as if it were available locally.

    ant debug -Dapp.path ~/myapp -Dapp.proxy.geoserver http://example.com:8080/geoserver

Running your app in debug mode with the `app.proxy.geoserver` will make your 
remote GeoServer available locally at http://localhost:8080/geoserver.

By default, the debug server runs on port 8080.  To run the server on another 
port, use the `app.port` argument:

    ant debug -Dapp.path ~/myapp -Dapp.port 9080

## Deploying your application

To deploy your application to your remote Suite instance, run the following from
the SDK directory:

    ant deploy -Dapp.path ~/myapp -Dcargo.host http://example.com/ -Dcargo.port 8080 -Dcargo.username tomcat -Dcargo.password tomcat

Provide the URL for your remote Suite instance with the `cargo.host` and 
`cargo.port` arguments.
