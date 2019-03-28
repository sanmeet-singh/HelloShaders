Shader "Custom/HelloSurfaceShader" {
     Properties {
        _myColor ("Color", Color) = (1,1,1,1)
        _myEmissionColorRange ("Emission Color", Color) = (1,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        fixed4 _myEmissionColorRange;
        
        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _myColor.rgb;
            o.Emission = _myEmissionColorRange.rgb;
        }
      
      ENDCG
    }
    FallBack "Diffuse"
}
