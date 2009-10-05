<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:parks</Name>
    <UserStyle>
      <Title>Medford, OR - Parks</Title>
      <Abstract></Abstract>
     
      <FeatureTypeStyle>

<!--Forest Parks 280K-35K-->      
        <Rule>
          <Name>Forest Parks</Name>
          <Title>Forest Parks 280K-35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>parktype</ogc:PropertyName>
              <ogc:Literal>Forest Park</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#45ac75</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
          </PolygonSymbolizer>
        </Rule>
        
<!--Parks 140K-35K-->      
        <Rule>
          <Name>Parks</Name>
          <Title>Parks 140K-35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>parktype</ogc:PropertyName>
              <ogc:Literal>Park</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#4fc486</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
          </PolygonSymbolizer>
        </Rule>

<!--Athletic and School 70K-35K-->                
        <Rule>
          <Name>Parks</Name>
          <Title>Parks 70K-25K</Title>
          <ogc:Filter>
            <ogc:Or>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>parktype</ogc:PropertyName>
                <ogc:Literal>School Field</ogc:Literal>          
              </ogc:PropertyIsEqualTo>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>parktype</ogc:PropertyName>
                <ogc:Literal>Athletic Field</ogc:Literal>          
              </ogc:PropertyIsEqualTo>
            </ogc:Or>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#5feca1</CssParameter>
              <CssParameter name="fill-opacity">.5</CssParameter>   
            </Fill>
          </PolygonSymbolizer>
        </Rule>
        
        
      </FeatureTypeStyle>


    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>