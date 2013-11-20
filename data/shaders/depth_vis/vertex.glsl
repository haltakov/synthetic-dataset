varying float z;
varying vec2 texcoord;

void main()
{
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	
	texcoord = vec2(gl_MultiTexCoord0);
	
	z = gl_Position.w;
}