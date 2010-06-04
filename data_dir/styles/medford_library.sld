<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:library</Name>
    <UserStyle>
      <Title>Medford, OR - Library</Title>
      <Abstract>Point style with external graphic for Medford city libraries</Abstract>
      
      <FeatureTypeStyle>
<!--140K-70K-->
        <Rule>
          <Name>Library</Name>
          <Title>Library 140K-70K</Title>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>
      
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="library.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
        
 <!--70-35K-->
        <Rule>
         <Name>Library</Name>
         <Title>Library 70K-25K</Title>
   
         <MinScaleDenominator> 35000 </MinScaleDenominator>
         <MaxScaleDenominator> 70000 </MaxScaleDenominator>

         <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                 xlink:href="library.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>13</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>          
            
<!--35K-17.5-->
        <Rule>
          <Name>Library</Name>
          <Title>Library 35K-17.5</Title>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="library.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule> 

<!--< 17.5-->
        <Rule>
          <Name>library</Name>
          <Title>library &lt; 17.5</Title>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="library.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>20</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
         
      </FeatureTypeStyle>
     
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>