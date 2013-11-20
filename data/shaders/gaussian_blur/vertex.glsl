varying vec2 texcoord_2d;

void main()
{
	gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;
	texcoord_2d = vec2(gl_MultiTexCoord0);
}
