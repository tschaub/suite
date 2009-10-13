<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:streets</Name>
    <UserStyle>
      <Title>Medford, OR - Streets</Title>
      <Abstract>Attribute zoom, label and larger, darker lines for more more developed street types</Abstract>

      <FeatureTypeStyle>

<!--212K-53K-->      
        <Rule>
          <Name>RailRoad Border</Name>
          <Title>RailRoad Border</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 53000 </MinScaleDenominator>
          <MaxScaleDenominator> 212000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#000000</CssParameter>
              <CssParameter name="stroke-width">4</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
       
        <Rule>
          <Name>RR-zoom1</Name>
          <Title>RailRoad Inner Line</Title>    
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
        
          <MinScaleDenominator> 53000 </MinScaleDenominator>
          <MaxScaleDenominator> 212000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffffff</CssParameter>
              <CssParameter name="stroke-width">3</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>RR-zoom1</Name>
          <Title>RailRoad Hatch Line</Title>    
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 53000 </MinScaleDenominator>
          <MaxScaleDenominator> 212000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <GraphicStroke>
                <Graphic>
                  <Mark>
                    <WellKnownName>shape://vertline</WellKnownName>
                    <Stroke>
                      <CssParameter name="stroke">#000000</CssParameter>
                      <CssParameter name="stroke-width">2</CssParameter>
                      <CssParameter name="stroke-opacity">.45</CssParameter>
                    </Stroke>
                  </Mark>
                  <Size>5</Size>
                </Graphic>
              </GraphicStroke>
            </Stroke>
          </LineSymbolizer> 
        </Rule>     

<!--ZOOM2-->
        <Rule>
          <Name>RR-zoom2</Name>
          <Title>RailRoad Border</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 13000 </MinScaleDenominator>
          <MaxScaleDenominator> 53000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#000000</CssParameter>
              <CssParameter name="stroke-width">5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule> 

        <Rule>
          <Name>RR-zoom2</Name>
          <Title>RailRoad Inner Line</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 13000 </MinScaleDenominator>
          <MaxScaleDenominator> 53000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffffff</CssParameter>
              <CssParameter name="stroke-width">4</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>RR-zoom2</Name>
          <Title>RailRoad Hatch Line</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 13000 </MinScaleDenominator>
          <MaxScaleDenominator> 53000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <GraphicStroke>
                <Graphic>
                  <Mark>
                    <WellKnownName>shape://vertline</WellKnownName>
                    <Stroke>
                      <CssParameter name="stroke">#000000</CssParameter>
                      <CssParameter name="stroke-width">2</CssParameter>
                      <CssParameter name="stroke-opacity">.45</CssParameter>
                    </Stroke>
                  </Mark>
                  <Size>6</Size>
                </Graphic>
              </GraphicStroke>
            </Stroke>
          </LineSymbolizer> 
        </Rule>     

<!--ZOOM3-->
        <Rule>
          <Name>RR-zoom3</Name>
          <Title>RailRoad Border</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 13000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#000000</CssParameter>
              <CssParameter name="stroke-width">6</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule> 

        <Rule>
          <Name>RR-zoom3</Name>
          <Title>RailRoad Inner Line</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 13000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffffff</CssParameter>
              <CssParameter name="stroke-width">5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
  
        <Rule>
          <Name>RR-zoom3</Name>
          <Title>RailRoad Hatch Line</Title>      
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 13000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <GraphicStroke>
                <Graphic>
                  <Mark>
                    <WellKnownName>shape://vertline</WellKnownName>
                    <Stroke>
                      <CssParameter name="stroke">#000000</CssParameter>
                      <CssParameter name="stroke-width">3</CssParameter>
                      <CssParameter name="stroke-opacity">.45</CssParameter>
                    </Stroke>
                  </Mark>
                  <Size>7</Size>
                </Graphic>
              </GraphicStroke>
            </Stroke>
          </LineSymbolizer> 
        </Rule> 
        
<!--STREETS-->        
<!--220K-110K-->
      <Rule>
        <Name>Streets</Name>
        <Title>Streets 1:110K-1:18K</Title>
  
        <ElseFilter/>

        <MinScaleDenominator> 110000 </MinScaleDenominator>
        <MaxScaleDenominator> 220000 </MaxScaleDenominator>
        <LineSymbolizer>
          <Stroke>
            <CssParameter name="stroke">#8c8c8c</CssParameter> 
            <CssParameter name="width">.5</CssParameter>
          </Stroke>
        </LineSymbolizer>
      </Rule>
<!--110K-18K-->
        <Rule>
          <Name>Streets</Name>
          <Title>Streets 1:110K-1:18K</Title>
          
          <ElseFilter/>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#8c8c8c</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
<!--< 18K-->
        <Rule>
          <Name>Streets</Name>
          <Title>Streets &lt; 18K</Title>
          <ElseFilter/>
          
          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#8c8c8c</CssParameter> 
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>            
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">Normal</CssParameter>
              <CssParameter name="font-size">10</CssParameter>
              <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
              <LinePlacement>
                <PerpendicularOffset>1</PerpendicularOffset>
              </LinePlacement>
            </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>2</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.75</CssParameter>        
              </Fill>
            </Halo>
                      
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption> 
          </TextSymbolizer>
        </Rule>
 
<!--MAJOR ROADS-->
<!--280K-220K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads 1:280K-1:220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter><!--pure red-->
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
<!-- 220K-110K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads 1:220K-1:110L</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> <!--GRAY (5)-->
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">10</CssParameter>
              <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
              <LinePlacement>
                <PerpendicularOffset>1</PerpendicularOffset>
              </LinePlacement>
            </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>3</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.75</CssParameter>        
              </Fill>
            </Halo>
            
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption> 
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads &lt; 1:18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">11</CssParameter>
              <CssParameter name="font-weight">normal</CssParameter>
            </Font>
            <LabelPlacement>
              <LinePlacement>
                <PerpendicularOffset>1</PerpendicularOffset>
              </LinePlacement>
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
            
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption> 
          </TextSymbolizer>
        </Rule>
        
<!--HIGHWAY 62-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 1:280K-220K</Title>
          <ogc:Filter>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
                <ogc:PropertyName>streetname</ogc:PropertyName>
                <ogc:Literal>*HIGHWAY 62*</ogc:Literal>          
              </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_62.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        
<!-- 220K-110K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 1:220K-1:110K</Title>
          <ogc:Filter>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
                <ogc:PropertyName>streetname</ogc:PropertyName>
                <ogc:Literal>*HIGHWAY 62*</ogc:Literal>          
              </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_62.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 1:110K-56K</Title>
          <ogc:Filter>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
                <ogc:PropertyName>streetname</ogc:PropertyName>
                <ogc:Literal>*HIGHWAY 62*</ogc:Literal>          
              </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_62.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 1:56K-18K</Title>
          <ogc:Filter>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
                <ogc:PropertyName>streetname</ogc:PropertyName>
                <ogc:Literal>*HIGHWAY 62*</ogc:Literal>          
              </ogc:PropertyIsLike>
          </ogc:Filter>
          
          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_62.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 &lt; 18K</Title>
          <ogc:Filter>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
                <ogc:PropertyName>streetname</ogc:PropertyName>
                <ogc:Literal>*HIGHWAY 62*</ogc:Literal>          
              </ogc:PropertyIsLike>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_62.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>
          
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 62-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-66</Name>
          <Title>Highway-66 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 66</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_66.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-66</Name>
          <Title>Highway-66 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 66</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_66.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-66</Name>
          <Title>Highway-66 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 66</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_66.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-66</Name>
          <Title>Highway-66 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 66</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_66.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-66</Name>
          <Title>Highway-66 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 66</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_66.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 99-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-99</Name>
          <Title>Highway-99 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 99*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_99.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-99</Name>
          <Title>Highway-99 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 99*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_99.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-99</Name>
          <Title>Highway-99 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 99*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_99.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-99</Name>
          <Title>Highway-99 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 99*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_99.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-99</Name>
          <Title>Highway-99 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 99*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_99.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>


<!--HIGHWAY 140-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-140</Name>
          <Title>Highway-140 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 140</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_140.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-140</Name>
          <Title>Highway-140 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 140</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_140.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-140</Name>
          <Title>Highway-140 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 140</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_140.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-140</Name>
          <Title>Highway-140 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 140</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_140.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-140</Name>
          <Title>Highway-140 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 140</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_140.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 227-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-227</Name>
          <Title>Highway-227 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 227</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_227.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-227</Name>
          <Title>Highway-227 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 227</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_227.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-227</Name>
          <Title>Highway-227 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 227</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_227.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-227</Name>
          <Title>Highway-227 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 227</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_227.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-227</Name>
          <Title>Highway-227 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 227</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_227.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 230-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-230</Name>
          <Title>Highway-230 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 230</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_230.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-230</Name>
          <Title>Highway-230 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 230</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_230.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-230</Name>
          <Title>Highway-230 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 230</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_230.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-230</Name>
          <Title>Highway-230 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 230</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_230.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-230</Name>
          <Title>Highway-230 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 230</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_230.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 234-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-234</Name>
          <Title>Highway-234 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 234*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_234.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-234</Name>
          <Title>Highway-234 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 234*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_234.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-234</Name>
          <Title>Highway-234 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 234*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_234.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-234</Name>
          <Title>Highway-234 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 234*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_234.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-234</Name>
          <Title>Highway-234 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 234*</ogc:Literal>          
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_234.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--HIGHWAY 238-->
<!--280K-220K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_238.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>10</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!-- 220K-110K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 1:220K-1:110K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 110000 </MinScaleDenominator>         
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_238.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--110K-56K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 1:110K-56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">2</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_238.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>14</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_238.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 &lt; 18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#737373</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <LabelPlacement>
              <PointPlacement>
                <AnchorPoint>
                  <AnchorPointX>0.5</AnchorPointX>
                  <AnchorPointY>0.5</AnchorPointY>
                </AnchorPoint>
              </PointPlacement>
            </LabelPlacement>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/OR_238.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>

            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--INTERSTATE OUTER-->
<!--280K-220K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:280K-1:220</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--220K-110K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:280K-1:220</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
    
          <MinScaleDenominator> 110000 </MinScaleDenominator>
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
<!--110K-56K-->
        <Rule>
          <Name>Intersate</Name>
          <Title>Interstate 1:110K-1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
    
          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>  
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter> 
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>    
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">6</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate &lt; 1:18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>      
          <LineSymbolizer>
          <Stroke>
            <CssParameter name="stroke">#404040</CssParameter>
            <CssParameter name="width">8</CssParameter>
          </Stroke>
        </LineSymbolizer>
        </Rule>

<!--INTERSTATE INNER-->
<!--280K-220K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:280K-1:220</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">.25</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/interstate_5.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>12</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--220K-110K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:280K-1:220</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
    
          <MinScaleDenominator> 110000 </MinScaleDenominator>
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">1.5</CssParameter>
            </Stroke>
          </LineSymbolizer>
     
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/interstate_5.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        
<!--110K-56K-->
        <Rule>
          <Name>Intersate</Name>
          <Title>Interstate 1:110K-1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
    
          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>  
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter> 
              <CssParameter name="width">2.5</CssParameter>
            </Stroke>
          </LineSymbolizer>
            
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/interstate_5.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>
            
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--56K-18K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:56K-18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>    
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>
      
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
            </Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter> 
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="graphics/interstate_5.svg"/>
                <Format>image/svg</Format>
              </ExternalGraphic>
              <Size>21</Size>
            </Graphic>
            <Priority>30000</Priority>
    
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>

<!--< 18K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate &lt; 1:18K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 18000 </MaxScaleDenominator>      
          <LineSymbolizer>
          <Stroke>
            <CssParameter name="stroke">#404040</CssParameter>
            <CssParameter name="width">6</CssParameter>
          </Stroke>
        </LineSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>namelow</ogc:PropertyName>
          </Label>
          <Font>
          </Font>
          <Fill>
            <CssParameter name="fill-opacity">0</CssParameter> 
          </Fill>
          <Graphic>
            <ExternalGraphic>
              <OnlineResource xlink:href="graphics/interstate_5.svg"/>
              <Format>image/svg</Format>
            </ExternalGraphic>
            <Size>24</Size>
          </Graphic>
          <Priority>30000</Priority>
          
          <VendorOption name="spaceAround">150</VendorOption>
          <VendorOption name="group">no</VendorOption>
        </TextSymbolizer>
        </Rule>
      </FeatureTypeStyle>
      
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>