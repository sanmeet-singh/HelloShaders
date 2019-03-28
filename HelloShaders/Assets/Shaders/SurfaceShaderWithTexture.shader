Shader "Custom/SurfaceShaderWithTexture" {
     Properties {
        _myColor ("Color", Color) = (1,1,1,1)
       _myRange ("Color Range", Range(1,5)) = 1
        _myTex ("Texture", 2D) = "white" {}
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        half _myRange;
        sampler2D _myTex;

        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = (tex2D(_myTex, IN.uv_myTex) * _myRange * _myColor).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
