varying vec4 color;

uniform sampler2D tu0_2D;
varying vec2 texcoord;

void main()
{
	vec4 tu0color = texture2D(tu0_2D, texcoord);
	
	if (tu0color.a < 0.001 )
		discard;
	
	gl_FragColor = vec4(color[0], color[1], color[2], color[3]);
}