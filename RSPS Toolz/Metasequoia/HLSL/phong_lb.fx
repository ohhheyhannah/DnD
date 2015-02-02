float4 BaseColor;
float Diffuse;
float4 Ambient;
float4 Specular;
float SpecularPower;
float Emissive;
float3 LightPos[8];
float3 LightCol[8];
float3 LightSpc[8];
float3 ViewDir;
texture ColorMap;
texture AlphaMap;
texture BumpMap;

sampler ColorMapSampler = sampler_state
{
	Texture = <ColorMap>;
};

sampler AlphaMapSampler = sampler_state
{
	Texture = <AlphaMap>;
};

sampler BumpMapSampler = sampler_state
{
	Texture = <BumpMap>;
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

// phong without texture
float4 PS(VS_OUTPUT In) : COLOR0
{
	float3 bump_col = tex2D(BumpMapSampler, In.TexCoord).xyz * 2.0f - 1.0f;
	bump_col.y = -bump_col.y;

	float3x3 mtx = {In.Tangent, In.Binormal, In.Normal};
	float3 Norm = normalize(mul(bump_col, mtx));
	float3 Norm2 = Norm * 2;
	float3 dif_col = float3(0,0,0);
	float3 spc_col = float3(0,0,0);

	for(int i=0; i<3; i++){
		float3 light_dir = normalize(LightPos[i] - In.WorldPos);
		float dif_coef = dot(Norm, light_dir);

		dif_col += LightCol[i] * saturate(dif_coef);

		float3 Reflect = normalize(dif_coef * Norm2 - light_dir);
		spc_col += LightSpc[i] * pow(saturate(dot(Reflect, ViewDir)), SpecularPower);
	}

	float4 tex_col = tex2D(ColorMapSampler, In.TexCoord);
	float4 alpha_col = tex2D(AlphaMapSampler, In.TexCoord);
	float3 col = Ambient.xyz + In.Col.xyz * tex_col.xyz * (Emissive + Diffuse * saturate(dif_col)) + Specular.xyz * spc_col;
	return saturate(float4(col, In.Col.w * tex_col.w * alpha_col.w));
}

