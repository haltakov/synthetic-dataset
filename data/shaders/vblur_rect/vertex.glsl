varying vec2 texcoord_2d;

void main()
{
	gl_Position = ftransform();
	texcoord_2d = vec2(gl_MultiTexCoord0);
}
