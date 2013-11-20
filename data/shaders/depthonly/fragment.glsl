//varying float lightdotnorm;
//uniform float depthoffset;
uniform sampler2D tu0_2D;
varying vec2 texcoord;
varying vec3 eyespacenormal;

void main()
{
	//float depthoffset = mix(0.01,0.0001,eyespacenormal.z*eyespacenormal.z);
	//float depthoffset = mix(0.005,0.001,eyespacenormal.z);
	
	gl_FragDepth = gl_FragCoord.z;
	vec4 tu0color = texture2D(tu0_2D, texcoord);
	gl_FragColor = tu0color;
	
	//gl_FragDepth = gl_FragCoord.z + mix(0.007,0.0009,lightdotnorm);
	//gl_FragDepth = gl_FragCoord.z + mix(0.0009,0.007,lightdotnorm);
}
