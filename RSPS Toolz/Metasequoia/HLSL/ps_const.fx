struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 Col : COLOR0;
};

// constant color
float4 PS(VS_OUTPUT In) : COLOR0
{
	return In.Col;
}

