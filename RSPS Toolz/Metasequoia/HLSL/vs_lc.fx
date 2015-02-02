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
	float2 TexCoord : TEXCOORD2;
};

VS_OUTPUT VS(const VS_INPUT In)
{
	VS_OUTPUT Out;
	Out.Pos = mul(In.Pos, WorldViewProj);
	Out.WorldPos = In.Pos;
	Out.Normal = In.Normal;
	Out.TexCoord = In.TexCoord;

	float4 dif_col = float4(0,0,0,0);
	for(int i=0; i<4; i++){
		float3 light_dir = normalize(LightPos[i] - In.Pos);
		float dif_coef = saturate(dot(In.Normal, light_dir));
		dif_col.xyz += LightCol[i] * dif_coef;
	}

	float4 col = Ambient + In.Col * (Emissive + Diffuse * dif_col);
	col.w = In.Col.w;
	Out.Col = saturate(col);

	return Out;
}

