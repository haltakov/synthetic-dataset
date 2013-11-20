uniform vec3 lightposition;

varying vec2 tu0coord;
varying vec3 N;
varying vec3 V;

void main()
{
	// Transforming the vertex
	vec4 pos = gl_ModelViewMatrix * gl_Vertex;
	gl_Position = gl_ProjectionMatrix * pos;
	vec3 pos3 = pos.xyz;
	V = pos3;
	
	// Setting the color
	gl_FrontColor = gl_Color;
	
	tu0coord = vec2(gl_MultiTexCoord0);
	
	// transform normal into eye-space
	N = normalize(gl_NormalMatrix * gl_Normal);
}
