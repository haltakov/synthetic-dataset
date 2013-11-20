varying vec2 tu0coord;
uniform sampler2D tu0_2D;

/*float w0(float a)
{
	return (1.0/6.0)*(-a*a*a+3.0*a*a-3.0*a+1.0);
}

float w1(float a)
{
	return (1.0/6.0)*(3.0*a*a*a-6.0*a*a+4.0);
}

float w2(float a)
{
	return (1.0/6.0)*(-3.0*a*a*a+3.0*a*a+3.0*a+1.0);
}

float w3(float a)
{
	return (1.0/6.0)*(a*a*a);
}

vec4 hglookup(float x)
{
	float g0 = w0(x) + w1(x);
	float g1 = w2(x) + w3(x);
	float h0 = 1.0 - w1(x)/(w0(x)+w1(x))+x;
	float h1 = 1.0 + w3(x)/(w2(x)+w3(x))-x;
	
	return vec4(h0,h1,g0,g1);
}

vec4 bicubic_filter(sampler2D tex_source, vec2 coord_source)
{
	//texel sizes
	vec2 e_x = vec2(dFdx(coord_source.x),0.0);
	vec2 e_y = vec2(0.0,dFdy(coord_source.y));
	
	//vec2 coord_hg = coord_source*256.0 - vec2(0.5,0.5);
	vec2 coord_hg = coord_source;
	
	//fetch offsets and weights
	vec3 hg_x = hglookup(coord_hg.x).rgb;
	vec3 hg_y = hglookup(coord_hg.y).rgb;
	
	//determine sampling coordinates
	vec2 coord_source10 = coord_source + hg_x.x*e_x;
	vec2 coord_source00 = coord_source - hg_x.y*e_x;
	vec2 coord_source11 = coord_source10 + hg_y.x*e_y;
	vec2 coord_source01 = coord_source00 + hg_y.x*e_y;
	coord_source10 = coord_source10 - hg_y.y*e_y;
	coord_source00 = coord_source00 - hg_y.y*e_y;
	
	//fetch four linearly interpolated inputs
	vec4 tex_source00 = texture2D(tex_source, coord_source00);
	vec4 tex_source10 = texture2D(tex_source, coord_source10);
	vec4 tex_source01 = texture2D(tex_source, coord_source01);
	vec4 tex_source11 = texture2D(tex_source, coord_source11);
	
	//weight along y direction
	tex_source00 = mix(tex_source00, tex_source01, hg_y.z);
	tex_source10 = mix(tex_source10, tex_source11, hg_y.z);
	
	//weight along x direction
	tex_source00 = mix(tex_source00, tex_source10, hg_x.z);
	
	return tex_source00;
}*/

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
	// Setting Each Pixel To Red
	//gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
	
	//vec4 incol = texture2D(tu0_2D, tu0coord);
	//vec4 outcol = 1.0/(1.0+pow(2.718,-(incol*6.0-3.0)));
	
	vec4 outcol = texture2D(tu0_2D, tu0coord);
	#ifdef _GAMMA_
	outcol.rgb = GammaCorrect(outcol.rgb);
	#endif
	
	vec4 glcolor = gl_Color;
	
	#ifdef _CARPAINT_
	outcol.rgb = mix(glcolor.rgb, outcol.rgb, outcol.a); // albedo is mixed from diffuse and object color
	outcol.a = 1;
	glcolor.rgb = vec3(1.,1.,1.);
	#endif
	
	vec4 finalcol = outcol * glcolor;
	
	#ifdef _PREMULTIPLY_ALPHA_
	// pre-multiply alpha
	finalcol.rgb *= finalcol.a;
	#endif
	
    gl_FragColor = finalcol;
	//gl_FragColor = vec4(outcol.rgb*gl_Color.rgb*outcol.a*gl_Color.a,outcol.a*gl_Color.a);
    //gl_FragColor = vec4(outcol.rgb*gl_Color.rgb*gl_Color.a,outcol.a*gl_Color.a);
	//gl_FragColor = bicubic_filter(tu0_2D, tu0coord)*gl_Color;
	
	//gl_FragColor.rg = tu0coord*0.5+0.5;
	//gl_FragColor.ba = vec2(1.0);
}
