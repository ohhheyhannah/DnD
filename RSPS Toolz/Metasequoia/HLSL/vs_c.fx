float4x4 WorldViewProj : WORLDVIEWPROJ;
float4 BaseColor;

struct VS_INPUT
{
	float4 Pos : POSITION;
	float3 Normal : NORMAL;
	float4 Col : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
	float3 Normal : TEXCOORD0;
	float2 TexCoord : TEXCOORD1;
};

VS_OUTPUT VS(const VS_INPUT In)
{
	VS_OUTPUT Out;
	Out.Pos = mul(In.Pos, WorldViewProj);
	Out.Col.xyz = In.Col.xyz;	//RGB
	Out.Col.w = BaseColor.w * In.Col.w;
	Out.Normal = In.Normal;
	Out.TexCoord = In.TexCoord;
	return Out;
}

