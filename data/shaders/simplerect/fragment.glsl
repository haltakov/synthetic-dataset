#extension GL_ARB_texture_rectangle : enable

varying vec2 tu0coord;
uniform sampler2DRect tu0_2DRect;

void main()
{
	// Setting Each Pixel To Red
	//gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
	
	gl_FragColor = texture2DRect(tu0_2DRect, tu0coord)*gl_Color;
}
