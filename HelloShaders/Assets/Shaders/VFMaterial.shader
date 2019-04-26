﻿Shader "Custom/VFMaterial"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _ScaleUVX ("Scale UV X",Range(1,10))=1
        _ScaleUVY ("Scale UV Y",Range(1,10))=1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        LOD 100
        
        GrabPass{
        }
        
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            //#pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                //UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };
            
            //Grab pass is used to get current screen pixels.
            sampler2D _GrabTexture;
            sampler2D _MainTex;
            float4 _MainTex_ST;
            
            float _ScaleUVX;
            float _ScaleUVY;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.uv.x  = sin(o.uv.x * _ScaleUVX);
                o.uv.y  = cos(o.uv.y * _ScaleUVY);
                //UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 col = tex2D(_GrabTexture, i.uv);
                // apply fog
                //UNITY_APPLY_FOG(i.fogCoord, col);
                return col;
            }
            ENDCG
        }
    }
}
