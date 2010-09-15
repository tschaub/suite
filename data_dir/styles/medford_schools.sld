<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:schools</Name>
    <UserStyle>
      <Title>Medford, OR - Schools</Title>
      <Abstract>External graphic for Medford Elementary, Middle, and High Schools.</Abstract>

      <FeatureTypeStyle>
<!--140K-70K-->
        <Rule>
          <Name>Elementary Schools</Name>
          <Title>Elementary Schools 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Elementary</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>
      
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="elementary_school10.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
        
        <Rule>
          <Name>Middle Schools</Name>
          <Title>Middle Schools 1:140K-1:70K</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Middle</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>
          
          <MinScaleDenominator> 70000 </MinScaleDenominator>
          <MaxScaleDenominator> 140000 </MaxScaleDenominator>
      
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                  xlink:href="middle_school10.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>10</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>   
  
        <Rule>
          <Name>High Schools</Name>
          <Title>High Schools 1:140K-1:70K</Title>
            <ogc:Filter>
              <ogc:And>
                <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                  <ogc:PropertyName>city</ogc:PropertyName>
                  <ogc:Literal>medford</ogc:Literal>
                </ogc:PropertyIsLike>
                <ogc:PropertyIsEqualTo>
                  <ogc:PropertyName>type</ogc:PropertyName>
                  <ogc:Literal>High School</ogc:Literal>          
                </ogc:PropertyIsEqualTo>              
              </ogc:And>
            </ogc:Filter>
     
            <MinScaleDenominator> 70000 </MinScaleDenominator>
            <MaxScaleDenominator> 140000 </MaxScaleDenominator>
            
            <PointSymbolizer>
             <Graphic>
               <ExternalGraphic>
                 <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                   xlink:href="high_school10.png"/>
                 <Format>image/png</Format>
               </ExternalGraphic>
               <Mark/>
               <Size>10</Size>
             </Graphic>
           </PointSymbolizer>
        </Rule>   
 
 <!--70-35K-->
        <Rule>
          <Name>Elementary Schools</Name>
          <Title>Elementary Schools 1:70K-1:35K</Title>
          <ogc:Filter>
           <ogc:And>
             <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
               <ogc:PropertyName>city</ogc:PropertyName>
               <ogc:Literal>medford</ogc:Literal>
             </ogc:PropertyIsLike>
             <ogc:PropertyIsEqualTo>
               <ogc:PropertyName>type</ogc:PropertyName>
               <ogc:Literal>Elementary</ogc:Literal>          
             </ogc:PropertyIsEqualTo>              
           </ogc:And>
         </ogc:Filter>
   
          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>

          <PointSymbolizer>
           <Graphic>
             <ExternalGraphic>
               <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                 xlink:href="elementary_school13.png"/>
               <Format>image/png</Format>
             </ExternalGraphic>
             <Mark/>
             <Size>13</Size>
           </Graphic>
         </PointSymbolizer>
        </Rule>          

        <Rule>
          <Name>Middle Schools</Name>
          <Title>Middle Schools 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Middle</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>
         
          <PointSymbolizer>
          <Graphic>
             <ExternalGraphic>
               <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="middle_school13.png"/>
                <Format>image/png</Format>
             </ExternalGraphic>
            <Mark/>
            <Size>13</Size>
          </Graphic>
        </PointSymbolizer>
        </Rule>          

        <Rule>
          <Name>High Schools</Name>
          <Title>High Schools 1:70K-1:35K</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>High School</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

          <MinScaleDenominator> 35000 </MinScaleDenominator>
          <MaxScaleDenominator> 70000 </MaxScaleDenominator>
         
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="high_schoo13l.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>13</Size>
            </Graphic>
          </PointSymbolizer>
        </Rule>          


<!--35K-17.5-->

        <Rule>
          <Name>Elementary Schools</Name>
          <Title>Elementary Schools 1:35K-1:17.5</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Elementary</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="elementary_school16.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>

          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName> School
            </Label>
            <Font>
              <CssParameter name="font-family">SansSerif</CssParameter>
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
                  <DisplacementY>10</DisplacementY>
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

        <Rule>
          <Name>Middle Schools</Name>
          <Title>Middle Schools 1:35K-1:17.5</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Middle</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="middle_school16.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>
        
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName> School
            </Label>
            <Font>
              <CssParameter name="font-family">SansSerif</CssParameter>
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
                  <DisplacementY>10</DisplacementY>
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
              <CssParameter name="fill">#26a32b</CssParameter>
            </Fill>

          </TextSymbolizer>
        </Rule> 

        <Rule>
          <Name>High Schools</Name>
          <Title>High Schools 1:35K-1:17.5</Title>
          <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>High School</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

          <MinScaleDenominator> 17500 </MinScaleDenominator>
          <MaxScaleDenominator> 35000 </MaxScaleDenominator>

          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="high_school16.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Mark/>
              <Size>16</Size>
            </Graphic>
          </PointSymbolizer>
        
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>name</ogc:PropertyName> School
            </Label>
            <Font>
              <CssParameter name="font-family">SansSerif</CssParameter>
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
                  <DisplacementY>10</DisplacementY>
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
              <CssParameter name="fill">#004d96</CssParameter>
            </Fill>

          </TextSymbolizer>
        </Rule> 


<!--17.5-1K-->
      <Rule>
        <Name>Elementary Schools</Name>
        <Title>Elementary Schools &lt; 1:17.5</Title>
        <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Elementary</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

        <MinScaleDenominator> 1000 </MinScaleDenominator>
        <MaxScaleDenominator> 17500 </MaxScaleDenominator>

        <PointSymbolizer>
          <Graphic>
            <ExternalGraphic>
              <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="elementary_school20.png"/>
              <Format>image/png</Format>
            </ExternalGraphic>
            <Mark/>
            <Size>20</Size>
          </Graphic>
        </PointSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>name</ogc:PropertyName> School
          </Label>
          <Font>
            <CssParameter name="font-family">SansSerif</CssParameter>
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
                <DisplacementY>10</DisplacementY>
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

      <Rule>
        <Name>Middle Schools</Name>
        <Title>Middle Schools &lt; 1:17.5</Title>
        <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>Middle</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

        <MinScaleDenominator> 1000 </MinScaleDenominator>
        <MaxScaleDenominator> 17500 </MaxScaleDenominator>

        <PointSymbolizer>
          <Graphic>
            <ExternalGraphic>
              <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="middle_school20.png"/>
              <Format>image/png</Format>
            </ExternalGraphic>
            <Mark/>
            <Size>20</Size>
          </Graphic>
        </PointSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>name</ogc:PropertyName> School
          </Label>
          <Font>
            <CssParameter name="font-family">SansSerif</CssParameter>
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
                <DisplacementY>10</DisplacementY>
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
            <CssParameter name="fill">#26a32b</CssParameter>
          </Fill>

        </TextSymbolizer>
      </Rule>

      <Rule>
        <Name>High Schools</Name>
        <Title>High Schools &lt; 1:17.5</Title>
        <ogc:Filter>
            <ogc:And>
              <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
                <ogc:PropertyName>city</ogc:PropertyName>
                <ogc:Literal>medford</ogc:Literal>
              </ogc:PropertyIsLike>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>type</ogc:PropertyName>
                <ogc:Literal>High School</ogc:Literal>          
              </ogc:PropertyIsEqualTo>              
            </ogc:And>
          </ogc:Filter>

        <MinScaleDenominator> 1000 </MinScaleDenominator>
        <MaxScaleDenominator> 17500 </MaxScaleDenominator>

        <PointSymbolizer>
          <Graphic>
            <ExternalGraphic>
              <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" 
                xlink:href="high_school20.png"/>
              <Format>image/png</Format>
            </ExternalGraphic>
            <Mark/>
            <Size>20</Size>
          </Graphic>
        </PointSymbolizer>
        
        <TextSymbolizer>
          <Label>
            <ogc:PropertyName>name</ogc:PropertyName> School
          </Label>
          <Font>
            <CssParameter name="font-family">SansSerif</CssParameter>
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
                <DisplacementY>10</DisplacementY>
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
            <CssParameter name="fill">#004d96</CssParameter>
          </Fill>

        </TextSymbolizer>
      </Rule>

      </FeatureTypeStyle>
      
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>