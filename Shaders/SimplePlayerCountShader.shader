Shader "SimplePlayerCount/SimplePlayerCountShader"
{
    Properties
    {
        _DigitCount("Digit Count", int) = 2
        [MaterialToggle] _ZeroFill("Zero Fill", float) = 0
        _Color("Color", Color) = (1, 1, 1, 1)
        _BackgroundColor("Background Color", Color) = (0, 0, 0, 1)
        [Space]
        [NoScaleOffset] _MainTex ("Texture", 2D) = "black" {}
        _TexSizeX("Tex Size X", int) = 32
        _TexSizeY("Tex Size Y", int) = 32
        _UseSizeX("Use Region X", int) = 31
        _UseSizeY("Use Region Y", int) = 14
        _Col("Column Count", int) = 6
        _Row("Row Count", int) = 2
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
            
            #include "SimplePlayerCountShader.cginc"
            float _Udon_SimpleUserCountShader_Count;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return drawCount(countUV(i.uv, (uint) _Udon_SimpleUserCountShader_Count));
            }
            ENDCG
        }
    }
}
