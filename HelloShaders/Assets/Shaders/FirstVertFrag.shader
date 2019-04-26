Shader "Custom/FirstVertFrag"
{
    Properties
    {
        //_MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 100

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
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            //sampler2D _MainTex;
            //float4 _MainTex_ST;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //set color in world space
                //o.color.r = (v.vertex.x + 10)/20;
                //o.color.g = (v.vertex.z + 10)/20;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                //fixed4 col = fixed4(0,1,0,1);
                fixed4 col;
                //set color in screen space, eg screen size 1920*1080
                col.r = (i.vertex.x/1920);
                col.g = (i.vertex.y/1080);
                return col;
            }
            ENDCG
        }
    }
}
