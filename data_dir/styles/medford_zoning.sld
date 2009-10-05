<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:medford_zoning</Name>
    <UserStyle>
      <Title>Medford, OR - Zoning</Title>
      <Abstract>Zones styled by residential, commercial, industrial, resource, list.</Abstract>

      <FeatureTypeStyle>
<!--COUNTY ZONES-->

<!--SR-1-->
        <Rule>
          <Name>SR-1</Name>
          <Title>Suburban: 1 Acre Minimum</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SR-1</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
              
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#c8cb2f</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>
          
          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#fbff3b</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#c8cb2f</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--SR-2.5-->
        <Rule>
          <Name>SR-2.5</Name>
          <Title>Suburban: 2.5 Acre Minimum</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SR-2.5</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#e1e398</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#fdffab</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#e1e398</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--RR-5-->
        <Rule>
          <Name>RR-5</Name>
          <Title>Rural: 5 Acre Minimum</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>RR-5</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#eaebc0</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#feffd0</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#eaebc0</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--F5-->
        <Rule>
          <Name>F-5</Name>
          <Title>Residential: Farm 5 Acre Minimum</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>F-5</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
              
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#77a0b4</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>
          
          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#a9e3ff</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#77a0b4</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--GC-->
        <Rule>
          <Name>GC</Name>
          <Title>Commercial: General</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>GC</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
              
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#b1000f</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>
          
          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#e70014</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#b1000f</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--NC-->
        <Rule>
          <Name>NC</Name>
          <Title>Commercial: Neighborhood</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>NC</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#d47177</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#ff888f</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#d47177</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--EFU-->
        <Rule>
          <Name>EFU</Name>
          <Title>Resource: Exclusive Farm Use</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>EFU</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#7cb382</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#9ce2a4</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#7cb382</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--OSR-->
        <Rule>
          <Name>OSR</Name>
          <Title>Resource: Open Space Reserve</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>OSR</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#6f8c72</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#84a788</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#6f8c72</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--GI-->
        <Rule>
          <Name>GI</Name>
          <Title>Industrial: General</Title>
            <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoning</ogc:PropertyName>
                <ogc:Literal>GI</ogc:Literal>
              </ogc:PropertyIsEqualTo>  
            </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#943d9c</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#cd55d8</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#943d9c</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--LI-->      
        <Rule>
          <Name>LI</Name>
          <Title>Industrial: Light</Title>
            <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoning</ogc:PropertyName>
                <ogc:Literal>LI</ogc:Literal>
              </ogc:PropertyIsEqualTo>  
            </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#c39bc6</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>

          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#f1c0f5</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#c39bc6</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--AD-MU-->
        <Rule>
          <Name>AD-MU</Name>
          <Title>Industrial: Airport Development-Multi-Use</Title>
            <ogc:Filter>
              <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoning</ogc:PropertyName>
                <ogc:Literal>AD-MU</ogc:Literal>
              </ogc:PropertyIsEqualTo>  
            </ogc:Filter>
                
          <PolygonSymbolizer>
            <Fill>
              <GraphicFill>
                  <Graphic>
                     <Mark>
                        <WellKnownName>shape://times</WellKnownName>
                        <Stroke>
                          <CssParameter name="stroke">#594828</CssParameter>
         	                <CssParameter name="stroke-width">.5</CssParameter>
                        </Stroke>
                     </Mark>
                     <Size>8</Size>
                  </Graphic>
              </GraphicFill>
            </Fill>
          </PolygonSymbolizer>
            
          <PolygonSymbolizer>
              <Fill>              
                <CssParameter name="fill">#dcb263</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>  
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#594828</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>            
            </PolygonSymbolizer>
        </Rule>

<!--CITY ZONES-->

<!--MFR-30-->
        <Rule>
          <Name>MFR-30</Name>
          <Title>Residential: Multi-Family 30 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>MFR-30</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
         
          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#651500</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#480f00</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--MFR-20-->
        <Rule>
          <Name>MFR-20</Name>
          <Title>Residential: Multi-Family 20 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>MFR-20</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#a15b30</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#824927</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--MFR-15-->
        <Rule>
          <Name>MFR-15</Name>
          <Title>Residential: Multi-Family 15 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>MFR-15</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
         
          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#d6943c</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#b47c32</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--SFR-10-->
        <Rule>
          <Name>SFR-10</Name>
          <Title>Residential: Single-Family 10 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SFR-10</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#ffc60f</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#bf940b</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--SFR-6-->
        <Rule>
          <Name>SFR-6</Name>
          <Title>Residential: Single-Family 6 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SFR-6</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#ffea00</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#d5c300</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--SFR-4-->
        <Rule>
          <Name>SFR-4</Name>
          <Title>Residential: Single-Family 4 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SFR-4</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#fbff3b</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#c8cb2f</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--SFR-2-->
        <Rule>
          <Name>SFR-2</Name>
          <Title>Residential: Single-Family 2 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SFR-2</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#fdffab</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#e1e398</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--SFR-00-->
        <Rule>
          <Name>SFR-00</Name>
          <Title>Residential: Single-Family 1 Units/Acre</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>SFR-00</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#feffd0</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#eaebc0</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--C-H-->
        <Rule>
          <Name>C-H</Name>
          <Title>Commercial: Heavy</Title>

          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>C-H</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>
         
          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#a30000</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#7b0000</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>
        
<!--C-R-->
        <Rule>
          <Name>C-R zones</Name>
          <Title>Commercial: Regional</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>C-R</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#ff0000</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#a50000</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>
        
<!--C-C-->
        <Rule>
          <Name>C-C</Name>
          <Title>Commercial: Community</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
                <ogc:PropertyName>zoning</ogc:PropertyName>
                <ogc:Literal>C-C</ogc:Literal>
              </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
              <Fill>
                <CssParameter name="fill">#fe5b91</CssParameter>
                <CssParameter name="fill-opacity">.4</CssParameter>   
              </Fill>
              <Stroke>
                <CssParameter name="stroke">#a53b5e</CssParameter>
                <CssParameter name="stroke-width">.5</CssParameter>
              </Stroke>
            </PolygonSymbolizer>
        </Rule>

<!--C-N-->
        <Rule>
          <Name>C-N</Name>
          <Title>Commercial: Neighborhood</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>C-N</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#f99487</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#c9776d</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

<!--C-S/P-->
        <Rule>
          <Name>C-S/P</Name>
          <Title>Commercial: Service/Professional</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>C-S/P</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#ffd4d6</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#d1aeaf</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

<!--I-H-->
        <Rule>
          <Name>I-H</Name>
          <Title>Industrial: Heavy</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>I-H</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#9500a6</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#770085</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

<!--I-G-->
        <Rule>
          <Name>I-G</Name>
          <Title>Industrial: General</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>I-G</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#cd55d8</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#943d9c</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>

<!--I-L-->
        <Rule>
          <Name>I-L</Name>
          <Title>Industrial: Light</Title>
          <ogc:Filter>
            <ogc:PropertyIsEqualTo>
              <ogc:PropertyName>zoning</ogc:PropertyName>
              <ogc:Literal>I-L</ogc:Literal>
            </ogc:PropertyIsEqualTo>  
          </ogc:Filter>

          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#f1c0f5</CssParameter>
              <CssParameter name="fill-opacity">.4</CssParameter>   
            </Fill>
            <Stroke>
              <CssParameter name="stroke">#c39bc6</CssParameter>
              <CssParameter name="stroke-width">.5</CssParameter>
            </Stroke>
          </PolygonSymbolizer>
        </Rule>


      </FeatureTypeStyle>     
    
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>