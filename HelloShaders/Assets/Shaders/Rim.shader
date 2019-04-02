Shader "Custom/Rim" {
    Properties {
        _rimColor ("Rim Color", Color) = (1,1,1,1)
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _rimColor;

        struct Input {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            half rim = 1-dot(normalize(IN.viewDir),o.Normal);
            o.Emission  = _rimColor.rgb * rim;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
