Shader "Custom/RimWithLogicalCutOff" {
    Properties {
        _rimColor ("Rim Color", Color) = (1,1,1,1)
        _rimPower ("RIm Power", Range(1,5)) = 1
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert
        
        fixed4 _rimColor;
        
        half _rimPower;

        struct Input {
            float3 viewDir;
        };

        void surf (Input IN, inout SurfaceOutput o) {
        //saturate will keep dot product result in between 0 and 1;
            half rim = 1-saturate(dot(normalize(IN.viewDir),o.Normal));
            //Logical cut off
            //rim = rim > 0.9 ? rim : 0;
            //o.Emission  = _rimColor.rgb * rim;
            //multicolor
            o.Emission  = rim > 0.7 ? float3(1,0,0):rim > 0.4 ? float3(0,1,0) : float3(0,0,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
