#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect tu0_2DRect;
//uniform sampler2D tu1_2D;
uniform float blurfactor;
//uniform float screenratio;
//uniform float screenratio_over2;
uniform float screenw;
uniform float screenh;
uniform float samples;
uniform float sm1inv;
uniform float w;

varying vec4 oldpos;
varying vec4 newpos;

void main()
{
	vec3 newpos2 = newpos.xyz / newpos.w;
	vec3 oldpos2 = oldpos.xyz / oldpos.w;
	vec2 vel2 = newpos2.xy - oldpos2.xy;
	vel2 = vel2 * blurfactor;
	vel2 = clamp(vel2, -0.1, 0.1);
	//vel2 = vec2(0.1,0.0);
	vel2.x *= screenw;
	vel2.y *= screenh;
	
	vec2 screenover2 = vec2(screenw,screenh)*0.5;
	vec2 t = screenover2 + screenover2 * (newpos2.xy);
	
	vec4 a = vec4(0.0,0.0,0.0,0.0);

	//vec2 noiset = vec2(t.x/screenw,t.y/screenh);
	//float mynoise = (texture2D(tu1_2D,noiset).r-0.5)*0.5;
	
	for (float i = 0.0; i < samples; i++)
	{
		//float ds = (i+mynoise) * (sm1inv);
		float ds = i * sm1inv;
		vec2 tc = t+vel2*(ds-0.5);
		a += texture2DRect(tu0_2DRect,tc)*w;
	}
	
	gl_FragColor = a;
}
