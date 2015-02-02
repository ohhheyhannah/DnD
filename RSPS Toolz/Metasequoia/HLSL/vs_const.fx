float4x4 WorldViewProj : WORLDVIEWPROJ;

struct VS_INPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
};

VS_OUTPUT VS(const VS_INPUT In)
{
	VS_OUTPUT Out;
	Out.Pos = mul(In.Pos, WorldViewProj);
	Out.Col = In.Col;
	return Out;
}

