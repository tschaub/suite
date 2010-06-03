<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:taxlots</Name>
    <UserStyle>
      <Title>Medford, OR - Taxlots</Title>
      <Abstract></Abstract>

      <FeatureTypeStyle>

<!--70K-35K--> 
        <Rule>
          <Name>Taxlots 140K-70K</Name>
          <Title>Taxlots 140K-70K-35K</Title>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator> 

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#000133</CssParameter>
              <CssParameter name="fill-opacity">.25</CssParameter>
            </Fill>
          </PolygonSymbolizer>  
        </Rule>

<!--70K-35K--> 
        <Rule>
          <Name>Taxlots 70K-35K</Name>
          <Title>Taxlots 70K-35K</Title>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator> 
          
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#000133</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#000133</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>  
        </Rule>

<!--< 35K--> 
        <Rule>
          <Name>Taxlots &lt; 35K </Name>
          <Title>Taxlots &lt; 35K</Title>
          
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#000133</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#000133</CssParameter>
              <CssParameter name="stroke-width">.6</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>