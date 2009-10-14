<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:stormdrains</Name>
    <UserStyle>
      <Title>Medford, OR - StormDrains</Title>
      <Abstract></Abstract>

      <FeatureTypeStyle>
<!--280K-140K-->      
        <Rule>
          <Name>SD Pipe</Name>
          <Title>SD Pipe 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>SD Pipe</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffaf48</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Main Stems</Name>
          <Title>Main Stem 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Main Stem</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#fff048</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Tributary</Name>
          <Title>Tributary 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Tributary</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#abff48</CssParameter>
              <CssParameter name="stroke-width">.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Culvert</Name>
          <Title>Culvert 1:280K-1:140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>*Culv*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#48ffb8</CssParameter>
              <CssParameter name="stroke-width">.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        

<!--140K-70K--> 
        <Rule>
          <Name>SD Pipe</Name>
          <Title>SD Pipe 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>SD Pipe</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffaf48</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
                
        <Rule>
          <Name>Main Stems</Name>
          <Title>Main Stem 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Main Stem</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#fff048</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Tributary</Name>
          <Title>Tributary 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Tributary</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#abff48</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Culvert</Name>
          <Title>Culvert 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>*Culv*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#48ffb8</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Drains</Name>
          <Title>Drains 1:140K-1:70K</Title>
          
          <ElseFilter/>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4848</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--70K-35K--> 
        <Rule>
          <Name>SD Pipe</Name>
          <Title>SD Pipe 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>SD Pipe</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffaf48</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Main Stems</Name>
          <Title>Main Stem 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Main Stem</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#fff048</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Tributary</Name>
          <Title>Tributary 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Tributary</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#abff48</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Culvert</Name>
          <Title>Culvert 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>*Culv*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#48ffb8</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Drains</Name>
          <Title>Drains 1:70K-1:35K</Title>
  
          <ElseFilter/>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4848</CssParameter>
              <CssParameter name="stroke-width">.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--35K-17.5K--> 
        <Rule>
          <Name>SD Pipe</Name>
          <Title>SD Pipe 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>SD Pipe</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffaf48</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Main Stems</Name>
          <Title>Main Stem 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Main Stem</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#fff048</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Tributary</Name>
          <Title>Tributary 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Tributary</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#abff48</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Culvert</Name>
          <Title>Culvert 1:35K-1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>*Culv*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#48ffb8</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Drains</Name>
          <Title>Drains 1:35K-1:17.5K</Title>

          <ElseFilter/>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4848</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--< 17.5K--> 
        <Rule>
          <Name>SD Pipe</Name>
          <Title>SD Pipe &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>SD Pipe</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ffaf48</CssParameter>
              <CssParameter name="stroke-width">1.75</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Main Stems</Name>
          <Title>Main Stem &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Main Stem</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#fff048</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

        <Rule>
          <Name>Tributary</Name>
          <Title>Tributary &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>Tributary</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#abff48</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>Culvert</Name>
          <Title>Culvert &lt; 1:17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>descrip</ogc:PropertyName>
              <ogc:Literal>*Culv*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#48ffb8</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
          
        <Rule>
          <Name>Drains</Name>
          <Title>Drains &lt; 1:17.5K</Title>

          <ElseFilter/>

          <MaxScaleDenominator> 17500 </MaxScaleDenominator>   

          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#ff4848</CssParameter>
              <CssParameter name="stroke-width">1.25</CssParameter>
              <CssParameter name="stroke-opacity">.5</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>