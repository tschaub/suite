<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
  xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>medford:buildings</Name>
    <UserStyle>
      <Title>Medford, OR - Buildings</Title>
      <Abstract></Abstract>
      <FeatureTypeStyle>
        <Rule>
        <Name>buildings</Name>
        <Title>Buildings</Title>
       
        <PolygonSymbolizer>
          <Fill>
            <CssParameter name="fill">#333333</CssParameter>
            <CssParameter name="fill-opacity">.5</CssParameter>   
          </Fill>
          <Stroke>
            <CssParameter name="stroke">#333333</CssParameter>
            <CssParameter name="stroke-width">.6</CssParameter>
          </Stroke>
        </PolygonSymbolizer>
      </Rule>
       
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>