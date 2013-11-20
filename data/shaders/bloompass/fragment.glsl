#extension GL_ARB_texture_rectangle : enable

uniform sampler2DRect tu0_2DRect;
varying vec2 texcoord_2d;

vec3 ContrastSaturationBrightness(vec3 color, float con, float sat, float brt)
{
	// Increase or decrease theese values to adjust r, g and b color channels seperately
	const float AvgLumR = 0.5;
	const float AvgLumG = 0.5;
	const float AvgLumB = 0.5;
	
	const vec3 LumCoeff = vec3(0.2125, 0.7154, 0.0721);
	
	vec3 AvgLumin = vec3(AvgLumR, AvgLumG, AvgLumB);
	vec3 brtColor = color * brt;
	vec3 intensity = vec3(dot(brtColor, LumCoeff));
	vec3 satColor = mix(intensity, brtColor, sat);
	vec3 conColor = mix(AvgLumin, satColor, con);
	return conColor;
}

void main()
{
	//vec2 tc = vec2(gl_FragCoord.x, gl_FragCoord.y);
	vec2 tc = vec2(texcoord_2d.x, texcoord_2d.y);
	vec4 tu0_2D_val = texture2DRect(tu0_2DRect, tc);
	
	vec3 orig = tu0_2D_val.rgb;
	
	/*const float onethird = 1./3.;
	float luminance = dot(orig,vec3(onethird,onethird,onethird));
	float scaled = max(0.,luminance-.8)*(1.0/0.2);
	vec3 final = vec3(scaled);*/
	//vec3 final = orig;
	
	//vec3 final = pow(orig, vec3(4.0))*2.;
	vec3 final = ContrastSaturationBrightness(orig, 8.0, 0.1, 0.7);
	
	//vec3 final = orig * blurred;
	/*vec3 blurred = orig;
	float blurred_grey = (blurred.r*0.25+blurred.g*0.5+blurred.b*0.25)*0.8+0.2;
	blurred = vec3(blurred_grey,blurred_grey,blurred_grey);
	vec3 final = orig*(orig + 2.0*blurred*(1.0-orig)); //"OVERLAY"*/
	//vec3 final = blurred;
	gl_FragColor = vec4(final,1.);
}
