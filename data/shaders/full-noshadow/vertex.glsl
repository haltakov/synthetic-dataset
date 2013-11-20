varying vec2 texcoord_2d;
varying vec3 normal_eye;
varying vec3 viewdir;

void main()
{
	//transform the vertex
	gl_Position = ftransform();
	
	//set the color
	gl_FrontColor = gl_Color;
	
	//set the texture coordinates
	texcoord_2d = vec2(gl_MultiTexCoord0);
	
	//compute the eyespace normal
	normal_eye = gl_NormalMatrix * gl_Normal;
	
	//compute the eyespace position
	vec4 ecposition = gl_ModelViewMatrix * gl_Vertex;
	
	//compute the eyespace view direction
	viewdir = vec3(ecposition)/ecposition.w;
}
