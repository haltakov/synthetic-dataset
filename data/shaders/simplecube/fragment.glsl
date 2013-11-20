varying vec3 tu0coord;
uniform samplerCube tu0_cube;

void main()
{
	// Setting Each Pixel To Red
	//gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
	
	//vec4 incol = texture2D(tu0_2D, tu0coord);
	//vec4 outcol = 1.0/(1.0+pow(2.718,-(incol*6.0-3.0)));
	
	vec4 outcol = textureCube(tu0_cube, tu0coord);
	
    gl_FragColor = vec4(outcol.rgb*gl_Color.rgb,outcol.a*gl_Color.a);
	//gl_FragColor = vec4(outcol.rgb*gl_Color.rgb*outcol.a*gl_Color.a,outcol.a*gl_Color.a);
    //gl_FragColor = vec4(outcol.rgb*gl_Color.rgb*gl_Color.a,outcol.a*gl_Color.a);
	//gl_FragColor = bicubic_filter(tu0_2D, tu0coord)*gl_Color;
	
	//gl_FragColor.rg = tu0coord*0.5+0.5;
	//gl_FragColor.ba = vec2(1.0);
	
	//gl_FragColor = vec4(tu0coord.r, tu0coord.g, tu0coord.b, 1);
}
