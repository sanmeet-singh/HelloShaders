Shader "Custom/Hologram" {
    Properties {
        _RimColor ("Color", Color) = (0,0.5,0.5,0)
        _RimPower ("Rim power",Range(1 ,5)) = 1
    }
    SubShader {
    Tags{
    "Queue" = "Transparent"
    }
    //Pass - Pass is a draw call.
    Pass{
    //we are using this pass to neglect the inner of any model.
    ZWrite On
    ColorMask 0 
    //change this to see what is being written into Z buffer
    //ColorMask RGB 
    }

        CGPROGRAM
        #pragma surface surf Lambert alpha:fade

        struct Input {
            float3 viewDir;
        };

        float4 _RimColor;
        float _RimPower;

        void surf (Input IN, inout SurfaceOutput o) {
        //saturate will keep the value between 0 to 1.
        half rim = 1- saturate(dot((normalize(IN.viewDir)),o.Normal));
        o.Emission = _RimColor.rgb* pow(rim,_RimPower);
        o.Alpha = pow(rim,_RimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
