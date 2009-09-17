/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.demo;

import static org.geoserver.ows.util.ResponseUtils.*;
import static org.geoserver.web.demo.VulcanPreviewProvider.*;

import org.apache.wicket.Component;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.markup.html.panel.Fragment;
import org.apache.wicket.model.IModel;
import org.apache.wicket.model.Model;
import org.geoserver.web.GeoServerBasePage;
import org.geoserver.web.wicket.GeoServerTablePanel;
import org.geoserver.web.wicket.SimpleExternalLink;
import org.geoserver.web.wicket.GeoServerDataProvider.Property;

/**
 * Shows a paged list of the available layers and points to previews in various formats
 */
@SuppressWarnings("serial")
public class VulcanMapPreviewPage extends GeoServerBasePage {

    VulcanPreviewProvider provider = new VulcanPreviewProvider();

    GeoServerTablePanel<PreviewLayer> table;

    public VulcanMapPreviewPage() {
        // build the table
        table = new GeoServerTablePanel<PreviewLayer>("table", provider) {

            @Override
            protected Component getComponentForProperty(String id, final IModel itemModel,
                    Property<PreviewLayer> property) {
                PreviewLayer layer = (PreviewLayer) itemModel.getObject();

                if (property == TYPE) {
                    Fragment f = new Fragment(id, "iconFragment", VulcanMapPreviewPage.this);
                    f.add(new Image("layerIcon", layer.getTypeSpecificIcon()));
                    return f;
                } else if (property == NAME) {
                    return new Label(id, property.getModel(itemModel));
                } else if (property == TITLE) {
                    return new Label(id, property.getModel(itemModel));
                } else if (property == OL) {
                    final String olUrl = layer.getWmsLink() + "&format=application/openlayers";
                    return new SimpleExternalLink(id, new Model(olUrl), new Model("OpenLayers"));
                } else if (property == GE) {
                    final String kmlUrl = "../wms/kml?layers=" + layer.getName();
                    return new SimpleExternalLink(id, new Model(kmlUrl), new Model("Google Earth"));
                } else if (property == STYLER) {
                    // openlayers preview
                    final String stylerUrl = "../www/styler/index.html?layer=" + urlEncode(layer.getName());
                    return new SimpleExternalLink(id, new Model(stylerUrl), new Model("Styler"));
                }
                
                return null;
            }

        };
        table.setOutputMarkupId(true);
        add(table);
    }

}
