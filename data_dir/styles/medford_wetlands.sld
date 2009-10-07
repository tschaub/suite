<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:wetlands</Name>
    <UserStyle>
      <Title>Medford, OR - Wetlands</Title>
      <Abstract></Abstract>

      <FeatureTypeStyle>

<!--140K-70K--> 
        <Rule>
          <Name>Large 140K-70K</Name>
          <Title>Large Wetlands 140K-70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyName>acres</ogc:PropertyName>
              <ogc:Literal>14</ogc:Literal>          
            </ogc:PropertyIsGreaterThanOrEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator> 
          
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#9d9dff</CssParameter>
              <CssParameter name="fill-opacity">.75</CssParameter>   
            </Fill>
          </PolygonSymbolizer>  
        </Rule>

<!--< 70K--> 
        <Rule>
          <Name>Smaller Wetlands &lt; 70K </Name>
          <Title>Smaller Wetlands &lt; 70K</Title>
  
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
        
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#cfcfff</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
          </PolygonSymbolizer>
        
        </Rule>

        <Rule>
          <Name>Large Wetlands &lt; 70K </Name>
          <Title>Large Wetlands &lt; 70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsGreaterThanOrEqualTo>
              <ogc:PropertyName>acres</ogc:PropertyName>
              <ogc:Literal>14</ogc:Literal>          
            </ogc:PropertyIsGreaterThanOrEqualTo>
          </ogc:Filter>
          
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#9d9dff</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
          </PolygonSymbolizer>
        </Rule>
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>