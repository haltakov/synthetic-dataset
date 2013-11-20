varying vec2 tu0coord;
uniform sampler2D tu0_2D;

void main()
{
	vec4 texcolor = texture2D(tu0_2D, tu0coord);
	texcolor.rgb *= gl_Color.rgb;
	float distanceFactor = texcolor.a;
	
	//anti-aliasing
	float width = dFdx(tu0coord.x) * 70.0;
	texcolor.a = smoothstep(0.5-width, 0.5+width, texcolor.a);
	
	/*//outline calculation
	const vec4 outlineColour = vec4(0, 0, 1, 1);
	const float OUTLINE_MIN_0 = 0.4;
	const float OUTLINE_MIN_1 = OUTLINE_MIN_0 + width * 2.0;
	const float OUTLINE_MAX_0 = 0.5;
	const float OUTLINE_MAX_1 = OUTLINE_MAX_0 + width * 2.0;
	if (distanceFactor > OUTLINE_MIN_0 && distanceFactor < OUTLINE_MAX_1)
	{
		float outlineAlpha;
		if (distanceFactor < OUTLINE_MIN_1)
			outlineAlpha = smoothstep(OUTLINE_MIN_0, OUTLINE_MIN_1, distanceFactor);
		else
			outlineAlpha = smoothstep(OUTLINE_MAX_1, OUTLINE_MAX_0, distanceFactor);
			
		texcolor = mix(texcolor, outlineColour, outlineAlpha);
	}*/
	
	/*//shadow / glow calculation
	const vec2 GLOW_UV_OFFSET = vec2(-0.004, -0.004);
	const vec3 glowColour = vec3(0, 0, 0);
	float glowDistance = texture2D(tu0_2D, tu0coord + GLOW_UV_OFFSET).a;
	float glowFactor = smoothstep(0.3, 0.5, glowDistance);
	texcolor = mix(vec4(glowColour, glowFactor), texcolor, texcolor.a);*/
	
	float glowFactor = smoothstep(0.0, 1.0, distanceFactor);
	texcolor = mix(vec4(0.0, 0.0, 0.0, glowFactor), texcolor, texcolor.a);
	
	texcolor.a *= gl_Color.a;
	
	gl_FragColor = vec4(texcolor.rgb,texcolor.a);
    //gl_FragColor = vec4(texcolor.rgb*gl_Color.a,texcolor.a);
    //gl_FragColor = vec4(texcolor.rgb*texcolor.a,texcolor.a);
	
	//gl_FragColor = texture2D(tu0_2D, tu0coord);
	
	//gl_FragColor.rg = tu0coord*0.5+0.5;
	//gl_FragColor.ba = vec2(1.0);
}
