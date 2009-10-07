<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:citylimits</Name>
    <UserStyle>
      <Title>City Limits Style</Title>
      <Abstract>Basic polygon fill in gray with opacity.  Border increases with zoom level.</Abstract>
    
      <FeatureTypeStyle>

<!--280K-140K--> 
          <Rule>
            <Name>citylimits</Name>
            <Title>City Limits 280K-140K</Title>
            
            <MinScaleDenominator> 140000 </MinScaleDenominator>
            <MaxScaleDenominator> 280000 </MaxScaleDenominator>
            <PolygonSymbolizer>
              <Fill>
               <CssParameter name="fill">#b3b3b3</CssParameter>
               <CssParameter name="fill-opacity">.45</CssParameter>                 
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#868686</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
          </Rule>

<!--< 140-->           
          <Rule>
            <Name>citylimits</Name>
            <Title>City Limits &lt; 140K </Title>
            
            <MaxScaleDenominator> 140000 </MaxScaleDenominator>
            <PolygonSymbolizer>
              <Fill>
               <CssParameter name="fill">#b3b3b3</CssParameter>
               <CssParameter name="fill-opacity">.45</CssParameter>                 
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#868686</CssParameter>
                <CssParameter name="stroke-width">.75</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
          </Rule>          
        
        </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>