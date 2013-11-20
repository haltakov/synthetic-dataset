varying vec4 old_pos;
varying vec4 new_pos;

uniform sampler2D tu0_2D;
varying vec2 texcoord;



void main()
{
	vec4 tu0color = texture2D(tu0_2D, texcoord);
	if (tu0color.a < 0.001 )
		discard;
	
	double dx = old_pos.x/old_pos.w - new_pos.x/new_pos.w;
	double dy = old_pos.y/old_pos.w - new_pos.y/new_pos.w;

	double dd = dx * 320;
	
	int d_max = 300;
	int factor = 10000;
	int d = int((dd + d_max) * 10000);
	
	int r =  d & 0x000000FF;
	int g = (d & 0x0000FF00) >> 8;
	int b = (d & 0x00FF0000) >> 16;
	
	float rr = pow(float(r) / 256.0f, 2.2);
	float gg = pow(float(g) / 256.0f, 2.2);
	float bb = pow(float(b) / 256.0f, 2.2);
	
	gl_FragColor = vec4(rr, gg, bb, 1.0);
}