varying vec2 tu0coord;

uniform sampler2D tu0_2D;
#ifdef _WITH_COLOR_
uniform sampler2D tu1_2D;
#endif

#ifdef _GAMMA_
#define GAMMA 2.2
vec3 UnGammaCorrect(vec3 color)
{
	return pow(color, vec3(1.0/GAMMA,1.0/GAMMA,1.0/GAMMA));
}
vec3 GammaCorrect(vec3 color)
{
	return pow(color, vec3(GAMMA,GAMMA,GAMMA));
}
#undef GAMMA
#endif

void main()
{
	float gbuf_depth = texture2D(tu0_2D, tu0coord).r;
	
	#ifdef _COPY_COLOR_IF_DEPTH_
		if (gbuf_depth < 1)
			gl_FragColor = texture2D(tu1_2D, tu0coord);
		else
			discard;
	#else
	
		#ifdef _WITH_COLOR_
		gl_FragColor = texture2D(tu1_2D, tu0coord);
		
		// simple tonemap for now
		gl_FragColor.rgb = 1.58*(vec3(1.)-exp(-gl_FragColor.rgb*1.));
		#ifdef _GAMMA_
		gl_FragColor.rgb = UnGammaCorrect(gl_FragColor.rgb);
		#endif
		#else
		gl_FragColor = vec4(1,1,1,1);
		#endif
		
		#ifdef _DEPTH_TO_ONE_
		gl_FragDepth = (gbuf_depth < 1) ? 0.0 : 1.0;
		#else
		gl_FragDepth = gbuf_depth;
		#endif
	
	#endif
}
