Shader "Custom/BasicSpecularPBR" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic Tex", 2D) = "White" {}
        _SpecColor ("Spec Color", Color) = (1,1,1,1)
    }
    SubShader {
        
        CGPROGRAM
        #pragma surface surf StandardSpecular

        struct Input {
            float2 uv_MetallicTex;
        };

        fixed4 _Color;
        sampler2D _MetallicTex;
        half _Metallic;

        void surf (Input IN, inout SurfaceOutputStandardSpecular o) {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex,IN.uv_MetallicTex).b;
            o.Specular = _SpecColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
