float4 BaseColor;
float Diffuse;
float4 Ambient;
float4 Specular;
float SpecularPower;
float Emissive;
float3 LightDir;
float3 ViewDir;
texture ColorMap;
texture AlphaMap;

sampler ColorMapSampler = sampler_state
{
	Texture = <ColorMap>;
};

sampler AlphaMapSampler = sampler_state
{
	Texture = <AlphaMap>;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Color : COLOR0;
	float3 Normal : TEXCOORD0;
	float2 TexCoord : TEXCOORD1;
};

// blinn with texture
float4 PS(VS_OUTPUT In) : COLOR0
{
	float4 tex_col = tex2D(ColorMapSampler, In.TexCoord);
	float4 alpha_col = tex2D(AlphaMapSampler, In.TexCoord);
	float3 Norm = normalize(In.Normal);
	float dif_coef = dot(Norm, LightDir);

	float3 Reflect = normalize(ViewDir + LightDir);
	float spc_coef = pow(saturate(dot(Reflect, Norm)), SpecularPower);

	float4 col = Ambient + tex_col * In.Color * (Emissive + Diffuse * saturate(dif_coef)) + Specular * spc_coef;
	col.w = tex_col.w * alpha_col.w * In.Color.w;
	return saturate(col);
}

