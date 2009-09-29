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
                    html: main_content
                }, {
    				title: "GeoServer",
                    tabTip: "Manage GeoServer",
                    cls: "dash-panel",
                    html: geoserver_content
    			}, {
    				title: "GeoExplorer",
                    tabTip: "Manage GeoExplorer",
                    cls: "dash-panel",
                    html: geoexplorer_content
    			}, {
    				title: "Styler",
                    tabTip: "Manage Styler",
                    cls: "dash-panel",
                    html: styler_content
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
// resorting to this ugliness:
var main_content = 
'<div class="dash-panel-body"><div class="dash-panel-content"><div class="dash-panel-content-item"><h1>GeoServer</h1><ul class="quick-links"><li>Admin</li><li>Docs</li><li>More...</li><ul></div><div class="dash-panel-content-item"><h1>GeoExplorer</h1><ul class="quick-links"><li>Docs</li><li>More...</li><ul></div></div><div class="dash-panel-tasks"><h2>Common Tasks</h2><ul><li>Import Layers</li><li>Style Layers</li></ul><h3>Documentation</h3><ul><li>GeoServer</li><li>GeoExplorer</li><li>Styler</li></ul></div></div>';

var geoserver_content = 
'<div class="dash-panel-body"><h1>GeoServer</h1><p>Describe GeoServer here.</p></div>';

var geoexplorer_content =
'<div class="dash-panel-body"><h1>GeoExplorer</h1><p>Describe GeoExplorer here.</p></div>';

var styler_content =
'<div class="dash-panel-body"><h1>Styler</h1><p>Describe Styler here.</p></div>';
