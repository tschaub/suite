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
    			items: [{
                    title: "Dashboard",
                    tabTip: "OpenGeo Suite Dashboard",
                    layout: "fit",
                    items: [{html: "Dashboard Here", border: false, cls: "app-dash-panel"}]
                }, {
    				title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    layout: "fit",
    				items: [{html: "GeoServer Here", border: false, cls: "app-dash-panel"}]
    			}, {
    				title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    layout: "fit",
    				items: [{html: "GeoExplorer Here", border: false, cls: "app-dash-panel"}]
    			}, {
    				title: "Styler",
                    tabTip: "Manage Styler",
                    layout: "fit",
    				items: [{html: "Styler Here", border: false, cls: "app-dash-panel"}]
    			}]
            }, {
                items: [{
                    title: "Configuration",
                    iconCls: "x-icon-configuration",
                    tabTip: "Configuration Information",
                    html: "Config Here",
                    border: false,
                    cls: "app-dash-panel"
                }]
            }]
		}]
    });
});
