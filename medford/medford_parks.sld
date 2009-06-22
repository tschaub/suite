<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:medford_parks</Name>
    <UserStyle>
      <Title>Attribute Based Point</Title>
      <Abstract>A sample style</Abstract>

    <FeatureTypeStyle>
      
<!--1st RANGE OF PARKS -->

   <!--small scale -->
   <Rule>
       <Name>Below 10,000</Name>
       <Title>Below 10,000</Title>
       <ogc:Filter>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>          
           </ogc:PropertyIsLessThan>
       </ogc:Filter>
       <MinScaleDenominator> 65000 </MinScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#82ca9c</CssParameter>
               <CssParameter name="fill-opacity">0.7</CssParameter>
             </Fill>
             
             <Stroke>
			   <CssParameter name="stroke">#82ca9c</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.7</CssParameter>

             </Stroke>
        </PolygonSymbolizer> 
     </Rule>
     
     <!-- middle scale -->
     <Rule>
       <Name>Below 10,000</Name>
       <Title>Below 10,000</Title>
       <ogc:Filter>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>          
           </ogc:PropertyIsLessThan>
       </ogc:Filter>
		<MinScaleDenominator> 13000 </MinScaleDenominator>
    	<MaxScaleDenominator> 65000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#82ca9c</CssParameter>               
               <CssParameter name="fill-opacity">0.8</CssParameter>
			</Fill>
			
			<Stroke>
			   <CssParameter name="stroke">#82ca9c</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.8</CssParameter>

			</Stroke>
        </PolygonSymbolizer>        

     </Rule>
  
     <!-- large scale -->
      <Rule>
       <Name>Below 10,000 </Name>
       <Title>Below 10,000 </Title>
       <ogc:Filter>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>          
           </ogc:PropertyIsLessThan>
       </ogc:Filter>
	    <MaxScaleDenominator> 13000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#82ca9c</CssParameter>
               <CssParameter name="fill-opacity">.9</CssParameter>
			</Fill>
			
			<Stroke>
			   <CssParameter name="stroke">#82ca9c</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.9</CssParameter>

			</Stroke>
        </PolygonSymbolizer> 
        
        
        
			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				
				<Halo>
					<Radius>
						<ogc:Literal>2</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">12</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">100</VendorOption>

			</TextSymbolizer> 
     </Rule>    
     
     
      
 
 
<!--2ND RANGE OF PARKS -->

   <!--small scale -->
   <Rule>
       <Name>Between 10,000 and 50,000</Name>
       <Title>10,000 to 50,000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
       <MinScaleDenominator> 65000 </MinScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#3cb878</CssParameter>
               <CssParameter name="fill-opacity">0.7</CssParameter>
             </Fill>
             
             <Stroke>
			   <CssParameter name="stroke">#3cb878</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.7</CssParameter>

             </Stroke>
        </PolygonSymbolizer> 
     </Rule>
     
     <!-- middle scale -->
     <Rule>
       <Name>Between 10,000 and 50,000</Name>
       <Title>10,000 to 50,000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
		<MinScaleDenominator> 13000 </MinScaleDenominator>
    	<MaxScaleDenominator> 65000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#3cb878</CssParameter>               
               <CssParameter name="fill-opacity">0.8</CssParameter>

			</Fill>
			
			<Stroke>
			   <CssParameter name="stroke">#3cb878</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.8</CssParameter>

			</Stroke>
        </PolygonSymbolizer>        

     </Rule>
  
     <!-- large scale -->
      <Rule>
       <Name>Between 10,000 and 50,000</Name>
       <Title>10,000 to 50,000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>10000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
	    <MaxScaleDenominator> 13000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#3cb878</CssParameter>
               <CssParameter name="fill-opacity">0.9</CssParameter>
			</Fill>
			
			<Stroke>
			   <CssParameter name="stroke">#3cb878</CssParameter>
               <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.9</CssParameter>

			</Stroke>
        </PolygonSymbolizer> 
        
        
        
			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				
				<Halo>
					<Radius>
						<ogc:Literal>2</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">12</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">100</VendorOption>

			</TextSymbolizer> 
     </Rule>    
     
     
     
<!--3RD RANGE OF PARKS -->

   <!--small scale -->
   <Rule>
       <Name>Between 50,000 and 500,000</Name>
       <Title>50000 to 500000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
       <MinScaleDenominator> 65000 </MinScaleDenominator>
		<PolygonSymbolizer>        
			  <Fill>
               <CssParameter name="fill">#00a651</CssParameter>
               <CssParameter name="fill-opacity">0.7</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#00a651</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.2</CssParameter>

             </Stroke>
        </PolygonSymbolizer> 
     </Rule>
     
     <!-- middle scale -->
     <Rule>
       <Name>Between 50,000 and 500,000</Name>
       <Title>50000 to 500000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
		<MinScaleDenominator> 16000 </MinScaleDenominator>
    	<MaxScaleDenominator> 65000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#00a651</CssParameter>
               <CssParameter name="fill-opacity">0.8</CssParameter>

             </Fill>
                         
             <Stroke>
			  <CssParameter name="stroke">#00a651</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.8</CssParameter>
			  
            </Stroke>
        </PolygonSymbolizer>        

     </Rule>
  
     <!-- large scale -->
      <Rule>
       <Name>Between 50000 and 500000</Name>
       <Title>50000 to 500000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>50000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
	    <MaxScaleDenominator> 16000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#00a651</CssParameter>               
               <CssParameter name="fill-opacity">0.9</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#00a651</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.9</CssParameter>

            </Stroke>
        </PolygonSymbolizer> 

			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				 <LabelPlacement>
           <PointPlacement>
             <AnchorPoint>
               <AnchorPointX>0.5</AnchorPointX>
               <AnchorPointY>0.0</AnchorPointY>
             </AnchorPoint>
             
           </PointPlacement>
         </LabelPlacement>

				<Halo>
					<Radius>
						<ogc:Literal>1</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">12</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">100</VendorOption>

			</TextSymbolizer> 
     </Rule>    
     
  
       
<!--4th RANGE OF PARKS -->

   <!--small scale -->
   <Rule>
       <Name>Between 500,000 and 1,000,000</Name>
       <Title>500,000 to 1,000,000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
       <MinScaleDenominator> 65000 </MinScaleDenominator>
		<PolygonSymbolizer>        
			  <Fill>
               <CssParameter name="fill">#007236</CssParameter>
               <CssParameter name="fill-opacity">0.7</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#007236</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.2</CssParameter>

             </Stroke>
        </PolygonSymbolizer> 
     </Rule>
     
     <!-- middle scale -->
     <Rule>
       <Name>Between 500,000 and 1,000,000</Name>
       <Title>500,000 to 1,000,000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
		<MinScaleDenominator> 16000 </MinScaleDenominator>
    	<MaxScaleDenominator> 65000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#007236</CssParameter>
               <CssParameter name="fill-opacity">0.8</CssParameter>

             </Fill>
                         
             <Stroke>
			  <CssParameter name="stroke">#007236</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.8</CssParameter>
			  
            </Stroke>
        </PolygonSymbolizer>        

     </Rule>
  
     <!-- large scale -->
      <Rule>
       <Name>Between 500,000 and 1,000,000</Name>
       <Title>500000 to 1000000</Title>
       <ogc:Filter>
         <ogc:And>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>500000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyIsLessThan>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsLessThan>
         </ogc:And>
       </ogc:Filter>
	    <MaxScaleDenominator> 16000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#007236</CssParameter>               
               <CssParameter name="fill-opacity">0.9</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#007236</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.9</CssParameter>

            </Stroke>
        </PolygonSymbolizer> 

			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				 <LabelPlacement>
           <PointPlacement>
             <AnchorPoint>
               <AnchorPointX>0.5</AnchorPointX>
               <AnchorPointY>0.0</AnchorPointY>
             </AnchorPoint>
             
           </PointPlacement>
         </LabelPlacement>

				<Halo>
					<Radius>
						<ogc:Literal>1</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">12</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">100</VendorOption>

			</TextSymbolizer> 
     </Rule> 
  
 <!--5th RANGE OF PARKS -->

   <!--small scale -->
   <Rule>
       <Name>Greater than 1,000,000</Name>
       <Title>Greater than 1,000,000</Title>
       <ogc:Filter>
         
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           
       </ogc:Filter>
       <MinScaleDenominator> 65000 </MinScaleDenominator>
		<PolygonSymbolizer>        
			  <Fill>
               <CssParameter name="fill">#005826</CssParameter>
               <CssParameter name="fill-opacity">0.7</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#005826</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.2</CssParameter>

             </Stroke>
        </PolygonSymbolizer> 
     </Rule>
     
     <!-- middle scale -->
     <Rule>
       <Name>Greater than 1,000,000</Name>
       <Title>Greater than 1,000,000</Title>
       <ogc:Filter>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           
       </ogc:Filter>
		<MinScaleDenominator> 16000 </MinScaleDenominator>
    	<MaxScaleDenominator> 65000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#005826</CssParameter>
               <CssParameter name="fill-opacity">0.8</CssParameter>

             </Fill>
                         
             <Stroke>
			  <CssParameter name="stroke">#005826</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.8</CssParameter>
			  
            </Stroke>
        </PolygonSymbolizer>   
        
        			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				 <LabelPlacement>
           <PointPlacement>
             <AnchorPoint>
               <AnchorPointX>3</AnchorPointX>
               <AnchorPointY>0.0</AnchorPointY>
             </AnchorPoint>
             
           </PointPlacement>
         </LabelPlacement>

				<Halo>
					<Radius>
						<ogc:Literal>2</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">14</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">200</VendorOption>

			</TextSymbolizer> 

     </Rule>
  
     <!-- large scale -->
      <Rule>
       <Name>Greater than 1,000,000</Name>
       <Title>Greater than 1000000</Title>
       <ogc:Filter>
           <ogc:PropertyIsGreaterThanOrEqualTo>
             <ogc:PropertyName>area</ogc:PropertyName>
             <ogc:Literal>1000000</ogc:Literal>
           </ogc:PropertyIsGreaterThanOrEqualTo>
           
       </ogc:Filter>
	    <MaxScaleDenominator> 16000 </MaxScaleDenominator>
		<PolygonSymbolizer>        
			<Fill>
               <CssParameter name="fill">#005826</CssParameter>               
               <CssParameter name="fill-opacity">0.9</CssParameter>
             </Fill>
             
             <Stroke>
			  <CssParameter name="stroke">#005826</CssParameter>
			  <CssParameter name="stroke-width">1</CssParameter>
               <CssParameter name="stroke-opacity">0.9</CssParameter>

            </Stroke>
        </PolygonSymbolizer> 

			<TextSymbolizer>
				<Label>
					<ogc:PropertyName>name</ogc:PropertyName>
				</Label>  
				 

				<Halo>
					<Radius>
						<ogc:Literal>2</ogc:Literal>
					</Radius>
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
						<CssParameter name="fill-opacity">.7</CssParameter>				
					</Fill>
				</Halo>
				
				<Font>
					<CssParameter name="font-family">Helvetica</CssParameter>
					<CssParameter name="font-style">Normal</CssParameter>
					<CssParameter name="font-size">18</CssParameter>
					<CssParameter name="font-weight">normal</CssParameter>
			</Font>
			 <VendorOption name="spaceAround">300</VendorOption>

			</TextSymbolizer> 
     </Rule> 
 
 <!--   

     
     <Rule>
       <Name>Greater than 1,000,000</Name>
       <Title>Greater than 1000000</Title>
       <ogc:Filter>
         <ogc:PropertyIsGreaterThanOrEqualTo>
           <ogc:PropertyName>area</ogc:PropertyName>
           <ogc:Literal>1000000</ogc:Literal>
         </ogc:PropertyIsGreaterThanOrEqualTo>
       </ogc:Filter>
       <PointSymbolizer>
         <Graphic>
           <Mark>
             <WellKnownName>circle</WellKnownName>
             <Fill>
               <CssParameter name="fill">#02d1fd</CssParameter>
               <CssParameter name="fill-opacity">0.2</CssParameter>
             </Fill>
           </Mark>
           <Size>18</Size>
         </Graphic>
       </PointSymbolizer>
     </Rule>
     
     
 -->


     
     
   </FeatureTypeStyle>


    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>

