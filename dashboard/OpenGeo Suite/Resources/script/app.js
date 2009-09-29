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
                    autoLoad: "dash/main.html"
                }, {
    				title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    cls: "dash-panel",
                    autoLoad: "dash/geoserver.html"
    			}, {
    				title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    cls: "dash-panel",
                    autoLoad: "dash/geoexplorer.html"
    			}, {
    				title: "Styler",
                    tabTip: "Manage Styler",
                    cls: "dash-panel",
                    autoLoad: "dash/styler.html"
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
