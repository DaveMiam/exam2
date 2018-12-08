Shader "Custom/LavaShader" {
	Properties {
		_LavaTexture ("Texture de lave", 2D) = "white" {}
		_RockTexture ("Texture de roche", 2D) = "white" {}
		_DispTexture("Texture de disp", 2D) = "white" {}
		_Displacement ("Displacement", Range(0,1)) = 0.5
		
	 _ScrollXSpeed("X", Range(0,10)) = 2
	 _ScrollYSpeed("Y", Range(0,10)) = 3
	} 



	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200

		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert
			
			
			

				
			
		

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _LavaTexture;
		sampler2D _RockTexture;
		sampler2D _DispTexture;


		struct Input {
			float2 uv_MainTex;
			float2 uv_LavaTexture;
			float2 uv_RockTexture;
			float2 uv_DispTexture;
			
		};



		struct appdata {
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float2 texcoord : TEXCOORD0;

		};

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;
		float _Displacement;
		fixed _ScrollXSpeed;
		fixed _ScrollYSpeed;

		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
		// #pragma instancing_options assumeuniformscaling
		UNITY_INSTANCING_BUFFER_START(Props)
			// put more per-instance properties here
		UNITY_INSTANCING_BUFFER_END(Props)

			void vert(inout appdata v) {
			float d = tex2Dlod(_DispTexture, float4(v.texcoord.xy, 0, 0)).r * _Displacement;
			v.vertex.xyz -= v.normal *d;
		}
		
		

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed2 scrolledUV = IN.uv_LavaTexture;

			fixed xScrollValue = _ScrollXSpeed * _Time;
			fixed yScrollValue = _ScrollYSpeed * _Time;

			scrolledUV += fixed2(xScrollValue, yScrollValue);
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_LavaTexture, scrolledUV) - 2* tex2D(_RockTexture, IN.uv_RockTexture) ;

			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;

		}

		
		ENDCG


			


	}
	FallBack "Diffuse"
}
