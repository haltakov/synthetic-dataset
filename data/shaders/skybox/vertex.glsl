varying vec2 tu0coord;
varying vec4 ecposition;
varying vec3 normal_eye;

void main()
{
	// Transforming the vertex
	ecposition = gl_Vertex;
	
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	
	// Setting the color
	gl_FrontColor = gl_Color;
	
	normal_eye = gl_NormalMatrix * gl_Normal;
	
	tu0coord = vec2(gl_MultiTexCoord0);
}
