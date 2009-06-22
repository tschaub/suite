<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xsi:schemaLocation="http://www.opengis.net/sld StyledLayerDescriptor.xsd"
  xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <NamedLayer>
    <Name>medford:buildings</Name>
    <UserStyle>

      <Title>buildings change color with elevation</Title>
      <Abstract></Abstract>
<!--COUNTY ZONES-->
<!--zone AD-MU-->
 		<FeatureTypeStyle>
			<Rule>      
				<Title>zone AD-MU</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>AD-MU</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#ed1c24</CssParameter>
					</Stroke>
				</LineSymbolizer>
<!-- 
				
				<TextSymbolizer>
					<Label>
						Industrial: Airport Development-Multi Use
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
					</Fill>
				</TextSymbolizer>
 -->
			</Rule>

<!--C-C zones-->		
			<Rule>      
				<Title>C-C zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>C-C</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f26522</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Community
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
					</Fill>
				</TextSymbolizer>
 -->
			</Rule>

<!--C-H zones-->		
			<Rule>      
				<Title>C-H zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>C-H</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f7941d</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Heavy
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Fill>
						<CssParameter name="fill">#ffffff</CssParameter>
					</Fill>
				</TextSymbolizer>
 -->
			</Rule>
		
<!--C-N zones-->		
			<Rule>      
				<Title>C-N zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>C-N</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#fff200</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Neighborhood
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
				
<!--C-R zones-->		
			<Rule>      
				<Title>C-R zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>C-R</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#8dc63f</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Regional
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!-- C-S/P zones-->		
			<Rule>      
				<Title>C-S/P zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>C-S/P</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#39b54a</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Service/Professional
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!-- GC zones-->		
			<Rule>      
				<Title>GC zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>GC</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#00a651</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: General
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!-- EFU zones-->		
			<Rule>      
				<Title> EFU zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal> EFU</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#00a99d</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Resource: Exclusive Farm Use
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!-- F-5 zones-->		
			<Rule>      
				<Title> F-5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>F-5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#00aeef</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Residential: Farm 5 Acre Minimum
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!-- GI zones-->		
			<Rule>      
				<Title> GI zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>GI</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#0072bc</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: General
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!-- I-G zones-->		
			<Rule>      
				<Title> I-G zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>I-G</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#0054a6</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: General
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!-- I-H zones-->		
			<Rule>      
				<Title> I-H zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>I-H</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#2e3192</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Heavy
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!-- I-L zones-->		
			<Rule>      
				<Title> I-L zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>I-L</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#662d91</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Light
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!-- LI zones-->		
			<Rule>      
				<Title> LI zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>LI</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#92278f</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Light (County)
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!--MFR-15 zones-->		
			<Rule>      
				<Title> MFR-15 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>MFR-15</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#ec008c</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 15 Units/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--MFR-20 zones-->		
			<Rule>      
				<Title> MFR-20 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>MFR-20</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#ed145b</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 20 Units/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!--MFR-30 zones-->		
			<Rule>      
				<Title> MFR-30 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>MFR-30</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f06eaa</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 30 Units/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--RR-5 zones-->		
			<Rule>      
				<Title> RR-5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>RR-5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#8560a8</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Rural - 5 Acre Minimum
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--SFR-00 zones-->		
			<Rule>      
				<Title> SFR-00 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SFR-00</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#5674b9</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family 1 Unit/Lot
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!--SFR-10 zones-->		
			<Rule>      
				<Title> SFR-10 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SFR-10</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#1cbbb4</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 10 Unit/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--SFR-2 zones-->		
			<Rule>      
				<Title> SFR-2 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SFR-2</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#7cc576</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 2 Unit/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
		
<!--SFR-4 zones-->		
			<Rule>      
				<Title> SFR-4 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SFR-4</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#fbaf5d</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 4 Unit/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--SFR-6 zones-->		
			<Rule>      
				<Title> SFR-6 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SFR-6</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f68e56</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 6 Unit/Acre
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>

<!--SR-1 zones-->		
			<Rule>      
				<Title> SR-1 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SR-1</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f26c4f</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 SR-1 Suburban 1 Acre Minimum
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>


<!--SR-2.5 zones-->		
			<Rule>      
				<Title> SR-2.5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zone</ogc:PropertyName>
						<ogc:Literal>SR-2.5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<LineSymbolizer>
					<Stroke>
					  <CssParameter name="stroke">#f26d7d</CssParameter>
					</Stroke>
				</LineSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 SR-1 Suburban 2.5 Acre Minimum
					</Label>

					<Font>
						<CssParameter name="font-family">Times New Roman</CssParameter>
						<CssParameter name="font-style">Normal</CssParameter>
					</Font>						
					<Stroke>
						<CssParameter name="stroke">#ffffff</CssParameter>
					</Stroke>
				</TextSymbolizer>
 -->
			</Rule>
			
<!--everything else-->			
			<Rule>
				<ogc:ElseFilter>	
				</ogc:ElseFilter>
				<LineSymbolizer>
					<Stroke>
						<CssParameter name="stroke">
							<ogc:Literal>#262626</ogc:Literal>
						</CssParameter>
					</Stroke>
				</LineSymbolizer>
			</Rule>
        

       
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>

