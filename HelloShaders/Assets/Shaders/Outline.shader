Shader "Custom/Outline"
{
     Properties
    {
        _MainTex ("Main Tex ", 2D) = "white" {}
        _OutlineColor ("Outline Color",Color) = (0,0,0,1)
        _OutlineWidth ("Outline Width",Range(0.002,0.1)) = 0.005
    }
    SubShader
    {
    ZWrite off
    CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        
        float _OutlineWidth;
        
        float4 _OutlineColor;
        

        struct Input
        {
            float2 uv_MainTex;
        };
        
        struct appdata {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;
            };
            
            void vert (inout appdata_full v)
            {
            v.vertex.xyz += v.normal * _OutlineWidth;
            }

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Emission = _OutlineColor.rgb;
        }
        ENDCG
    
    ZWrite on
        CGPROGRAM
        #pragma surface surf Lambert 

        sampler2D _MainTex;
        
        float _Amount;

        struct Input
        {
            float2 uv_MainTex;
        };
        
        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D (_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
