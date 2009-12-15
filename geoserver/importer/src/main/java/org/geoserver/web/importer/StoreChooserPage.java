/* Copyright (c) 2001 - 2007 TOPP - www.openplans.org. All rights reserved.
 * This code is licensed under the GPL 2.0 license, available at the root
 * application directory.
 */
package org.geoserver.web.importer;

import java.util.Arrays;

import org.apache.wicket.AttributeModifier;
import org.apache.wicket.Component;
import org.apache.wicket.PageParameters;
import org.apache.wicket.ResourceReference;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.image.Image;
import org.apache.wicket.markup.html.link.BookmarkablePageLink;
import org.apache.wicket.markup.html.list.ListItem;
import org.apache.wicket.markup.html.list.ListView;
import org.apache.wicket.model.IModel;
import org.geoserver.web.GeoServerApplication;
import org.geoserver.web.GeoServerBasePage;
import org.geoserver.web.wicket.ParamResourceModel;

public class StoreChooserPage extends GeoServerBasePage {

    public StoreChooserPage(PageParameters params) {
        if("TRUE".equalsIgnoreCase((String) params.getString("afterCleanup")))
            info(new ParamResourceModel("rollbackSuccessful", this).getString());
        
        ListView storeLinks = new ListView("stores", Arrays.asList(Store.values())) {
            
            @Override
            protected void populateItem(ListItem item) {
                Store store = (Store) item.getModelObject();
                BookmarkablePageLink link = new BookmarkablePageLink("storeLink", store.getDestinationPage());
                link.add(new Label("storeName", store.getStoreName(StoreChooserPage.this)));
                item.add(link);
                item.add(new Label("storeDescription", store.getStoreDescription(StoreChooserPage.this)));
                Image icon = new Image("storeIcon", store.getStoreIcon());
                icon.add(new AttributeModifier("alt", store.getStoreDescription(StoreChooserPage.this)));
                item.add(icon);
            }
        };
        add(storeLinks);
    }
    
    enum Store {
        directory(new ResourceReference(GeoServerApplication.class, "img/icons/silk/folder.png"), DirectoryPage.class), 
        postgis(new ResourceReference(GeoServerApplication.class, "img/icons/geosilk/database_vector.png"), DirectoryPage.class);
        
        ResourceReference icon;
        Class destinationPage;
        
        Store(ResourceReference icon, Class destinationPage) {
            this.icon = icon;
            this.destinationPage = destinationPage;
        }
        
        IModel getStoreName(Component component) {
            return new ParamResourceModel(this.name() + "_name", component);
        }
        
        IModel getStoreDescription(Component component) {
            return new ParamResourceModel(this.name() + "_description", component);
        }
        
        ResourceReference getStoreIcon() {
            return icon;
        }
        
        Class getDestinationPage() {
            return destinationPage;
        }
    }
}
