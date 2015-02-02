float4x4 WorldViewProj : WORLDVIEWPROJ;
float4 BaseColor;
float Diffuse;
float4 Ambient;
float Emissive;
float3 LightPos[8];
float3 LightCol[8];

struct VS_INPUT
{
	float4 Pos : POSITION;
	float4 Tangent : TANGENT;
	float3 Normal : NORMAL;
	float4 Col : COLOR0;
	float2 TexCoord : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
	float3 WorldPos : TEXCOORD0;
	float3 Normal : TEXCOORD1;
	float3 Tangent : TEXCOORD2;
	float3 Binormal : TEXCOORD3;
	float2 TexCoord : TEXCOORD4;
};

VS_OUTPUT VS(const VS_INPUT In)
{
	VS_OUTPUT Out;
	Out.Pos = mul(In.Pos, WorldViewProj);
	Out.WorldPos = In.Pos.xyz;
	Out.Normal = In.Normal;
	Out.Tangent = In.Tangent.xyz;
	Out.Binormal = normalize(cross(In.Tangent.xyz, In.Normal)) * In.Tangent.w;
	Out.TexCoord = In.TexCoord;
	Out.Col.xyz = In.Col.xyz;	//RGB
	Out.Col.w = BaseColor.w * In.Col.w;
	return Out;
}

