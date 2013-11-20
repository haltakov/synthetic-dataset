varying vec2 tu0coord;

uniform sampler2D tu0_2D; //full scene color
//uniform sampler2D tu1_2D; //log luminance map
uniform float contrast;

/*uniform vec3 frustum_corner_bl;
uniform vec3 frustum_corner_br_delta;
uniform vec3 frustum_corner_tl_delta;

varying vec3 eyespace_view_direction;*/

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

const vec3 LUMINANCE = vec3(0.2125, 0.7154, 0.0721);

/*const float scale = 0.1;
const float offset = 5.;
const float scale_tiny = 3.0;
const float offset_tiny = -0.12;*/

const float scale = 0.25;
const float offset = 2.0;

void main()
{
	vec3 color = texture2D(tu0_2D, tu0coord).rgb;
	
	//float lod = 8;
	//float geometric_mean = exp((texture2D(tu1_2D, tu0coord).r/scale_tiny-offset_tiny)/scale-offset);
	//float geometric_mean = exp(texture2D(tu1_2D, tu0coord).r/scale-offset);
	float geometric_mean = 0.25;
	//gl_FragColor.rgb = texture2DLod(tu0_2D, tu0coord, lod).rgb;
	
	// reinhard eq 3
	//float a = 0.18;
	float a = 0.25;
	float scalefactor = a/geometric_mean;
	color *= scalefactor*contrast;
	
	/*if (gl_FragCoord.x < 100)
		color = vec3(1,1,1)*texture2D(tu1_2D, tu0coord).r;
	else if (gl_FragCoord.x < 200)
		color = vec3(1,1,1)*(geometric_mean);*/
	
	gl_FragColor.rgb = UnGammaCorrect(color);
	//gl_FragColor.rgb = texture2D(tu1_2D, tu0coord).rgb;
	gl_FragColor.a = 1.;
	
	
	// this is a great shader to put debug stuff into
	/*vec2 screen = vec2(SCREENRESX,SCREENRESY);
	vec2 screenspace_uv = gl_FragCoord.xy/screen;
	vec3 viewdir = frustum_corner_bl + frustum_corner_br_delta*screenspace_uv.x + frustum_corner_tl_delta*screenspace_uv.y;
	gl_FragColor.rgb = vec3(1,1,1)*distance(viewdir,eyespace_view_direction);*/
	// retrieve g-buffer
	//float gbuf_depth = texture2D(tu0_2D, screenspace_uv).r;
	//vec3 viewdir = frustum_corner_bl + frustum_corner_br_delta*screenspace_uv.x + frustum_corner_tl_delta*screenspace_uv.y;
	//float eyespace_z = qn / (gbuf_depth * -2.0 + 1.0 - q); //http://www.opengl.org/discussion_boards/ubbthreads.php?ubb=showflat&Number=277938
	//vec3(viewdir.xy/viewdir.z*eyespace_z,eyespace_z); //http://lumina.sourceforge.net/Tutorials/Deferred_shading/Point_light.html
}
