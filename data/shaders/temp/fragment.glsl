uniform sampler2D tu0_2D;
uniform sampler2D tu1_2D;
uniform float blurfactor;
uniform float screenratio;
uniform float screenratio_over2;
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
	//vel2 = vel2 * 0.25;
	vel2 = vel2 * blurfactor;
	//vel2 = vel2 * 0.0;
	vel2 = clamp(vel2, -0.1, 0.1);
	//vel2 = vec2(0.1,0.0);
	
	//vec2 t = vec2(0.5,0.5) + vec2(0.5,0.5) * (newpos2.xy);
	//t = t * vec2(1.0,0.75);
	vec2 t = vec2(0.5,screenratio_over2) + vec2(0.5,0.375) * (newpos2.xy); //TODO:  0.5,0.375 is related to the screen ratio, replace it w/ actual values passed from the CPU
	
	//const float samples = 8.0;
	//const float sm1inv = 1.0/(8.0-1.0); //= 1.0/(samples-1.0);
	//const float w = 0.125; //= 1.0 / samples;
	vec4 a = vec4(0.0,0.0,0.0,0.0);
	/*float mynoise[8];
	vec4 myn1 = texture2D(tu1_2D,(t)*10.0);
	mynoise[0] = myn1.r;
	mynoise[1] = myn1.g;
	mynoise[2] = myn1.b;
	mynoise[3] = myn1.a;
	myn1 = texture2D(tu1_2D,(t)*10.0);
	mynoise[0] = myn1.r;
	mynoise[1] = myn1.g;
	mynoise[2] = myn1.b;
	mynoise[3] = myn1.a;*/
	//float mynoise = texture2D(tu1_2D,t*10.0).r;
	float mynoise = (texture2D(tu1_2D,t*5.0).r-0.5)*2.0;
	//float mynoise = texture2D(tu1_2D,t).r;
	//float mynoise = texture2D(tu1_2D,newpos2.xy*5.0).r;
	
	for (float i = 0.0; i < samples; i++)
	{
		//float ds = i / (samples - 1.0);
		//float ds = (i+noise1(t.x+i+vel2.x)) / (samples - 1.0);
		//vec2 mynoise = texture2D(tu1_2D,t+vec2(i,i)+vel2+normal.xy+eyespacenormal.xy).rg;
		//float mynoise = texture2D(tu1_2D,t+vec2(i,i)+vel2+normal.xy+eyespacenormal.xy).r;
		//float mynoise = texture2D(tu1_2D,(t+vec2(i,i)+vel2+normal.xy+eyespacenormal.xy)*5.0).r;
		//float mynoise = texture2D(tu1_2D,(t)*10.0).r;
		//float mynoise = texture2D(tu1_2D,(t+vec2(i,i))*5.0).r;
		//float ds = (i+(mynoise-0.5)*2.0) / (samples - 1.0);
		//float ds = (i+mynoise) / (samples - 1.0);
		float ds = (i+mynoise) * (sm1inv);
		//a = a + texture2D(tu0_2D,t+vel2*ds-vel2*0.5)*w;
		vec2 tc = t+vel2*(ds-0.5);
		//tc.y = min(0.749,tc.y); //TODO:  0.749 is related to the screen ratio, replace it w/ actual values passed from the CPU
		tc.y = min(screenratio,tc.y);
		a = a + texture2D(tu0_2D,tc)*w;
		//a = a + texture2D(tu0_2D,t+vel2*ds-vel2)*w;
	}
	
	//gl_FragColor = vec4(vel2,0,1);
	gl_FragColor = a;
	//gl_FragColor = vec4(vec3(1.0,1.0,1.0)*noise1(1.0),1.0);
	//gl_FragColor = texture2D(tu1_2D,t+vec2(i,i)+vel2*10.0);
	//gl_FragColor = texture2D(tu1_2D,t+vec2(i,i)+vel2+normal.xy+eyespacenormal.xy);
}
