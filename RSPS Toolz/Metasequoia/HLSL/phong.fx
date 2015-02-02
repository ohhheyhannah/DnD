float4 BaseColor;
float Diffuse;
float4 Ambient;
float4 Specular;
float SpecularPower;
float Emissive;
float3 LightDir;
float3 ViewDir;

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Color : COLOR0;
	float3 Normal : TEXCOORD0;
};

// phong without texture
float4 PS(VS_OUTPUT In) : COLOR0
{
	float3 Norm = normalize(In.Normal);
	float dif_coef = dot(Norm, LightDir);

	float3 Reflect = normalize(2 * dif_coef * Norm - LightDir);
	float spc_coef = pow(saturate(dot(Reflect, ViewDir)), SpecularPower);

	float4 col = Ambient + In.Color * (Emissive + Diffuse * saturate(dif_coef)) + Specular * spc_coef;
	col.w = In.Color.w;
	return saturate(col);
}

