<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:medford_streets</Name>
    <UserStyle>
      <Title>Medford, OR - Streets</Title>
      <Abstract>Attribute zoom, label and larger, darker lines for more more developed street types</Abstract>

      <FeatureTypeStyle>
<!--RAILROAD-->
<!--ZOOM1-->      
        <Rule>
          <Name>RR-zoom1</Name>
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

<!--ZOOM1-->

        <Rule>
          <Name>streets-zoom1</Name>
          <Title>Streets</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>streets</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 18000 </MinScaleDenominator>
          <MaxScaleDenominator> 110000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#8c8c8c</CssParameter> 
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        
<!--ZOOM2-->
        <Rule>
          <Name>streets-zoom1</Name>
          <Title>Streets</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>streets</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
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
<!--ZOOM0-->
        <Rule>
          <Name>interstate-zoom0</Name>
          <Title>Interstate</Title>
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
        
<!-- ZOOM1-->
        <Rule>
          <Name>major roads-zoom1</Name>
          <Title>Major Roads</Title>
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

<!--ZOOM2-->
        <Rule>
          <Name>major roads-zoom2</Name>
          <Title>Major Roads</Title>
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

<!--ZOOM3-->
        <Rule>
          <Name>major roads-zoom3</Name>
          <Title>Major Roads</Title>
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

<!--ZOOM4-->
        <Rule>
          <Name>major roads-zoom4</Name>
          <Title>Major Roads</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>major_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 50 </MinScaleDenominator>
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
      
<!--INTERSTATE-->
<!--ZOOM0-->
        <Rule>
          <Name>interstate-zoom0</Name>
          <Title>Interstate</Title>
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
              <CssParameter name="stroke">#404040</CssParameter><!--pure red-->
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>

<!--ZOOM1-->
        <Rule>
          <Name>interstate-zoom1</Name>
          <Title>Interstate</Title>
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
              <CssParameter name="stroke">#404040</CssParameter><!--pure red-->
              <CssParameter name="width">3</CssParameter>
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
               <CssParameter name="font-weight">bold</CssParameter>
             </Font>
             <LabelPlacement>
               <LinePlacement>
                 <PerpendicularOffset>2</PerpendicularOffset>
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
             
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="spaceAround">175</VendorOption>
          </TextSymbolizer>
        </Rule>
        
<!--ZOOM2-->
        <Rule>
          <Name>interstate-zoom2</Name>
          <Title>Interstate</Title>
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
            
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">11</CssParameter>
              <CssParameter name="font-weight">bold</CssParameter>
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

<!--ZOOM3-->
        <Rule>
          <Name>interstate-zoom3</Name>
          <Title>Interstate</Title>
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
      
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">normal</CssParameter>
              <CssParameter name="font-size">12</CssParameter>
              <CssParameter name="font-weight">bold</CssParameter>
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

<!--ZOOM4-->
        <Rule>
          <Name>interstate-zoom4</Name>
          <Title>Interstate</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>interstate</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 50 </MinScaleDenominator>
          <MaxScaleDenominator> 18000 </MaxScaleDenominator>      
          <LineSymbolizer>
          <Stroke>
            <CssParameter name="stroke">#404040</CssParameter>
            <CssParameter name="width">8</CssParameter>
          </Stroke>
        </LineSymbolizer>
        
          <TextSymbolizer>
          <Label>
            <ogc:PropertyName>namelow</ogc:PropertyName>
          </Label>
          <Font>
            <CssParameter name="font-family">Arial</CssParameter>
            <CssParameter name="font-style">Normal</CssParameter>
            <CssParameter name="font-size">14</CssParameter>
            <CssParameter name="font-weight">bold</CssParameter>
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
      </FeatureTypeStyle>
      
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>