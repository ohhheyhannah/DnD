float4x4 WorldViewProj : WORLDVIEWPROJ;
float4 BaseColor;

struct VS_INPUT
{
	float4 Pos : POSITION;
	float4 Tangent : TANGENT;
	float3 Normal : NORMAL;
	float2 TexCoord : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
	float2 TexCoord : TEXCOORD0;
	float3 Normal : TEXCOORD1;
	float3 Tangent : TEXCOORD2;
	float3 Binormal : TEXCOORD3;
};

VS_OUTPUT VS(const VS_INPUT In)
{
	VS_OUTPUT Out;
	Out.Pos = mul(In.Pos, WorldViewProj);
	Out.Col = BaseColor;
	Out.Normal = In.Normal;
	Out.TexCoord = In.TexCoord;
	Out.Tangent = In.Tangent.xyz;
	Out.Binormal = normalize(cross(In.Tangent.xyz, In.Normal)) * In.Tangent.w;
	return Out;
}

