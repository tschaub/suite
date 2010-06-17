<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:hydro</Name>
    <UserStyle>
      <Title>Medford, OR - Hydro</Title>
      <Abstract></Abstract>

      <FeatureTypeStyle>
<!--280K-140K-->      
        <Rule>
          <Name>large-streams-zoom1</Name>
          <Title>Large Streams 280K-140K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>STREAM</ogc:PropertyName>
              <ogc:Literal>Bear</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 140000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0000E2</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--140K-70K--> 
        <Rule>
          <Name>large-streams-zoom2</Name>
          <Title>Large Streams 140K-70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>STREAM</ogc:PropertyName>
              <ogc:Literal>Bear</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0000E2</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>

<!--70K-35K--> 
        <Rule>
          <Name>large-streams-zoom2</Name>
          <Title>Large Streams 70K-35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>STREAM</ogc:PropertyName>
              <ogc:Literal>Bear</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0000E2</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
        <Rule>
          <Name>small-streams-zoom2</Name>
          <Title>Small Streams 70K-35K</Title>
          <ogc:Filter>
            <ogc:Not>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>STREAM</ogc:PropertyName>
                <ogc:Literal>Bear</ogc:Literal>
              </ogc:PropertyIsLike>
            </ogc:Not>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0085e2</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
        
<!--35K-17.5K--> 
        <Rule>
          <Name>large-streams-zoom3</Name>
          <Title>Large Streams 35K-17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>STREAM</ogc:PropertyName>
              <ogc:Literal>Bear</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          
          <MinScaleDenominator>17500</MinScaleDenominator>   
          <MaxScaleDenominator>35000</MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0000E2</CssParameter>
              <CssParameter name="stroke-width">2</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>STREAM_NAM</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Sans-Serif</CssParameter>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">italic</CssParameter>
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
                <CssParameter name="fill-opacity">.65</CssParameter>        
              </Fill>
            </Halo>
            
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption> 
          </TextSymbolizer>
        </Rule>        
       
        <Rule>
          <Name>small-streams-zoom2</Name>
          <Title>Small Streams 35K-17.5K</Title>
          <ogc:Filter>
            <ogc:Not>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>STREAM</ogc:PropertyName>
                <ogc:Literal>Bear</ogc:Literal>
              </ogc:PropertyIsLike>
            </ogc:Not>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0085e2</CssParameter>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 
        </Rule>
<!--17.5K-1K--> 
        <Rule>
          <Name>large-streams-zoom3</Name>
          <Title>Large Streams 17.5K-1K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>STREAM</ogc:PropertyName>
              <ogc:Literal>Bear</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MaxScaleDenominator>35000</MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0000E2</CssParameter>
              <CssParameter name="stroke-width">2.5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer> 

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>STREAM_NAM</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Sans-Serif</CssParameter>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">italic</CssParameter>
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
      
        <Rule>
          <Name>small-streams-zoom2</Name>
          <Title>Small Streams 17.5K-1K</Title>
          <ogc:Filter>
            <ogc:Not>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>STREAM</ogc:PropertyName>
                <ogc:Literal>Bear</ogc:Literal>
              </ogc:PropertyIsLike>
            </ogc:Not>
          </ogc:Filter>

          <MaxScaleDenominator> 35000 </MaxScaleDenominator>   
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#0085e2</CssParameter>
              <CssParameter name="stroke-width">1.5</CssParameter>
              <CssParameter name="stroke-opacity">.45</CssParameter>
            </Stroke>
          </LineSymbolizer>
          
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>STREAM_NAM</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Sans-Serif</CssParameter>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-style">italic</CssParameter>
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
                <CssParameter name="fill-opacity">.65</CssParameter>        
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