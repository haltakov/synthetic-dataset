varying vec2 tu0coord;

uniform sampler2D tu0_2D;

const vec3 LUMINANCE = vec3(0.2125, 0.7154, 0.0721);
const float DELTA = 0.0001;

/*const float scale = 0.1;
const float offset = 5.;
const float timefactor = 0.1;
const float scale_tiny = 3.0;
const float offset_tiny = -0.12;*/

const float scale = 0.25;
const float offset = 2.0;
const float timefactor = 0.1;
//const float timefactor = 1.0;

void main()
{
	#ifdef _TINY_
	float lod = 9;
	//gl_FragColor.rgb = vec3(1.,1.,1.)*(texture2DLod(tu0_2D, tu0coord, lod).r+offset_tiny)*scale_tiny;
	gl_FragColor.rgb = vec3(1.,1.,1.)*texture2DLod(tu0_2D, tu0coord, lod).r;
	gl_FragColor.a = timefactor;
	#else
	float luminance = dot(LUMINANCE,texture2D(tu0_2D, tu0coord).rgb);
	float logluminance = log(luminance+DELTA);
	gl_FragColor.rgb = vec3(1.,1.,1.)*(logluminance+offset)*scale;
	#endif
}
