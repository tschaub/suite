<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:hospitals</Name>
    <UserStyle>
      <Title>Medford, OR - Hospitals</Title>
      <Abstract>External graphic for Jackson County, OR Hospitals</Abstract>

      <FeatureTypeStyle>
<!--140K-70K-->
        <Rule>
          <Name>Hospitals</Name>
          <Title>Hospitals 1:140K-1:70K</Title>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>
      
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="hospital10.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
        

 <!--70-35K-->
        <Rule>
          <Name>Hospitals</Name>
          <Title>Hospitals 1:70K-1:35K</Title>
   
          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>

          <PointSymbolizer>
           <Graphic>
             <ExternalGraphic>
               <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                 xlink:href="hospital13.png"/>
               <Format>image/png</Format>
             </ExternalGraphic>
             <Mark/>
             <Size>13</Size>
           </Graphic>
         </PointSymbolizer>
        </Rule>          

<!--35K-17.5-->

        <Rule>
          <Name>Hospitals</Name>
          <Title>Hospitals 1:35K-1:17.5</Title>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="hospital16.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">11</CssParameter>
              <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.0</AnchorPointY>
                </AnchorPoint>
                <Displacement>
                  <DisplacementX>0</DisplacementX>
                  <DisplacementY>9</DisplacementY>
                </Displacement>
              </PointPlacement>          
            </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>2</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.65</CssParameter>        
              </Fill>
            </Halo>
            <Fill>
              <CssParameter name="fill">#ff0000</CssParameter>
            </Fill>

          </TextSymbolizer>
        </Rule> 

<!--17.5-1K-->
        <Rule>
          <Name>Hospitals</Name>
          <Title>Hospitals &lt; 1:17.5</Title>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="hospital20.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>20</Size>
            </Graphic>
          </PointSymbolizer>
        
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">11</CssParameter>
              <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.0</AnchorPointY>
                </AnchorPoint>
                <Displacement>
                  <DisplacementX>0</DisplacementX>
                  <DisplacementY>12</DisplacementY>
                </Displacement>
              </PointPlacement>          
            </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>2</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.65</CssParameter>        
              </Fill>
            </Halo>
            <Fill>
              <CssParameter name="fill">#ff0000</CssParameter>
            </Fill>

          </TextSymbolizer>
        </Rule>

      </FeatureTypeStyle>
      
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>