varying float z;

uniform sampler2D tu0_2D;
varying vec2 texcoord;

void main()
{
	vec4 tu0color = texture2D(tu0_2D, texcoord);
	if (tu0color.a < 0.001 )
		discard;
		
	float z_max = 2000;
	float z_norm = (z > z_max ? z_max : z) / z_max;

	int d = int((256 * 256 * 256) * z_norm);
	
	int r =  d & 0x000000FF;
	int g = (d & 0x0000FF00) >> 8;
	int b = (d & 0x00FF0000) >> 16;
	
	float rr = pow(float(r) / 255.0f, 2.2);
	float gg = pow(float(g) / 255.0f, 2.2);
	float bb = pow(float(b) / 255.0f, 2.2);
	
	gl_FragColor = vec4(rr, gg, bb, 1.0);
}