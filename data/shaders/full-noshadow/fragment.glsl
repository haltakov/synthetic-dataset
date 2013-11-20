#version 120

uniform sampler2D tu0_2D; //diffuse map
uniform sampler2D tu1_2D; //misc map (includes gloss on R channel, ...
//uniform sampler2DShadow tu4_2D; //close shadow map
//uniform sampler2DShadow tu5_2D; //far shadow map
#ifndef _REFLECTIONDISABLED_
uniform samplerCube tu2_cube; //reflection map
#endif
uniform sampler2D tu6_2D; //additive map (for brake lights)

uniform vec3 lightposition;

varying vec2 texcoord_2d;
varying vec3 normal_eye;
varying vec3 viewdir;
//varying vec4 projshadow_0;
//varying vec4 projshadow_1;

void main()
{
	float notshadowfinal = 1.0;
	
	vec3 normnormal = normalize(normal_eye);
	vec3 normviewdir = normalize(viewdir);
	vec3 normlightposition = normalize(lightposition);
	
	vec4 tu0_2D_val = texture2D(tu0_2D, texcoord_2d);
	vec4 tu1_2D_val = texture2D(tu1_2D, texcoord_2d);
	vec4 tu6_2D_val = texture2D(tu6_2D, texcoord_2d);
	
	vec3 texcolor = tu0_2D_val.rgb;
	float gloss = tu1_2D_val.r;
	float metallic = tu1_2D_val.g;
	
	float difdot = dot(normnormal,normlightposition);
	
	vec3 diffuse = texcolor*max(difdot,0.0)*notshadowfinal;
	
	vec3 ambient = texcolor;//*(1.0+min(difdot,0.0));
	
	float specval = max(dot(reflect(normviewdir,normnormal),normlightposition),0.0);
	//vec3 halfvec = normalize(normviewdir + normlightposition);
	//float specval = max(0.0,dot(normnormal,halfvec));
	
	float env_factor = min(pow(1.0-max(0.0,dot(-normviewdir,normnormal)),3.0),0.6)*0.75+0.2;
	
	float spec = ((max((pow(specval,512.0)-0.5)*2.0,0.0))*metallic+pow(specval,12.0)*(0.4+(1.0-metallic)*0.8))*gloss;
	vec3 refmapdir = reflect(normviewdir,normnormal);
	refmapdir = mat3(gl_TextureMatrix[2]) * refmapdir;
	
	#ifndef _REFLECTIONDISABLED_
	vec3 specular_environment = textureCube(tu2_cube, refmapdir).rgb*metallic*env_factor;
	#else
	vec3 specular_environment = vec3(0,0,0);
	#endif
	float inv_environment = 1.0 - (env_factor*metallic);
	
	float invgloss = (1.0-gloss);
	
	vec3 finalcolor = (ambient*0.5 + diffuse*0.8*max(0.7,invgloss))*(inv_environment*0.5+0.5) + vec3(spec)*notshadowfinal + specular_environment*max(0.5,notshadowfinal) + tu6_2D_val.rgb;
	
	//do post-processing
	finalcolor = clamp(finalcolor,0.0,1.0);
	finalcolor = ((finalcolor-0.5)*1.2)+0.5;
	
	gl_FragColor.rgb = finalcolor;
	//gl_FragColor.rgb = vec3(pow(specval,1.0));
	//gl_FragColor.rgb = textureCube(tu2_cube, refmapdir).rgb;
	//gl_FragColor.rgb = normviewdir;
	//gl_FragColor.rgb = normnormal;
	//gl_FragColor.rgb = vec3(max(dot(normnormal,normalize(vec3(gl_LightSource[0].position))),0.0));
	//gl_FragColor.rgb = normlightposition;
	//gl_FragColor.rgb = vec3(max(dot(normnormal,normlightposition),0.0));
	//gl_FragColor.rgb = tu0_2D_val.rgb;
	//gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0);
	
	gl_FragColor.a = tu0_2D_val.a*gl_Color.a;
}
