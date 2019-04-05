Shader "Custom/BlendingTextures" {
	Properties {
		_MainTex ("Texture", 2D) = "white" {}
        _Decal ("Decal", 2D) = "white" {}
        [Toggle] _ShowDecal("Show Decal",Float)=0
	}
	SubShader {
		Tags { "RenderType"="Geometry" }

		CGPROGRAM
		#pragma surface surf Lambert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
        sampler2D _Decal;
        float _ShowDecal;

		struct Input {
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			fixed4 color = tex2D (_MainTex, IN.uv_MainTex)  ;
            fixed4 decalColor = tex2D (_Decal, IN.uv_MainTex)* _ShowDecal;
            o.Albedo = color.rgb + decalColor.rgb;
            //o.Albedo = decalColor.r > 0.5? decalColor.rgb :  color.rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
