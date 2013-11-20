uniform sampler2DRect tu0_2DRect;
varying vec2 texcoord_2d;
uniform float screenw;
uniform float screenh;
uniform float blurfactorx;

void main()
{
	vec2 tc = texcoord_2d;
	tc.x *= screenw;
	tc.y *= screenh;
	
	//vec4 tu0_2D_val = texture2DRect(tu0_2DRect, tc);
	
	vec4 final = vec4(0.0, 0.0, 0.0, 0.0);

	/*final += 0.015625 * texture2DRect(tu0_2DRect, tc + vec2(0.0, -3.0) );
	final += 0.09375 * texture2DRect(tu0_2DRect, tc + vec2(0.0, -2.0) );
	final += 0.234375 * texture2DRect(tu0_2DRect, tc + vec2(0.0, -1.0) );
	final += 0.3125 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 0.0) );
	final += 0.234375 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 1.0) );
	final += 0.09375 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 2.0) );
	final += 0.015625 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 3.0) );*/
	
	/*final += 0.015625 * texture2DRect(tu0_2DRect, tc + vec2(-3.0*d, 0.0) );
	final += 0.09375 * texture2DRect(tu0_2DRect, tc + vec2(-2.0*d, 0.0) );
	final += 0.234375 * texture2DRect(tu0_2DRect, tc + vec2(-1.0*d, 0.0) );
	final += 0.3125 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 0.0) );
	final += 0.234375 * texture2DRect(tu0_2DRect, tc + vec2(1.0*d, 0.0) );
	final += 0.09375 * texture2DRect(tu0_2DRect, tc + vec2(2.0*d, 0.0) );
	final += 0.015625 * texture2DRect(tu0_2DRect, tc + vec2(3.0*d, 0.0) );*/
	
	/*final += 0.02763056 * texture2DRect(tu0_2DRect, tc + vec2(-4.0, 0.0) );
	final += 0.06628226 * texture2DRect(tu0_2DRect, tc + vec2(-3.0, 0.0) );
	final += 0.12383157 * texture2DRect(tu0_2DRect, tc + vec2(-2.0, 0.0) );
	final += 0.18017387 * texture2DRect(tu0_2DRect, tc + vec2(-1.0, 0.0) );
	final += 0.20416374 * texture2DRect(tu0_2DRect, tc + vec2(0.0, 0.0) );
	final += 0.18017387 * texture2DRect(tu0_2DRect, tc + vec2(1.0, 0.0) );
	final += 0.12383157 * texture2DRect(tu0_2DRect, tc + vec2(2.0, 0.0) );
	final += 0.06628226 * texture2DRect(tu0_2DRect, tc + vec2(3.0, 0.0) );
	final += 0.02763056 * texture2DRect(tu0_2DRect, tc + vec2(4.0, 0.0) );*/
	
	final += 0.08167442 * texture2DRect(tu0_2DRect, tc + vec2(-4.0, 0.0)*blurfactorx );
	final += 0.10164545 * texture2DRect(tu0_2DRect, tc + vec2(-3.0, 0.0)*blurfactorx );
	final += 0.11883558 * texture2DRect(tu0_2DRect, tc + vec2(-2.0, 0.0)*blurfactorx );
	final += 0.13051535 * texture2DRect(tu0_2DRect, tc + vec2(-1.0, 0.0)*blurfactorx );
	final += 0.13465835 * texture2DRect(tu0_2DRect, tc );
	final += 0.13051535 * texture2DRect(tu0_2DRect, tc + vec2(1.0, 0.0)*blurfactorx );
	final += 0.11883558 * texture2DRect(tu0_2DRect, tc + vec2(2.0, 0.0)*blurfactorx );
	final += 0.10164545 * texture2DRect(tu0_2DRect, tc + vec2(3.0, 0.0)*blurfactorx );
	final += 0.08167442 * texture2DRect(tu0_2DRect, tc + vec2(4.0, 0.0)*blurfactorx );
	
	/*const float samples = 20.0;
	const float sinv = 1.0 / samples;
	
	for (float i = -10.0; i < 11.0; i++)
	{
		final += sinv * texture2DRect(tu0_2DRect, tc + vec2(i, 0.0) );
	}*/
	
	gl_FragColor = final;
}
