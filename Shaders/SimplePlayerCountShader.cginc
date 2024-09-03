float _DigitCount;
float _ZeroFill;
float4 _Color;
float4 _BackgroundColor;
sampler2D _MainTex;
float4 _MainTex_ST;
float _TexSizeX;
float _TexSizeY;
float _UseSizeX;
float _UseSizeY;
float _Col;
float _Row;
            
#include "../../net.narazaka.unity.tiled-number-shader/TiledNumber.cginc"

float2 countUV(float2 uv, uint count)
{
    uint digitCount = (uint) _DigitCount;
    float columnCount = (float) (digitCount + 1);
    float2 numberUV = TiledNumber_placeTileUV(
                    uv,
                    float2(digitCount / columnCount, 1),
                    float2(0, 0),
                    float2(_UseSizeX / _TexSizeX, _UseSizeY / _TexSizeY),
                    float2(0, 1 - _UseSizeY / _TexSizeY),
                    count,
                    (uint) _Col,
                    (uint) _Row,
                    false,
                    digitCount,
                    _ZeroFill > 0.5
                );
    float2 unitUV = TiledNumber_placeTileUV(
                    uv,
                    float2(1 / columnCount, 1),
                    float2(digitCount / columnCount, 0),
                    float2(_UseSizeX / _TexSizeX, _UseSizeY / _TexSizeY),
                    float2(0, 1 - _UseSizeY / _TexSizeY),
                    11,
                    (uint) _Col,
                    (uint) _Row,
                    false
                );
    return lerp(numberUV, unitUV, uv.x * columnCount >= (int) digitCount);
}

fixed4 drawCount(float2 uv)
{
    fixed4 c = tex2D(_MainTex, uv);
    return lerp(_BackgroundColor, _Color, c.r);
}
