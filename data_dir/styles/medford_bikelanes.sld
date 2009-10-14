<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerlane_typetor.xsd">
  <NamedLayer>
    <Name>medford:bikelanes</Name>
    <UserStyle>
      <Title>Medford, OR - Bike Lanes</Title>
      <Abstract></Abstract>

      <FeatureTypeStyle>
<!--280K-140K-->      
        <Rule>
          <Name>On-Street</Name>
          <Title>On-Street 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>On-Street</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff022c</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.6</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>&gt; 3ft Shoulders</Name>
          <Title>&gt; 3ft Shoulders 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>3 Foot Plus Shoulders</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff1a40</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        

<!--140K-70K--> 
        <Rule>
          <Name>On-Street</Name>
          <Title>On-Street 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>On-Street</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff022c</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.6</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
                
        <Rule>
          <Name>&gt; 3ft Shoulders</Name>
          <Title>&gt; 3ft Shoulders 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>3 Foot Plus Shoulders</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff1a40</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Multi Use Path</Name>
          <Title>Multi Use Path 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Multi Use Path</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff3758</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        
        <Rule>
          <Name>Bike Lanes</Name>
          <Title>Bike Lanes 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Bike Lanes</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4c6a</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Mountain Bike</Name>
          <Title>Mountain Bike 1:140K-1:70K</Title>
          
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Mountain Bike</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff6982</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--70K-35K--> 
        <Rule>
          <Name>On-Street</Name>
          <Title>On-Street 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>On-Street</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff022c</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.6</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>&gt; 3ft Shoulders</Name>
          <Title>&gt; 3ft Shoulders 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>3 Foot Plus Shoulders</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff1a40</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Multi Use Path</Name>
          <Title>Multi Use Path 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Multi Use Path</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff3758</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>


        <Rule>
          <Name>Bike Lanes</Name>
          <Title>Bike Lanes 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Bike Lanes</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4c6a</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Mountain Bike</Name>
          <Title>Mountain Bike 1:70K-1:35K</Title>
  
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Mountain Bike</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
  
          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff6982</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--35K-17.5K--> 
        <Rule>
          <Name>On-Street</Name>
          <Title>On-Street 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>On-Street</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff022c</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.6</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>&gt; 3ft Shoulders</Name>
          <Title>&gt; 3ft Shoulders 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>3 Foot Plus Shoulders</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff1a40</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Multi Use Path</Name>
          <Title>Multi Use Path 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Multi Use Path</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff3758</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Bike Lanes</Name>
          <Title>Bike Lanes 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Bike Lanes</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4c6a</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Mountain Bike</Name>
          <Title>Mountain Bike 1:35K-1:17.5K</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Mountain Bike</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff6982</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--< 17.5K--> 
        <Rule>
          <Name>On-Street</Name>
          <Title>On-Street &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>On-Street</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff022c</CssParameter>
              <CssParameter name="stroke-width">1.75</CssParameter>
              <CssParameter name="stroke-opacity">.6</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>&gt; 3ft Shoulders</Name>
          <Title>&gt; 3ft Shoulders &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>3 Foot Plus Shoulders</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff1a40</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Multi Use Path</Name>
          <Title>Multi Use Path &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Multi Use Path</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff3758</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Bike Lanes</Name>
          <Title>Bike Lanes &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Bike Lanes</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4c6a</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Mountain Bike</Name>
          <Title>Mountain Bike &lt; 1:17.5K</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>lane_type</ogc:PropertyName>
              <ogc:Literal>Mountain Bike</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff6982</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>


      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>