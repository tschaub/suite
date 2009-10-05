<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:schools</Name>
    <UserStyle>
      <Title>Medford, OR - Schools</Title>
      <Abstract>Point style for Medford city schools</Abstract>

<!--OUTLINE-->
      <FeatureTypeStyle>
<!--140K-70K-->
        <Rule>
          <Name>Schools</Name>
          <Title>Schools 140K-70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>city</ogc:PropertyName>
              <ogc:Literal>medford</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#662222</CssParameter>
                  <CssParameter name="fill-opacity">.5</CssParameter>                 
                </Fill>
              </Mark>
              <Size>3</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
        
<!--70K-35K-->
        <Rule>
          <Name>Schools</Name>
          <Title>Schools 70K-35K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>city</ogc:PropertyName>
              <ogc:Literal>medford</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#662222</CssParameter>
                  <CssParameter name="fill-opacity">.5</CssParameter>                 
                </Fill>
              </Mark>
              <Size>4.5</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        
<!--35K-17.5K-->
        <Rule>
          <Name>Schools</Name>
          <Title>Schools 35K-17.5K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>city</ogc:PropertyName>
              <ogc:Literal>medford</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#662222</CssParameter>
                  <CssParameter name="fill-opacity">.5</CssParameter>                 
                </Fill>
              </Mark>
              <Size>5.5</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
        
<!--17.5K-1K-->
        <Rule>
          <Name>Schools</Name>
          <Title>Schools 17.5K-1K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>city</ogc:PropertyName>
              <ogc:Literal>medford</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>

          <MinScaleDenominator> 1000 </MinScaleDenominator>
          <MaxScaleDenominator> 17500 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#662222</CssParameter>
                  <CssParameter name="fill-opacity">.5</CssParameter>                 
                </Fill>
              </Mark>
              <Size>6.5</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>
                   
      </FeatureTypeStyle>
      
      <FeatureTypeStyle>
<!--140K-70K-->
        <Rule>
          <Name>Schools</Name>
          <Title>Schools 140K-70K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
              <ogc:PropertyName>city</ogc:PropertyName>
              <ogc:Literal>medford</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>
      
          <PointSymbolizer>
            <Graphic>
              <Mark>
                <WellKnownName>circle</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#6666ff</CssParameter>
                  <CssParameter name="fill-opacity">.5</CssParameter>                 
                </Fill>
              </Mark>
              <Size>3</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
        
 <!--70-35K-->
        <Rule>
         <Name>Schools</Name>
         <Title>Schools 70K-25K</Title>
         <ogc:Filter>
           <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
             <ogc:PropertyName>city</ogc:PropertyName>
             <ogc:Literal>medford</ogc:Literal>
           </ogc:PropertyIsLike>
         </ogc:Filter>
   
         <MinScaleDenominator> 35000 </MinScaleDenominator>
         <MaxScaleDenominator> 70000 </MaxScaleDenominator>

         <PointSymbolizer>
           <Graphic>
             <Mark>
               <WellKnownName>circle</WellKnownName>
               <Fill>
                 <CssParameter name="fill">#6666ff</CssParameter>
                 <CssParameter name="fill-opacity">.5</CssParameter>                 
               </Fill>
             </Mark>
             <Size>6</Size>
           </Graphic>
         </PointSymbolizer>
       </Rule>          
            
<!--35K-17.5-->
        <Rule>
        <Name>Schools</Name>
        <Title>Schools 35K-17.5</Title>
        <ogc:Filter>
          <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
            <ogc:PropertyName>city</ogc:PropertyName>
            <ogc:Literal>medford</ogc:Literal>
          </ogc:PropertyIsLike>
        </ogc:Filter>

        <MinScaleDenominator> 17500 </MinScaleDenominator>
        <MaxScaleDenominator> 35000 </MaxScaleDenominator>

        <PointSymbolizer>
          <Graphic>
            <Mark>
              <WellKnownName>circle</WellKnownName>
              <Fill>
                <CssParameter name="fill">#6666ff</CssParameter>
                <CssParameter name="fill-opacity">.5</CssParameter>                 
              </Fill>
            </Mark>
            <Size>8</Size>
          </Graphic>
        </PointSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>name</ogc:PropertyName> School
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
                <DisplacementY>5</DisplacementY>
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

        </TextSymbolizer>
      </Rule> 

<!--17.5-1K-->
        <Rule>
        <Name>Schools</Name>
        <Title>Schools 17.5-1K</Title>
        <ogc:Filter>
          <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
            <ogc:PropertyName>city</ogc:PropertyName>
            <ogc:Literal>Medford</ogc:Literal>
          </ogc:PropertyIsLike>
        </ogc:Filter>

        <MinScaleDenominator> 1000 </MinScaleDenominator>
        <MaxScaleDenominator> 17500 </MaxScaleDenominator>

        <PointSymbolizer>
          <Graphic>
            <Mark>
              <WellKnownName>circle</WellKnownName>
              <Fill>
                <CssParameter name="fill">#6666ff</CssParameter>
                <CssParameter name="fill-opacity">.5</CssParameter>                 
              </Fill>
            </Mark>
            <Size>10</Size>
          </Graphic>
        </PointSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>name</ogc:PropertyName> School
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
                <DisplacementY>5</DisplacementY>
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

        </TextSymbolizer>
      </Rule>
         
      </FeatureTypeStyle>
      

      
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>