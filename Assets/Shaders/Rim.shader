Shader "Custom/Rim" {
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
            o.Emission  = _rimColor.rgb * pow(rim,_rimPower);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
