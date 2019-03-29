Shader "Custom/BumpedDiffuseShader" {
    Properties {
     _diffuseTex ("Diffuse Texture", 2D) = "white" {}
        _bumpTex ("Bump Texture", 2D) = "bump" {}
        _bumpAmountSlider ("Bump Amount", Range(0,10)) = 1
        _bright ("Brightness", Range(1,10)) = 1
    }
    SubShader {
        CGPROGRAM
        #pragma surface surf Lambert 

        sampler2D _diffuseTex;
        sampler2D _bumpTex;
        
        half _bumpAmountSlider;
        half _bright;

        struct Input {
             float2 uv_diffuseTex;
            float2 uv_bumpTex;
        };

        void surf (Input IN, inout SurfaceOutput o) {
             o.Albedo = tex2D(_diffuseTex, IN.uv_diffuseTex).rgb*_bright;
            float3 normal= UnpackNormal(tex2D(_bumpTex, IN.uv_bumpTex));
            normal = normal*_bright;
            o.Normal = normal;
                //increase the amount of bumps. Increaing the value of Nx(Normalx) and Ny decides the bumpiness.
                //Nz is towards viewer so changing it won't matter. Additionally when you keep all 3 values same, it won't have any effect
                //because angle between them will remain same.
            o.Normal *= float3(_bumpAmountSlider,_bumpAmountSlider,1);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
