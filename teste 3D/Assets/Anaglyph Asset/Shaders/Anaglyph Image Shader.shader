Shader "Hidden/Anaglyph Image Shader"
{
    Properties
    {
        _MainTex ("FirstEyeTex(Red)", 2D) = "white" {}
        _MainTex2 ("SecondEyeTex(Blue)", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            sampler2D _MainTex2;

            fixed4 frag (v2f i) : SV_Target
            {
                /*fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
                */

                 fixed4 c = tex2D(_MainTex, i.uv);
                fixed4 c2 = tex2D(_MainTex2, i.uv);
                fixed4 cFinal;
                // just invert the colors
                cFinal.r = (c.r + c.g)/2;
                cFinal.g = 0;
                cFinal.b = (c2.b + c2.g)/2;
                return cFinal;
            }
            ENDCG
        }
    }
}
