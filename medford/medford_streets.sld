<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:cadstreets</Name>
    <UserStyle>
      <Title>1 px blue line</Title>
      <Abstract>Default line style, 1 pixel wide blue</Abstract>


<!--normal streets-->
<FeatureTypeStyle>
<!--small zoom-->
	<Rule>
		<Title>normal streets</Title>
			<ogc:Filter>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			</ogc:Filter>
					
		<MinScaleDenominator> 110000 </MinScaleDenominator>
	</Rule>
        

<!--medium zoom & large-->
	<Rule>
		<Title>normal streets</Title>

		
		<MinScaleDenominator> 18000 </MinScaleDenominator>
    	<MaxScaleDenominator> 110000 </MaxScaleDenominator>
    	
		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#8c8c8c</CssParameter> 
				<CssParameter name="width">1</CssParameter>
			</Stroke>
		</LineSymbolizer>
          	
	</Rule>

<!--x-large-->
	<Rule>
		<Title>normal streets</Title>

	    <MaxScaleDenominator> 18000 </MaxScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#8c8c8c</CssParameter> <!--light cyan blue-->
				<CssParameter name="width">2</CssParameter>
			</Stroke>
		</LineSymbolizer>
		
		<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">10</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
		         
	</Rule>

</FeatureTypeStyle>


<!--Railroad-->
<FeatureTypeStyle>
<!--tiny zoom-->
<!--border-->
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MinScaleDenominator> 220000 </MinScaleDenominator>
 
	</Rule> 
<!--small zoom-->
<!--border-->
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MaxScaleDenominator> 220000 </MaxScaleDenominator>		
		<MinScaleDenominator> 110000 </MinScaleDenominator>
			<LineSymbolizer>
	            <Stroke>
	              <CssParameter name="stroke">#000000</CssParameter>
	              <CssParameter name="stroke-width">4</CssParameter>
	              <CssParameter name="stroke-opacity">.45</CssParameter>

	            </Stroke>
          </LineSymbolizer> 
	</Rule> 
<!--inner line-->	
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MaxScaleDenominator> 212000 </MaxScaleDenominator>		
		<MinScaleDenominator> 53000 </MinScaleDenominator>
			<LineSymbolizer>
			<Stroke>
	              <CssParameter name="stroke">#ffffff</CssParameter>
	              <CssParameter name="stroke-width">3</CssParameter>
			</Stroke>
          </LineSymbolizer> 
	</Rule>
<!--hatch line-->	
	<Rule>
		<Title>Railroad</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MaxScaleDenominator> 212000 </MaxScaleDenominator>		
		<MinScaleDenominator> 53000 </MinScaleDenominator>
		
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
       

		
       
<!--medium zoom-->
<!--border-->
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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
<!--inner line-->	
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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
<!--hatch line-->	
	<Rule>
		<Title>Railroad</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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

<!--large zoom-->
<!--border-->
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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
<!--inner line-->	
	<Rule>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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
<!--hatch line-->	
	<Rule>
		<Title>Railroad</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>streettype</ogc:PropertyName>
				<ogc:Literal>RR</ogc:Literal>          
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



</FeatureTypeStyle>


<!--MAJOR ROADS -->
<FeatureTypeStyle>
<!-- tiny zoom-->
	<Rule>
		<Title>major roads</Title>
				<ogc:Filter>
			<ogc:Or>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>speed</ogc:PropertyName>
					<ogc:Literal>35</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Poplar*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*E Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Biddle*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Mcandrews*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Main*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
			
		<MinScaleDenominator> 220000 </MinScaleDenominator>

	</Rule> 
<!--small zoom -->
	<Rule>
		<Title>major roads</Title>
			<ogc:Filter>
			<ogc:Or>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>speed</ogc:PropertyName>
					<ogc:Literal>35</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Poplar*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*E Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Biddle*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Mcandrews*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Main*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
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
        

<!--medium zoom-->
	<Rule>
		<Title>major roads</Title>
				<ogc:Filter>
			<ogc:Or>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>speed</ogc:PropertyName>
					<ogc:Literal>35</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Poplar*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*E Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Biddle*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Mcandrews*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Main*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
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

<!--large scale-->
	<Rule>
		<Title>major roads</Title>
				<ogc:Filter>
			<ogc:Or>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>speed</ogc:PropertyName>
					<ogc:Literal>35</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Poplar*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*E Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Biddle*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Mcandrews*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Main*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
			
		<MinScaleDenominator> 18000 </MinScaleDenominator>
    	<MaxScaleDenominator> 56000 </MaxScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#737373</CssParameter> 
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
        
		<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">10</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
		
	</Rule>


<!--large scale-->
	<Rule>
		<Title>major roads</Title>
				<ogc:Filter>
			<ogc:Or>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>speed</ogc:PropertyName>
					<ogc:Literal>35</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Poplar*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*E Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Biddle*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Barnett*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>4</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Crater Lake*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Mcandrews*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Main*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*Jackson*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
			
		<MinScaleDenominator> 9000 </MinScaleDenominator>
    	<MaxScaleDenominator> 18000 </MaxScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#737373</CssParameter> 
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
        
		<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">11</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
		
	</Rule>
	
</FeatureTypeStyle>

<!--HIGHWAYS-->
<FeatureTypeStyle>
<!--tiny zoom-->
	<Rule>
		<Title>Highway</Title>
			<ogc:Filter>
			<ogc:Or>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>2</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*N Central*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
			
		
		<MinScaleDenominator> 220000 </MinScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#595959</CssParameter> <!--darker gray-->
				<CssParameter name="width">1</CssParameter>
			</Stroke>
		</LineSymbolizer>
	</Rule>

<!--small zoom-->
	<Rule>
		<Title>Highway</Title>
			<ogc:Filter>
			<ogc:Or>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>2</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*N Central*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
			
		
		<MaxScaleDenominator> 220000 </MaxScaleDenominator>
		<MinScaleDenominator> 110000 </MinScaleDenominator>


		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#595959</CssParameter> 
				<CssParameter name="width">2</CssParameter>
			</Stroke>
		</LineSymbolizer>
	</Rule>
        

<!--medium zoom-->
	<Rule>
		<Title>Highway</Title>
			<ogc:Filter>
			<ogc:Or>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>2</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*N Central*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>
		
		<MinScaleDenominator> 56000 </MinScaleDenominator>
    	<MaxScaleDenominator> 110000 </MaxScaleDenominator>
    	
		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#595959</CssParameter> 
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
          	

	</Rule>

<!--large scale-->
	<Rule>
		<Title>Highway</Title>
			<ogc:Filter>
			<ogc:Or>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>2</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*N Central*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>

		<MinScaleDenominator> 18000 </MinScaleDenominator>
    	<MaxScaleDenominator> 56000 </MaxScaleDenominator>
    	
		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#595959</CssParameter>
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
        
		<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">11</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>

	</Rule>


<!--x-large scale-->
	<Rule>
		<Title>Highway</Title>
			<ogc:Filter>
			<ogc:Or>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>2</ogc:Literal>
				</ogc:PropertyIsEqualTo>	
			<ogc:And>
				<ogc:PropertyIsEqualTo>
					<ogc:PropertyName>type</ogc:PropertyName>
					<ogc:Literal>3</ogc:Literal>
				</ogc:PropertyIsEqualTo>
				<ogc:PropertyIsLike wildCard="*" singleChar="?" escape="\">
					<ogc:PropertyName>namelow</ogc:PropertyName>
					<ogc:Literal>*N Central*</ogc:Literal>
				</ogc:PropertyIsLike>				
			</ogc:And>
			</ogc:Or>
			</ogc:Filter>

		<MinScaleDenominator> 9000 </MinScaleDenominator>
    	<MaxScaleDenominator> 18000 </MaxScaleDenominator>
    	
		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#595959</CssParameter>
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
        
		<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">12</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>

	</Rule>
</FeatureTypeStyle>

<!--INTERSTATE-->
<FeatureTypeStyle>
<!--tiny zoom-->
	<Rule>
		<Title>Interstate</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>namelow</ogc:PropertyName>
				<ogc:Literal>I-5</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MinScaleDenominator> 220000 </MinScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#404040</CssParameter><!--gray-->
				<CssParameter name="width">2</CssParameter>
			</Stroke>
		</LineSymbolizer>
		
			
	</Rule>
        
<!--small zoom-->
	<Rule>
		<Title>Interstate</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>namelow</ogc:PropertyName>
				<ogc:Literal>I-5</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>
		
		<MaxScaleDenominator> 220000 </MaxScaleDenominator>
		<MinScaleDenominator> 110000 </MinScaleDenominator>

		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#404040</CssParameter><!--pure red-->
				<CssParameter name="width">3</CssParameter>
			</Stroke>
		</LineSymbolizer>
		
		
		<TextSymbolizer>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="spaceAround">175</VendorOption>

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">10</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>2</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
	</Rule>
        

<!--medium zoom-->
	<Rule>
		<Title>Interstate</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>namelow</ogc:PropertyName>
				<ogc:Literal>I-5</ogc:Literal>          
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
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">11</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
	</Rule>

<!--large scale-->
	<Rule>
		<Title>Interstate</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>namelow</ogc:PropertyName>
				<ogc:Literal>I-5</ogc:Literal>          
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
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">12</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
	</Rule>

<!--x-large scale-->
	<Rule>
		<Title>Interstate</Title>
		<ogc:Filter>
			<ogc:PropertyIsEqualTo>
				<ogc:PropertyName>namelow</ogc:PropertyName>
				<ogc:Literal>I-5</ogc:Literal>          
			</ogc:PropertyIsEqualTo>
		</ogc:Filter>

		<MinScaleDenominator> 9000 </MinScaleDenominator>
    	<MaxScaleDenominator> 18000 </MaxScaleDenominator>
    	
		<LineSymbolizer>
			<Stroke>
				<CssParameter name="stroke">#404040</CssParameter>
				<CssParameter name="width">4</CssParameter>
			</Stroke>
		</LineSymbolizer>
        
<TextSymbolizer>
			<VendorOption name="maxDisplacement">50</VendorOption>
			<VendorOption name="labelAllGroup">true</VendorOption>
			<VendorOption name="followLine">true</VendorOption>
			<VendorOption name="group">true</VendorOption> 

			<Label>
				<ogc:PropertyName>namelow</ogc:PropertyName>
			</Label>

			<Halo>
				<Radius>
					<ogc:Literal>1</ogc:Literal>
				</Radius>
				<Fill>
					<CssParameter name="fill">#ffffff</CssParameter>
					<CssParameter name="fill-opacity">.5</CssParameter>				
				</Fill>
			</Halo>
			
			<Font>
				<CssParameter name="font-family">Helvetica</CssParameter>
				<CssParameter name="font-style">Normal</CssParameter>
				<CssParameter name="font-size">12</CssParameter>
				<CssParameter name="font-weight">normal</CssParameter>
				
			</Font>

			<LabelPlacement>
				<LinePlacement>
					<PerpendicularOffset>1</PerpendicularOffset>
				</LinePlacement>
			</LabelPlacement>						

		</TextSymbolizer>
	</Rule>

</FeatureTypeStyle>

</UserStyle>
</NamedLayer>
</StyledLayerDescriptor>
