varying float z;

uniform sampler2D tu0_2D;
varying vec2 texcoord;

void main()
{
	vec4 tu0color = texture2D(tu0_2D, texcoord);
	
	if (tu0color.a < 0.001 )
		discard;
		
//	float b = 1;
//	float f = 2.414213562373094;
	float s = 1.5;
	
//	float d = ((s * 400.0*f*b)/(-z));

	float d = s * 400.0 * 1.0/-z;
	
	// correct for gamma 2.2
	d = d / 255.0;
	d = pow(d, 2.2);
	
	gl_FragColor = vec4(d, d, d, 1.0);
}