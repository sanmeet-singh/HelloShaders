Shader "Custom/HelloSurfaceShader" {
     Properties {
        _myColor ("Color", Color) = (1,1,1,1)
        _myRange ("Range", Range(0,5)) = 1
        _myTex ("Texture", 2D) = "white" {}
        _myCube ("Cube", CUBE) = "" {}
        _myFloat ("Float", Float) = 0.5
        _myVector ("Vector", Vector) = (0.5,1,1,1)
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _myColor;
        
        half _myRange;
        
        sampler2D _myTex;
        samplerCUBE _myCube;
        
        float _myFloat;
        float4 _myVector;

        struct Input {
            float2 uv_myTex;
            float3 worldRefl;
        };
        
        void surf (Input IN, inout SurfaceOutput o) {
        //o.Albedo = (tex2D(_myTex, IN.uv_myTex)*_myRange*_myColor).rgb;
        //o.Albedo = (tex2D(_myTex, IN.uv_myTex)).rgb;
        //o.Albedo.b=1;
            //o.Emission = (texCUBE (_myCube, IN.worldRefl)*_myRange).rgb;
            o.Albedo = _myColor.rgb;
        }
      
      ENDCG
    }
    FallBack "Diffuse"
}
