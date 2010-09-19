<?xml version="1.0" encoding="UTF-8"?>
<sld:UserStyle xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
  <sld:Name>medford_stormdrains</sld:Name>
  <sld:Title>Medford, OR - StormDrains</sld:Title>
  <sld:FeatureTypeStyle>
    <sld:Name>name</sld:Name>
    <sld:Rule>
      <sld:Name>SD Pipe</sld:Name>
      <sld:Title>SD Pipe 1:280K-1:140K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>SD Pipe</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>140000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>280000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ffaf48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.75</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Main Stems</sld:Name>
      <sld:Title>Main Stem 1:280K-1:140K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Main Stem</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>140000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>280000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#fff048</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Tributary</sld:Name>
      <sld:Title>Tributary 1:280K-1:140K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Tributary</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>140000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>280000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#abff48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.25</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Culvert</sld:Name>
      <sld:Title>Culvert 1:280K-1:140K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>*Culv*</ogc:Literal>
        </ogc:PropertyIsLike>
      </ogc:Filter>
      <sld:MinScaleDenominator>140000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>280000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#48ffb8</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.25</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>SD Pipe</sld:Name>
      <sld:Title>SD Pipe 1:140K-1:70K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>SD Pipe</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>70000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>140000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ffaf48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Main Stems</sld:Name>
      <sld:Title>Main Stem 1:140K-1:70K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Main Stem</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>70000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>140000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#fff048</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.75</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Tributary</sld:Name>
      <sld:Title>Tributary 1:140K-1:70K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Tributary</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>70000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>140000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#abff48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Culvert</sld:Name>
      <sld:Title>Culvert 1:140K-1:70K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>*Culv*</ogc:Literal>
        </ogc:PropertyIsLike>
      </ogc:Filter>
      <sld:MinScaleDenominator>70000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>140000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#48ffb8</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Drains</sld:Name>
      <sld:Title>Drains 1:140K-1:70K</sld:Title>
      <sld:ElseFilter/>
      <sld:MinScaleDenominator>70000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>140000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ff4848</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>SD Pipe</sld:Name>
      <sld:Title>SD Pipe 1:70K-1:35K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>SD Pipe</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>35000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>70000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ffaf48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">1.25</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Main Stems</sld:Name>
      <sld:Title>Main Stem 1:70K-1:35K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Main Stem</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>35000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>70000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#fff048</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Tributary</sld:Name>
      <sld:Title>Tributary 1:70K-1:35K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Tributary</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>35000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>70000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#abff48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.75</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Culvert</sld:Name>
      <sld:Title>Culvert 1:70K-1:35K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>*Culv*</ogc:Literal>
        </ogc:PropertyIsLike>
      </ogc:Filter>
      <sld:MinScaleDenominator>35000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>70000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#48ffb8</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.75</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Drains</sld:Name>
      <sld:Title>Drains 1:70K-1:35K</sld:Title>
      <sld:ElseFilter/>
      <sld:MinScaleDenominator>35000.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>70000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ff4848</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">.75</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>SD Pipe</sld:Name>
      <sld:Title>SD Pipe 1:35K-1:17.5K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>SD Pipe</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>17500.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>35000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ffaf48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">1.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Main Stems</sld:Name>
      <sld:Title>Main Stem 1:35K-1:17.5K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Main Stem</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>17500.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>35000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#fff048</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
          <sld:CssParameter name="stroke-width">1.25</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Tributary</sld:Name>
      <sld:Title>Tributary 1:35K-1:17.5K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>Tributary</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MinScaleDenominator>17500.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>35000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#abff48</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Culvert</sld:Name>
      <sld:Title>Culvert 1:35K-1:17.5K</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsLike wildCard="*" singleChar="." escape="!">
          <ogc:PropertyName>descrip</ogc:PropertyName>
          <ogc:Literal>*Culv*</ogc:Literal>
        </ogc:PropertyIsLike>
      </ogc:Filter>
      <sld:MinScaleDenominator>17500.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>35000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#48ffb8</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Drains</sld:Name>
      <sld:Title>Drains 1:35K-1:17.5K</sld:Title>
      <sld:ElseFilter/>
      <sld:MinScaleDenominator>17500.0</sld:MinScaleDenominator>
      <sld:MaxScaleDenominator>35000.0</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#ff4848</sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">.5</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Title>Drains &lt; 3K</sld:Title>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">#41B6C4</sld:CssParameter>
          <sld:CssParameter name="stroke-width">4</sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
  </sld:FeatureTypeStyle>
</sld:UserStyle>
