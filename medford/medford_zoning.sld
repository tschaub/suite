<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>medford:medford_zoning</Name>
    <UserStyle>
    <Title>zoning for medford</Title>
<!--COUNTY ZONES-->
<!--zone AD-MU-->
 		<FeatureTypeStyle>
			<Rule>      
				<Title>zone AD-MU</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>AD-MU</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#ed1c24</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
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
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>C-C</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f26522</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
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
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>C-H</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f7941d</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
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
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>C-N</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#fff200</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Neighborhood
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
				
<!--C-R zones-->		
			<Rule>      
				<Title>C-R zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>C-R</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#8dc63f</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Regional
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
		
<!-- C-S/P zones-->		
			<Rule>      
				<Title>C-S/P zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>C-S/P</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#39b54a</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: Service/Professional
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
		
<!-- GC zones-->		
			<Rule>      
				<Title>GC zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>GC</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#00a651</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Commercial: General
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

<!-- EFU zones-->		
			<Rule>      
				<Title> EFU zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal> EFU</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#00a99d</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Resource: Exclusive Farm Use
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

<!-- F-5 zones-->		
			<Rule>      
				<Title> F-5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>F-5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#00aeef</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Residential: Farm 5 Acre Minimum
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

<!-- GI zones-->		
			<Rule>      
				<Title> GI zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>GI</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#0072bc</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: General
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
		
<!-- I-G zones-->		
			<Rule>      
				<Title> I-G zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>I-G</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#0054a6</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: General
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
		
<!-- I-H zones-->		
			<Rule>      
				<Title> I-H zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>I-H</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#2e3192</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Heavy
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

<!-- I-L zones-->		
			<Rule>      
				<Title> I-L zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>I-L</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#662d91</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Light
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

<!-- LI zones-->		
			<Rule>      
				<Title> LI zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>LI</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#92278f</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Industrial: Light (County)
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
		
<!--MFR-15 zones-->		
			<Rule>      
				<Title> MFR-15 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>MFR-15</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#ec008c</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 15 Units/Acre
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

<!--MFR-20 zones-->		
			<Rule>      
				<Title> MFR-20 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>MFR-20</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#ed145b</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 20 Units/Acre
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
		
<!--MFR-30 zones-->		
			<Rule>      
				<Title> MFR-30 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>MFR-30</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f06eaa</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						Multi-Family - 30 Units/Acre
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

<!--RR-5 zones-->		
			<Rule>      
				<Title> RR-5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>RR-5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#8560a8</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Rural - 5 Acre Minimum
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

<!--SFR-00 zones-->		
			<Rule>      
				<Title> SFR-00 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SFR-00</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#5674b9</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family 1 Unit/Lot
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
		
<!--SFR-10 zones-->		
			<Rule>      
				<Title> SFR-10 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SFR-10</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#1cbbb4</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 10 Unit/Acre
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

<!--SFR-2 zones-->		
			<Rule>      
				<Title> SFR-2 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SFR-2</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#7cc576</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 2 Unit/Acre
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
		
<!--SFR-4 zones-->		
			<Rule>      
				<Title> SFR-4 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SFR-4</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#fbaf5d</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 4 Unit/Acre
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

<!--SFR-6 zones-->		
			<Rule>      
				<Title> SFR-6 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SFR-6</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f68e56</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 Single Family - 6 Unit/Acre
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

<!--SR-1 zones-->		
			<Rule>      
				<Title> SR-1 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SR-1</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f26c4f</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 SR-1 Suburban 1 Acre Minimum
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


<!--SR-2.5 zones-->		
			<Rule>      
				<Title> SR-2.5 zones</Title>
				<ogc:Filter>
					<ogc:PropertyIsEqualTo>
						<ogc:PropertyName>zoning</ogc:PropertyName>
						<ogc:Literal>SR-2.5</ogc:Literal>
					</ogc:PropertyIsEqualTo>	
				</ogc:Filter>
         
				<PolygonSymbolizer>
					<Fill>
					  <CssParameter name="fill">#f26d7d</CssParameter>
					  <CssParameter name="fill-opacity">.4</CssParameter>		
					</Fill>
				</PolygonSymbolizer>
				
<!-- 
				<TextSymbolizer>
					<Label>
						 SR-1 Suburban 2.5 Acre Minimum
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
		</FeatureTypeStyle>			
		
		</UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>