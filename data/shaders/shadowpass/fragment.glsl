//varying vec3 normal;
varying vec2 texcoord_2d;
uniform sampler2DShadow tu0_2D;
uniform sampler2DShadow tu1_2D;
uniform sampler2DShadow tu2_2D;
uniform sampler2D tu3_2D;

varying vec4 projshadow_0;
varying vec4 projshadow_1;
varying vec4 projshadow_2;
varying vec4 projshadow_3;

/*varying vec3 eyecoords;
varying vec3 eyespacenormal;*/

void main()
{
	float alpha = texture2D(tu3_2D, texcoord_2d).a;
	
	vec3 shadowcoords[3];
	shadowcoords[0] = projshadow_0.xyz;
	shadowcoords[1] = projshadow_1.xyz;
	shadowcoords[2] = projshadow_2.xyz;
	//shadowcoords[3] = projshadow_3.xyz;
	//samp[3] = tu3_2D;
	float notshadow[3];
	
	/*notshadow[0] = shadow2DProj(tu0_2D, projshadow_0).r;
	notshadow[1] = shadow2DProj(tu1_2D, projshadow_1).r;
	notshadow[2] = shadow2DProj(tu2_2D, projshadow_2).r;
	notshadow[3] = shadow2DProj(tu3_2D, projshadow_3).r;*/
	
	notshadow[0] = shadow2D(tu0_2D, shadowcoords[0]).r;
	notshadow[1] = shadow2D(tu1_2D, shadowcoords[1]).r;
	notshadow[2] = shadow2D(tu2_2D, shadowcoords[2]).r;
	
	/*const float ep = 0.0009765;
	for (int i = 0; i < 3; i++)
	{
		notshadow[i] = shadow2D(samp[i], shadowcoords[i]).r;
		
		//2X2 PCF
		//notshadow[i] += shadow2D(samp[i], shadowcoords[i]+vec3(ep,ep,0.0)).r;
		//notshadow[i] += shadow2D(samp[i], shadowcoords[i]+vec3(ep,-ep,0.0)).r;
		//notshadow[i] += shadow2D(samp[i], shadowcoords[i]+vec3(-ep,-ep,0.0)).r;
		//notshadow[i] += shadow2D(samp[i], shadowcoords[i]+vec3(-ep,ep,0.0)).r;
		//notshadow[i] *= 0.25;
	}*/
	
	//float notshadow = shadow2D(tu2_2D, projshadow).r;
	/*float notshadow = 0.0;
	const float ep = 0.000488;
	vec3 projshadow3 = vec3(projshadow);
	
	//2X2 PCF
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep,ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep,-ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep,-ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep,ep,0.0)).r;
	notshadow *= 0.25;*/
	
	//3X3 PCF
	/*notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep,ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep,0.0,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep,-ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(0.0,-ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep,-ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep,0.0,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep,ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(0.0,ep,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3).r;
	notshadow *= 0.11111111;*/
	
	/*//2X2 dithered PCF
	vec2 o = mod(floor(gl_FragCoord.xy),2.0)*ep*2.0;
	const float ep3 = ep*3.0;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep3+o.x,ep3+o.y,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep+o.x,ep3+o.y,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(-ep3+o.x,-ep+o.y,0.0)).r;
	notshadow += shadow2D(tu2_2D, projshadow3+vec3(ep3+o.x,-ep+o.y,0.0)).r;
	notshadow *= 0.25;*/
	
	//fade in shadows
	/*const float bound = 1.0;
	vec2 shadowcoords[4];
	shadowcoords[0] = projshadow_0.xy;
	shadowcoords[1] = projshadow_1.xy;
	shadowcoords[2] = projshadow_2.xy;
	shadowcoords[3] = projshadow_3.xy;
	const float fade = 10.0;
	//const float fade = 2.0;
	float effect[4];
	
	for (int i = 0; i < 4; ++i)
	{
		shadowcoords[i].x = clamp(shadowcoords[i].x, 0.0, bound);
		shadowcoords[i].y = clamp(shadowcoords[i].y, 0.0, bound);
		float xf1 = 1.0-min(1.0,shadowcoords[i].x*fade);
		float xf2 = max(0.0,shadowcoords[i].x*fade-(fade-1.0));
		float yf1 = 1.0-min(1.0,shadowcoords[i].y*fade);
		float yf2 = max(0.0,shadowcoords[i].y*fade-(fade-1.0));
		effect[i] = max(xf1,max(xf2,max(yf1,yf2)));
		//notshadow[i] = max(notshadow[i],effect[i]);
	}*/
	
	/*const float bound = 1.0;
	vec3 shadowcoords[4];
	shadowcoords[0] = projshadow_0.xyz;
	shadowcoords[1] = projshadow_1.xyz;
	shadowcoords[2] = projshadow_2.xyz;
	shadowcoords[3] = projshadow_3.xyz;
	const float fade = 10.0;
	//const float fade = 2.0;
	float effect[4];
	
	for (int i = 0; i < 4; ++i)
	{
		//vec3 one = vec3(1.0);
		shadowcoords[i] = clamp(shadowcoords[i], 0.0, bound);
		vec3 f1 = vec3(1.0) - min(vec3(1.0),shadowcoords[i]*fade);
		vec3 f2 = max(vec3(0.0),shadowcoords[i]*fade-vec3(fade-1.0));
		vec3 veffect = max(f1,f2);
		effect[i] = max(veffect.x,max(veffect.y,veffect.z));
		//notshadow[i] = max(notshadow[i],effect[i]);
	}*/
	
	const float bound = 1.0;
	const float fade = 10.0;
	//const float fade = 2.0;
	float effect[3];
	
	for (int i = 0; i < 3; ++i)
	//for (int i = 3; i < 4; ++i)
	{
		shadowcoords[i] = clamp(shadowcoords[i], 0.0, bound);
		float xf1 = 1.0-min(1.0,shadowcoords[i].x*fade);
		float xf2 = max(0.0,shadowcoords[i].x*fade-(fade-1.0));
		float yf1 = 1.0-min(1.0,shadowcoords[i].y*fade);
		float yf2 = max(0.0,shadowcoords[i].y*fade-(fade-1.0));
		float zf1 = 1.0-min(1.0,shadowcoords[i].z*fade);
		float zf2 = max(0.0,shadowcoords[i].z*fade-(fade-1.0));
		effect[i] = max(xf1,max(xf2,max(yf1,max(yf2,max(zf1,zf2)))));
		//notshadow[i] = max(notshadow[i],effect[i]);
	}
	
	float notshadowfinal = notshadow[0];
	notshadowfinal = mix(notshadowfinal,notshadow[1],effect[0]);
	notshadowfinal = mix(notshadowfinal,notshadow[2],effect[1]);
	notshadowfinal = max(notshadowfinal,effect[2]);
	//notshadowfinal = mix(notshadowfinal,notshadow[3],effect[2]);
	//notshadowfinal = max(notshadowfinal,effect[3]);
	//float notshadowfinal = min(notshadow[0],min(notshadow[1],min(notshadow[2],max(notshadow[3],effect[3]))));
	/*float notshadowfinal = 1.0 - ( (1.0-notshadow[0])*(1.0-effect[0]) + 
			(1.0-notshadow[1])*(1.0-effect[1]) + 
			(1.0-notshadow[2])*(1.0-effect[2]) + 
			(1.0-notshadow[3])*(1.0-effect[3]) );*/
	
	/*vec3 texcolor = tu0_2D_val.rgb;
	vec3 ambient = texcolor;
	//vec3 diffuse = texcolor*clamp((dot(normal,lightposition)+1.0)*0.7,0.0,1.0);
	float difdot = max(dot(normal,lightposition),0.0);
	//notshadow *= min(difdot*10.0,1.0);
	//notshadow *= 1.0-difdot;
	difdot *= notshadow;
	vec3 diffuse = texcolor*difdot;
	vec3 refnorm = normalize(reflect(eyecoords,eyespacenormal));
	//vec3 halfvec = normalize(eyecoords + lightposition);
	//vec3 specular = vec3(pow(clamp(dot(refnorm,lightposition),0.0,1.0),8.0)*0.2);
	float specval = max(dot(refnorm, lightposition),0.0);
	//vec3 specular = vec3(pow(specval,4.0)*0.2);
	float gloss = tu1_2D_val.r;
	vec3 specular = vec3((pow(specval,128.0)*0.4+pow(specval,4.0)*0.2)*gloss);
	//vec3 specular = vec3(pow(specval,16.0)*0.2);*/
	
	//vec3 reflight = reflect(lightposition,normal);
	//vec3 specular = vec3(max(dot(eyecoords, reflight),0.0));
	
	gl_FragColor.rgb = vec3(notshadowfinal,notshadowfinal,notshadowfinal);
	//gl_FragColor.a = 1.0-notshadowfinal;
	gl_FragColor.a = alpha;
	//gl_FragColor.rgb = ambient*0.5 + diffuse*1.0 + specular*notshadow;
	//gl_FragColor.rgb = vec3(1,1,1)*(projshadow.z/projshadow.w);
	//gl_FragColor.rgb = projshadow.xyz/projshadow.w;
	//gl_FragColor = texture2DProj(tu2_2D,projshadow);
	//gl_FragColor.rgb = specular;
	//gl_FragColor.rgb = eyecoords;
	//vec3 halfvec = normalize(eyecoords + lightposition);
	//float NdotHV = max(dot(normal, halfvec),0.0);
	//gl_FragColor.rgb = vec3(specular);
	//gl_FragColor.rgb = vec3(dot(lightposition,normal));
	//gl_FragColor.rgb = vec3(normal.y);
}
