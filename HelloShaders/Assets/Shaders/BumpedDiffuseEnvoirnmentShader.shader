Shader "Custom/BumpEnvoirnment" {
    Properties {
        _MainTex ("Main Tex", 2D) = "white" {}
        _BumpTex ("Bump Tex", 2D) = "white" {}
        _BumpAmount ("Bump Amount", Range(1,5)) = 1
        _EnvoirnmentAmount ("Envoirnment Amount", Range(0.1,1)) = 0.1
        _Brightness ("Brightness", Range(1,10)) = 1
        _Cube ("Cube Map", Cube) = "white" {}
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _MainTex;
        sampler2D _BumpTex;
        
        samplerCUBE _Cube;
        
        half _BumpAmount;
        half _Brightness;
        half _EnvoirnmentAmount;

        struct Input {
            float2 uv_MainTex;
            float2 uv_BumpTex;
            float3 worldRefl; INTERNAL_DATA
        };

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb*_Brightness;
            o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_BumpTex));
            o.Normal *= float3(_BumpAmount,_BumpAmount,1);
            o.Emission = texCUBE(_Cube,WorldReflectionVector(IN,o.Normal)).rgb;
            o.Emission  *= float3(_EnvoirnmentAmount,_EnvoirnmentAmount,_EnvoirnmentAmount);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
