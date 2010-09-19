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
        <!--Rail Road-->
				<!--220K-56K-->      
        <Rule>
          <Name>RailRoad </Name>
          <Title>RailRoad 1:220K-1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>

          <MinScaleDenominator> 56000 </MinScaleDenominator>
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>   
		      <LineSymbolizer>
		        <Stroke>
		          <CssParameter name="stroke">#404040</CssParameter>
		          <CssParameter name="stroke-linejoin">round</CssParameter>
		          <CssParameter name="stroke-width">1.5</CssParameter>
		          <CssParameter name="stroke-dasharray">5.0 4.0 </CssParameter>
		        </Stroke>
		      </LineSymbolizer>
        </Rule>
				<!--< 56K-->
        <Rule>
          <Name>RailRoad </Name>
          <Title>RailRoad &lt; 1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>sld_type</ogc:PropertyName>
              <ogc:Literal>rail_roads</ogc:Literal>          
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>   
		      <LineSymbolizer>
		        <Stroke>
		          <CssParameter name="stroke">#404040</CssParameter>
		          <CssParameter name="stroke-linejoin">round</CssParameter>
		          <CssParameter name="stroke-width">2.5</CssParameter>
		          <CssParameter name="stroke-dasharray">5.0 4.0 </CssParameter>
		        </Stroke>
		      </LineSymbolizer>
        </Rule>
				<!--STREETS-->
        <!--220K-110K-->
        <Rule>
          <Name>Streets</Name>
          <Title>Streets 1:220K-1:110K</Title>
          <ElseFilter/>
          <MinScaleDenominator> 110000 </MinScaleDenominator>
          <MaxScaleDenominator> 220000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#a5a5a5</CssParameter>
              <CssParameter name="width">.25</CssParameter>
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
              <CssParameter name="stroke">#a5a5a5</CssParameter>
              <CssParameter name="width">.5</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        <!--18K-9K-->
        <Rule>
          <Name>Streets</Name>
          <Title>Streets 18K-9K</Title>
          <ElseFilter/>
          <MinScaleDenominator> 9000 </MinScaleDenominator>
          <MaxScaleDenominator> 18000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#a5a5a5</CssParameter>
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-family">SansSerif</CssParameter>
              <CssParameter name="font-size">10</CssParameter>
            </Font>
						<LabelPlacement>
		          <LinePlacement>
		            <PerpendicularOffset>
		              <ogc:Literal>0.5</ogc:Literal>
		            </PerpendicularOffset>
		          </LinePlacement>
		        </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>1</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.5</CssParameter>
              </Fill>
            </Halo>
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption>
          </TextSymbolizer>
        </Rule>
				<!--< 9K-->
				<Rule>
          <Name>Streets</Name>
          <Title>Streets &lt; 9K</Title>
          <ElseFilter/>
          <MaxScaleDenominator> 9000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#a5a5a5</CssParameter>
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-family">SansSerif</CssParameter>
              <CssParameter name="font-size">11</CssParameter>
            </Font>
						<LabelPlacement>
		          <LinePlacement>
		            <PerpendicularOffset>
		              <ogc:Literal>0.5</ogc:Literal>
		            </PerpendicularOffset>
		          </LinePlacement>
		        </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>1</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.5</CssParameter>
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
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
        </Rule>
        <!-- 220K-110K-->
        <Rule>
          <Name>Major Roads</Name>
          <Title>Major Roads 1:220K-1:110K</Title>
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
              <CssParameter name="stroke">#737373</CssParameter>
              <CssParameter name="width">2</CssParameter>
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
              <CssParameter name="width">4</CssParameter>
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
              <CssParameter name="width">5</CssParameter>
            </Stroke>
          </LineSymbolizer>
		      <TextSymbolizer>
		        <Label>
		            <ogc:PropertyName>namelow</ogc:PropertyName>
		        </Label>
		        <Font>
		          <CssParameter name="font-family">Arial</CssParameter>
		          <CssParameter name="font-size">10</CssParameter>
		          <CssParameter name="font-weight">bold</CssParameter>
		        </Font>
            <LabelPlacement>
              <LinePlacement>
                <PerpendicularOffset>.5</PerpendicularOffset>
              </LinePlacement>
            </LabelPlacement>
		        <Halo>
		          <Radius>
		            <ogc:Literal> 2 </ogc:Literal>
		          </Radius>
		          <Fill>
		            <CssParameter name="fill">#ffffff</CssParameter>
		            <CssParameter name="fill-opacity">0.5</CssParameter>
		          </Fill>
		        </Halo>
		        <Fill>
		          <CssParameter name="fill">#000133</CssParameter>
		        </Fill>
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
              <CssParameter name="width">6</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font>
              <CssParameter name="font-family">Arial</CssParameter>
              <CssParameter name="font-family">SansSerif</CssParameter>
              <CssParameter name="font-size">12</CssParameter>
		          <CssParameter name="font-weight">bold</CssParameter>
            </Font>
            <LabelPlacement>
              <LinePlacement>
                <PerpendicularOffset>.5</PerpendicularOffset>
              </LinePlacement>
            </LabelPlacement>
            <Halo>
              <Radius>
                <ogc:Literal>2</ogc:Literal>
              </Radius>
              <Fill>
                <CssParameter name="fill">#ffffff</CssParameter>
                <CssParameter name="fill-opacity">.5</CssParameter>
              </Fill>
            </Halo>
            <VendorOption name="maxDisplacement">50</VendorOption>
            <VendorOption name="labelAllGroup">true</VendorOption>
            <VendorOption name="followLine">true</VendorOption>
            <VendorOption name="group">true</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--HIGHWAYS-->
        <!--280K-220K-->
        <Rule>
          <Name>Highway</Name>
          <Title>Highway 1:280K-220K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <MinScaleDenominator> 220000 </MinScaleDenominator>
          <MaxScaleDenominator> 280000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">1</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
            <VendorOption name="spaceAround">150</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--HIGHWAY 62-->
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
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_6215.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
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
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_6215.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--< 56K-->
        <Rule>
          <Name>Highway-62</Name>
          <Title>Highway-62 &lt; 1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsLike wildCard="*" singleChar="." escape="\">
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>*HIGHWAY 62*</ogc:Literal>
            </ogc:PropertyIsLike>
          </ogc:Filter>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">5</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_6218.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>158</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--HIGHWAY 238-->
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
              <CssParameter name="stroke">#404040</CssParameter>
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_23818.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
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
              <CssParameter name="stroke">#5d5d5d</CssParameter>
              <CssParameter name="width">4</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_23815.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>15</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--< 56K-->
        <Rule>
          <Name>Highway-238</Name>
          <Title>Highway-238 &lt; 1:56K</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>streetname</ogc:PropertyName>
              <ogc:Literal>HIGHWAY 238</ogc:Literal>
            </ogc:PropertyIsEqualTo>
          </ogc:Filter>
          <MaxScaleDenominator> 56000 </MaxScaleDenominator>
          <LineSymbolizer>
            <Stroke>
              <CssParameter name="stroke">#5d5d5d</CssParameter>
              <CssParameter name="width">5</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
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
                <OnlineResource xlink:href="OR_23818.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>18</Size>
            </Graphic>
            <Priority>30000</Priority>
            <VendorOption name="spaceAround">50</VendorOption>
            <VendorOption name="group">no</VendorOption>
          </TextSymbolizer>
        </Rule>
        <!--INTERSTATE OUTER-->
        <!--280K-220K-->
        <Rule>
          <Name>Interstate</Name>
          <Title>Interstate 1:280K-1:220K</Title>
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
          <Title>Interstate 1:220K-1:110K</Title>
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
              <CssParameter name="width">5</CssParameter>
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
          <Title>Interstate 1:280K-1:220K</Title>
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
            <Font></Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="interstate_512.png"/>
                <Format>image/png</Format>
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
          <Title>Interstate 1:220K-1:110K</Title>
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
            <Font></Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="interstate_515.png"/>
                <Format>image/png</Format>
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
              <CssParameter name="width">3</CssParameter>
            </Stroke>
          </LineSymbolizer>
          <TextSymbolizer>
            <Label>
              <ogc:PropertyName>namelow</ogc:PropertyName>
            </Label>
            <Font></Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="interstate_518.png"/>
                <Format>image/png</Format>
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
            <Font></Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="interstate_521.png"/>
                <Format>image/png</Format>
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
            <Font></Font>
            <Fill>
              <CssParameter name="fill-opacity">0</CssParameter>
            </Fill>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xlink:href="interstate_524.png"/>
                <Format>image/png</Format>
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