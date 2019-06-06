Shader "Custom/XRay/Black"
{
    Properties
    {
        _OutlineColor ("Outline color", Color) = (0,0,0,1)
        _XRayInside("Inside", Range(0,1) ) = 0
        _XRayRimSize("Rim Size", Range(0,1) ) = 0.50
        _Contrast("Contrast", Range(0,10) ) = 0.50
        _Transparency("Transparency", Range(0.0,1)) = 0.5
    }

    CGINCLUDE
    #include "UnityCG.cginc"

    struct appdata
    {
        float4 vertex : POSITION;
        float4 color : COLOR;
        half3 normal : NORMAL;
    };

    struct v2f
    {
        float4 pos : POSITION;
        float4 color : COLOR;
        half3 normal : NORMAL;
    };

    float4 _OutlineColor;
    
    float _Transparency;
    
    half _XRayInside;
    half _XRayRimSize;
    half _Contrast;

    ENDCG

    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha


        Pass //Outline
        {
            ZWrite Off
            Cull Back
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag

            v2f vert(appdata v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.color = _OutlineColor;
                o.normal = v.normal;
                return o;

            }

            half4 frag(v2f i) : COLOR
            {
            float3 uv = normalize(mul((float3x3)UNITY_MATRIX_IT_MV, i.normal));
            
            //half rF = 5.5;

            fixed4 colorOut = lerp(half4(0,0,0,0), half4(0.5,0.5,0.5,0), _XRayInside);
            colorOut.rgb = lerp(colorOut.rgb,_OutlineColor, _Contrast * saturate(1- pow(uv.z, _XRayRimSize)));
            
            //fixed4 col = _OutlineColor;
            colorOut.a = _Transparency;
            return colorOut;
            }

            ENDCG
        }

        //Tags{ "Queue" = "Geometry"}
         //Tags {"Queue" = "Transparent" "RenderType"="Transparent" }

        //CGPROGRAM
        ////#pragma surface surf Lambert
        // #pragma surface surf Lambert alpha

        //        struct Input {
        //    float2 uv_MainTex;
        //};
         
        //void surf (Input IN, inout SurfaceOutput o) {
        //    //fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
        //    //o.Albedo = c.rgb;
        //    //o.Alpha = c.a;
        //}
        //ENDCG
    }
    Fallback "Diffuse"
}