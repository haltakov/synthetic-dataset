varying vec2 tu0coord;
uniform sampler2D tu0_2D;

void main()
{
	vec4 outcol = texture2D(tu0_2D, tu0coord);
	
    gl_FragColor = vec4(outcol.rgb*gl_Color.rgb,outcol.a);
}
