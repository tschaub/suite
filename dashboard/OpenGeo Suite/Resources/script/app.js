Ext.onReady(function() {
    Ext.QuickTips.init();
    
    var viewport = new Ext.Viewport({
        layout: "fit",
        items: [{
            xtype: "grouptabpanel",
            tabWidth: 130,
            activeGroup: 0,
            items: [{
                mainItem: 0,
                defaults: {border: false},
                items: [{
                    title: "Dashboard",
                    tabTip: "OpenGeo Suite Dashboard",
                    cls: "dash-panel",
                    html: app.loadSync("dash/main.html")
                }, {
                    title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    cls: "dash-panel",
                    html: app.loadSync("dash/geoserver.html")
                }, {
                    title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    cls: "dash-panel",
                    html: app.loadSync("dash/geoexplorer.html")
                }, {
                    title: "Styler",
                    tabTip: "Manage Styler",
                    cls: "dash-panel",
                    html: app.loadSync("dash/styler.html")
                }]
            }, {
                items: [{
                    title: "Configuration",
                    iconCls: "x-icon-configuration",
                    tabTip: "Configuration Information",
                    html: "Any sort of configuration information can go here.  Where stuff is installed, versions, etc.",
                    border: false,
                    cls: "dash-panel"
                }]
            }]
        }]
    });
});

// until I figure out what is up with Titanium.Network.createHTTPClient()
// resorting to this:
var app = {

    loadSync: function(url) {
        var client = new XMLHttpRequest();
        client.open("GET", url, false);
        client.send(null);
        return client.responseText;
    }
};

