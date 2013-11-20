#ifdef _SHADOWS_
varying vec4 projshadow_0;
#ifdef _CSM2_
varying vec4 projshadow_1;
#endif
#ifdef _CSM3_
varying vec4 projshadow_2;
#endif
#endif

uniform vec3 lightposition;

varying vec2 texcoord_2d;
varying vec3 V, N;
varying vec3 refmapdir, ambientmapdir;

void main()
{
	//transform the vertex
    vec4 pos = gl_ModelViewMatrix * gl_Vertex;
	gl_Position = gl_ProjectionMatrix * pos;
    vec3 pos3 = pos.xyz;
 
	#ifdef _SHADOWS_
	projshadow_0 = gl_TextureMatrix[4] * gl_TextureMatrixInverse[3] * pos;
	#ifdef _CSM2_
	projshadow_1 = gl_TextureMatrix[5] * gl_TextureMatrixInverse[3] * pos;
	#endif
	#ifdef _CSM3_
	projshadow_2 = gl_TextureMatrix[6] * gl_TextureMatrixInverse[3] * pos;
	#endif
	#endif
	
	//set the color
	gl_FrontColor = gl_Color;
	
	//set the texture coordinates
	texcoord_2d = vec2(gl_MultiTexCoord0);
	
	//compute the eyespace normal
	N = normalize(gl_NormalMatrix * gl_Normal);
    V = normalize(-pos3);
    //R = normalize(reflect(pos3,N));
    
    #ifndef _REFLECTIONDISABLED_
    refmapdir = vec3(gl_TextureMatrix[2] * vec4(reflect(pos3, N),0));
    #else
    refmapdir = vec3(0.);
    #endif
    
    ambientmapdir = mat3(gl_TextureMatrix[2]) * N;
}
