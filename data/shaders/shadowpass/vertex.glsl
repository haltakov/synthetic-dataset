varying vec2 texcoord_2d;
/*varying vec3 normal;
varying vec3 eyespacenormal;
varying vec3 eyecoords;*/

varying vec4 projshadow_0;
varying vec4 projshadow_1;
varying vec4 projshadow_2;
varying vec4 projshadow_3;

uniform mat4 light_matrix_0;
uniform mat4 light_matrix_1;
uniform mat4 light_matrix_2;
uniform mat4 light_matrix_3;

void main()
{
	//transform the vertex
	gl_Position = ftransform();
	
	//setup for shadow pass
	projshadow_0 = light_matrix_0 * (gl_TextureMatrix[1] * (gl_ModelViewMatrix * gl_Vertex));
	//projshadow_0 = gl_TextureMatrix[2] * (gl_TextureMatrix[1] * (gl_ModelViewMatrix * gl_Vertex));
	projshadow_1 = light_matrix_1 * (gl_TextureMatrix[1] * (gl_ModelViewMatrix * gl_Vertex));
	projshadow_2 = light_matrix_2 * (gl_TextureMatrix[1] * (gl_ModelViewMatrix * gl_Vertex));
	//projshadow_3 = light_matrix_3 * (gl_TextureMatrix[1] * (gl_ModelViewMatrix * gl_Vertex));
	
	texcoord_2d = vec2(gl_MultiTexCoord0);
	
	/*//set the normal, eyespace normal, and eyespace position
	eyespacenormal = normalize(gl_NormalMatrix * gl_Normal);
	normal = (mat3(gl_TextureMatrix[1]) * gl_NormalMatrix) * gl_Normal;
	
	vec4 ecpos = gl_ModelViewMatrix * gl_Vertex;
	eyecoords = vec3(ecpos) / ecpos.w;
	eyecoords = normalize(eyecoords);*/
}
